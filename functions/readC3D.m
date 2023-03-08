%% File: readC3D
% Author: ces
% Date: before 2019
% Matlab Version: 2019b
% Description: Function which extracts basic c3d data from biomechanical 
%              trials into a MATLAB structure. Additionally, splits 
%              continuous data into left and right gait cycles if gait 
%              events are available.
%
% Usage: Run 'Gait Parameter Extraction' script which contains this 
%        function or run this function without arguments to test it on a 
%        user selected single trial (c3d file)
%
% Input: file - Full filename (with path) of a single c3d file
%        environmentType - character string being either 'Overground' or 
%                          'Treadmill'
%
% Output: S - MATLAB structure containing extracted c3d parameters
%
% Other files required: Biomechanical ToolKit (BTK)
% Other m-files required: correctMovementDirection.m, 
% removeExtraSubjects.m, detectRepeatEvents.m, detectFalseSteps.m,
% segmentSteps.m
%
% Date        Author      Revision
% 20190830    MBan        Commented & cleaned up
% 20190927    CMey&MBan   Added automatic event setting (Zeni)
% 20191128    MBan        Added distinction between treadmill and overground
%

%% ------------------- BEGIN CODE -------------------

function [S] = readC3D(file, eventsAutomaticZeni, environmentType)

% Debugging: Let user select a c3d file if no input argument is given
if nargin < 1 %if number of arguments is smaller than 1
    % Let user select a c3d file
    [file, folder] = uigetfile('*.c3d');
    % Check if user selected a file
    if (folder == 0)
        % Interrupt script execution if user provides no c3d file
        error('User cancelled file selection - parameter extraction cancelled.')
    end
    % Create full filename
    file = fullfile(folder, file);
    % Add default values
    saveRequired = true;
    eventsAutomaticZeni = 'Manual';
    environmentType = 'Treadmill';
else
    % Set flag to not save data
    saveRequired = false;
end


%% C3D Data Readout
% Acquire handle to current file
c3d = btkReadAcquisition(file);

% Read out analog, angular, marker position, event and general data
S = struct('analog', btkGetAnalogs(c3d), 'angs', btkGetAngles(c3d), ...
    'points', btkGetMarkers(c3d), 'evts', btkGetEvents(c3d), ...
    'stats', btkGetMetaData(c3d));

% Initialize error structure
S.errors = {};

% Obtain analog and marker position frequencies
S.stats.pointFq = btkGetPointFrequency(c3d);
S.stats.analogFq = btkGetAnalogFrequency(c3d);

% Obtain first and last trial frames
S.stats.firstFrame = btkGetFirstFrame(c3d);
S.stats.lastFrame = btkGetLastFrame(c3d) - (S.stats.firstFrame - 1); %last  
% trial frame is based on frame 1 even if frames were cut off

% Obtain trial name
S.stats.trialName = file;

% Obtain subject name
S.stats.subjectName = btkGetMetaData(c3d, 'SUBJECTS', 'NAMES');
S.stats.subjectName = S.stats.subjectName.info.values;

% Obtain subject weight
try
    S.stats.bodyweight = S.stats.children.PROCESSING.children.Bodymass.info.values;
catch
    S.stats.bodyweight = 0;
    S.errors{end+1} = 'Bodyweight not extractable';
end


%% Data Clean Up
% Add a SACR marker if not already there
if ~isfield(S.points, 'SACR')
    S.points.SACR = (S.points.LPSI + S.points.RPSI) ./2;
    S.errors(end+1) = {'SACR Marker interpolated as (RPSI + LPSI)./2'};
end

% Rename CoM marker if it exists
if (isfield(S.points, 'CentreOfMass') && ~isfield(S.points, 'CoM'))
    S.points.CoM = S.points.CentreOfMass;
    S.points = rmfield(S.points,'CentreOfMass');
end

% Add a FLOAT end-effector marker if FLOAT markers exist
if (isfield(S.points, 'FLOATA') && isfield(S.points, 'FLOATP') && ...
        isfield(S.points, 'FLOATR') && isfield(S.points, 'FLOATL'))
    S.points.FLOAT = (S.points.FLOATA + S.points.FLOATP + ...
        S.points.FLOATR + S.points.FLOATL) / 4;
end

% Remove any additional subjects that are registered in the marker names
for iSubj = 1:length(S.stats.subjectName)
    [S.points, ~] = removeExtraSubjects(S.points, S.stats.subjectName{iSubj});
end

% Correct movement direction to Y+ and store transformation parameters
[S] = correctMovementDirection(S, environmentType);


%% EMG Synchronization

% If EMG data is used
if (false) %TODO: Let user decide if EMG data should be shifted or
    %detect if EMG data is available and not just noise
    
    % Proper approach would be to upsample marker and angle data to sampling
    % frequency of analog data, then aligning of EMG data and other signals by
    % cutting off emgDelay at start of EMG data and cutting off emgDelay at end
    % of marker, angle and non-EMG analog data
    
    % Simplified synchronization
    % Define inherent EMG delay (Myon)
    emgDelay = 0.015; %s (rounded towards 15ms to work easily with default
    % sampling frequencies)
    % Get EMG (analog) sampling time
    tsEMG = 1 / S.stats.analogFq;
    % Calculate how many frames to shift EMG data forward (cut-off start)
    fsEMG_forward = ceil(emgDelay / tsEMG);
    % Calculate how many frames to cut-off at end of marker and angle 
    % signals to realign with EMG signals
    fsPoints_end = ceil(emgDelay*S.stats.pointFq);
    % Calculate how many frames to cut-off at end of synchronous analog 
    % signals (e.g. force plates) to realign with EMG signals
    fsAnalog_end = fsPoints_end
    % Frame-shift EMG (frames to cut-off) at end
%     fsEMG_end = ((fsPoints_end * 1/S.stats.pointFq) - emgDelay)*1000;
%     
%     % Store amount of frames that were cropped
%     S.stats.croppedFrames.true = 1;
%     S.stats.croppedFrames.EMGforward = fsEMG_forward;
%     S.stats.croppedFrames.EMGend = fsEMG_end;
%     S.stats.croppedFrames.Pointsstart = 0;
%     S.stats.croppedFrames.Pointsend = fsPoints_end;

    % Event data and last frame have to be adapted if signals are cropped
%     
%     % Get list of all analog devices
%     fieldsAnalog = fieldnames(S.analog);
%     % Find EMG channels
%     emgFields = find(contains(fieldsAnalog,'Voltage'));
%     % Iterate over all EMG channels
%     for iAnalog = 1:length(emgFields)
%         %  Shift EMG data to synchronize with marker data
%         S.analog.(fieldsAnalog{emgFields(iAnalog)}) = S.analog.(fieldsAnalog{emgFields(iAnalog)})(fsEMG_forward:end-fsEMG_end,:);   %cut-off delayed analog data
%     end
    
    % % Get list of all markers
    % fieldsPoints = fieldnames(S.points);
    % % Iterate over all marker points
    % for iPoints = 1:length(fieldsPoints)
    %     %  Shift marker data to synchronize with EMG data
    %     S.points.(fieldsPoints{iPoints}) = S.points.(fieldsPoints{iPoints})(1:end-fsPoints_end,:);   %cut-off delayed analog data
    % end
    %
    % % Get list of all angular data
    % fieldsAngles = fieldnames(S.angs);
    % % Iterate over all angles
    % for iAngs = 1:length(fieldsAngles)
    %     %  Shift angular data to synchronize with EMG data
    %     S.angs.(fieldsAngles{iAngs}) = S.angs.(fieldsAngles{iAngs})(1:end-fsPoints_end,:);   %cut-off delayed analog data
    % end
    %
    % % Cut last frame to cropped data
    % S.stats.lastFrame = S.stats.lastFrame - fsPoints_end;  
end

% % Change unit of event data
if size(fieldnames(S.evts),1) > 0
    S = eventsToFrames (S); %from seconds to frames
end


%% Event Setting
% Check if events should be set automatic or were set manual
if(~strcmp(eventsAutomaticZeni,'Manual')) %if events should be set 
    % automatic or semi-automatic
    
    % Calculate events based on Zeni
    [RStrikes, LStrikes, ROffs, LOffs] = KinematicEvents(S.points.RHEE, ...
        S.points.LHEE, S.points.RTOE, S.points.LTOE, 0);
    
    % Overwrite existing foot strikes from c3d file only if detection mode
    % was set fully automatic (Zeni)
    if(strcmp(eventsAutomaticZeni,'Zeni'))  
        S.evts.Right_Foot_Strike = RStrikes';
        S.evts.Left_Foot_Strike = LStrikes';
    end
    % Overwrite existing foot offs from c3d file for automatic and
    % semi-automatic detection modes
    S.evts.Right_Foot_Off = ROffs';
    S.evts.Left_Foot_Off = LOffs';

    % Add detected foot strikes and foot offs to c3d
    % WARNING: Known to crash for very large trials (~10min)
    % If foot strikes were not set manually
    if(strcmp(eventsAutomaticZeni,'Zeni'))  
        % Iterate over all foot strikes
        for iEvents = 1:length(RStrikes)
            % Add events to c3d 
            btkAppendEvent(c3d, 'Foot Strike', (RStrikes(iEvents) - 1 + S.stats.firstFrame)/S.stats.pointFq, 'Right', char(S.stats.subjectName), 'Zeni', 1);
        end
        for iEvents = 1:length(LStrikes)
            % Add events to c3d 
            btkAppendEvent(c3d, 'Foot Strike', (LStrikes(iEvents) - 1 + S.stats.firstFrame)/S.stats.pointFq, 'Left', char(S.stats.subjectName), 'Zeni', 1);
        end
    end
    % Iterate over all foot offs
    for iEvents = 1:length(ROffs)
        % Add events to c3d 
        btkAppendEvent(c3d, 'Foot Off', (ROffs(iEvents) - 1 + S.stats.firstFrame)/S.stats.pointFq, 'Right', char(S.stats.subjectName), 'Zeni', 2);
    end
    for iEvents = 1:length(LOffs)
        % Add events to c3d 
        btkAppendEvent(c3d, 'Foot Off', (LOffs(iEvents) - 1 + S.stats.firstFrame)/S.stats.pointFq, 'Left', char(S.stats.subjectName), 'Zeni', 2);
    end
    
    % Store automatic detected events into new c3d file 
    %btkWriteAcquisition(c3d, [file(1:end-4) '_EventsAdded.c3d']);
end


%% Gait Cycle Segmentation
% If events are detected
if size(fieldnames(S.evts),1) > 0
    % Detect messed up events
    S = detectRepeatEvents(S);
    S = detectFalseSteps(S);
        
    % Define number of points for segmentation
    segPoints = 100; %from zero to 1000
    
    % Segment steps according to the first detected foot strike
    if S.evts.Right_Foot_Strike(1) < S.evts.Left_Foot_Strike(1)
        [S.R] = segmentSteps(S, 'Right', segPoints);
        [S.L] = segmentSteps(S, 'Left', segPoints);
        [S.stats.initStep] = 'R';
    else
        [S.L] = segmentSteps(S, 'Left', segPoints);
        [S.R] = segmentSteps(S, 'Right', segPoints);
        [S.stats.initStep] = 'L';
    end  
else
    S.errors(end+1) = {'No events detected'};
end

% Detrend to motion on a stepwise basis, so that each step is
% registered as all motion in Y
%[S] = detrendStepWise(S);

% Close current trial and return extracted parameters
btkCloseAcquisition(c3d);

% Save struct to file if 
if saveRequired   
    % Store parameters in a mat-file
    save([file(1:end-4) '.mat'], 'S')  
end

end

%% ------------------- END OF CODE -------------------
