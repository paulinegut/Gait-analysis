%% File: segmentSteps
% Author: ces
% Date: before 2019
% Matlab Version: 2019a
% Description: Function which accepts data from a measurement trial stored
%              in the provided MATLAB structure and adds segmented and
%              normalized gait cycle data to the structure under a label
%              of the corresponding leg
%
% Usage: Executed from readC3D function with corresponding data structure
%
% Input: S - MATLAB struct with extracted data from a c3d file (see readC3D)
%        side - String of characters for the corresponding leg ('Left','Right')
%        segPoints - Number of data points used for gait cycle normalization
%
% Output: out - MATLAB struct with segmented gait cycles
%
% Other files required: -
% Other m-files required: linearNormalization.m, makePercEvts.m
%
% Date        Author      Revision
% 20190830    mb          Commented & cleaned up
% 20191118    mb          Corrected wrong conversion from marker events to
%                         analog events: (corrFactor * (events - 1)) + 1

%% ------------------- BEGIN CODE -------------------

function [out] = segmentSteps(S, side, segPoints)
% Start with first foot strike event and segment following data points into
% single, normalized gait cycles of the same length

%% Parameter Definitions
% Define labels of all possible gait events
labels = {'Right_Foot_Strike', 'Right_Foot_Off', 'Left_Foot_Strike', 'Left_Foot_Off'};
% Define the continuous data which should be segmented
contData = {'analog', 'angs', 'points'};
% Define correction factor for adjusting event frames to sampling frequency
% of the corresponding data type
corrFactor = [S.stats.analogFq/S.stats.pointFq, 1, 1];

% Define the expected gait event sequence
if strcmp(side, 'Right')
    seq = [1, 2, 3, 4]; %for starting with right leg
else
    seq = [3, 4, 1, 2]; %for starting with left leg
end

%% Event Data Clean Up
% Find the first foot off following the initial heel strike
tmp = find(S.evts.(labels{seq(2)})>S.evts.(labels{seq(1)})(1), 1, 'first');
% If the found foot off is not the first
if tmp>1
    % Erase all foot offs preceeding the found index
    S.evts.(labels{seq(2)})(1:tmp-1) = [];
end

% Find the first contralateral foot strike following the initial heel strike
tmp = find(S.evts.(labels{seq(3)})>S.evts.(labels{seq(1)})(1), 1, 'first');
% If the found contralateral foot strike is not the first
if tmp>1
    % Erase all foot strikes preceeding the found index
    S.evts.(labels{seq(3)})(1:tmp-1) = [];
end

% Find the first contralateral foot off following the initial heel strike
tmp = find(S.evts.(labels{seq(4)})>S.evts.(labels{seq(1)})(1), 1, 'first');
% If the found contralateral foot off is not the first
if tmp>1
    % Erase all contralateral foot strikes preceeding the found index
    S.evts.(labels{seq(4)})(1:tmp-1) = [];
end

%% Segment Data in to Gait Cycles
% Check if there are any complete steps at all (at least more than 1 foot
% strike)
if length(S.evts.(labels{seq(1)}))-1 > 0
    % Iterate over every complete cycle (foot strike to foot strike)
    for iCycle = 1:length(S.evts.(labels{seq(1)}))-1 %number of cycles
        % Repeat segmentation for all continuous data types
        for iData = 1:length(contData)
            % Get all available fields (e.g. marker or analog names)
            Fnames = fieldnames(S.(contData{iData}));
            % Check if there are no fields
            if size(Fnames,1) == 0
                % Return empty array
                out(iCycle).(contData{iData}) = [];
            else
                % Iterate over all available fields
                for iField= 1: length(Fnames)
                    % Obtain event gait cycle range (in frames)
                    cycleRange = S.evts.(labels{seq(1)})(iCycle):S.evts.(labels{seq(1)})(iCycle+1);
                    % In case of analog data, correct event indices for 
                    % different sampling frequencies (round if correction
                    % factor is not an integer)
                    cycleRange = round((corrFactor(iData)*(cycleRange - 1))+1,0); %subtract single frame before converting to analog data and add frame after conversion
                    % Temporary store gait cycle data
                    tmp = S.(contData{iData}).(Fnames{iField});
                    % Linear normalization of gait cycle data
                    normCycle = linearNormalization(tmp(cycleRange,:), segPoints);
                        
                    % TODO: Add options for different normalizations
                    % Phase normalization to stance and swing phase needs
                    % information about mean/median foot off times
                    
                    % Add normalized signal to input struct
                    out(iCycle).(contData{iData}).(Fnames{iField}) = normCycle;
                end
            end
        end
        
        % Calculate step duration as number of frames
        stepDurationF = S.evts.(labels{seq(1)})(iCycle+1) - S.evts.(labels{seq(1)})(iCycle);
        % Add for each cycle the step duration in [s]
        out(iCycle).stepDuration = stepDurationF / S.stats.pointFq;
        % Add for each cycle the event timing in [interpolated frames]
        out(iCycle).events = linNormEvts([S.evts.(labels{seq(1)})(iCycle),  S.evts.(labels{seq(2)})(iCycle), S.evts.(labels{seq(3)})(iCycle), S.evts.(labels{seq(4)})(iCycle)], stepDurationF, segPoints);
    end
% In case no complete steps are available    
else
    % Return empty output
    out = [];
end
end

%% ------------------- END OF CODE -------------------