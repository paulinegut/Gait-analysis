%% File: correctMovementDirection
% Author: ces
% Date: before 2019
% Matlab Version: 2019b
% Description: Function which ensures that movement direction is always in
%              +y-direction.
%
% Usage: Run 'Gait Parameter Extraction' script package which calls this
%        function or run readc3d.m without arguments which also calls this
%        function on a user selected single trial (c3d file)
%
% Input: S - structure containing all parameters extracted from c3d files
%        environmentType - character string being either 'Overground' or
%                          'Treadmill'
%
% Output: S -  structure containing all parameters extracted from c3d files
%              including the following movement correction parameters:
%         points - marker data which is corrected for movement direction
%         transOrigin - x/y/z-translations applied to the original
%                       origin
%         rotMat - rotation matrix which was applied to rotate walking
%                  direction in +y-direction
%         walkingEvironment - a string being either 'overground' or 
%                             'treadmill'
%
% Other files required: 'Gait Parameter Extraction' script package
%
% Date        Author      Revision
% 20191118    MBan        Commented & cleaned up
% 20191118    MBan        Added distinction between treadmill and overground
%

%% ------------------- BEGIN CODE -------------------

function [S] = correctMovementDirection(S, environmentType)

    % Set global coordinate system close to SACR and rotate in direction of walking
    % Store all marker names
    fieldsToChange = fieldnames(S.points);

    % Define desired horizontal walking direction
    desDir = [0; 1; 0]; %walking direction: y, lateral direction: x

    % Obtain recorded walking direction
    walkDir = S.points.SACR(end,1:2) - S.points.SACR(1,1:2);    %ignore movement in z-direction

    % Calculate walked distance
    %distance = sqrt(walkDir(1)^2 + walkDir(2)^2);

    % Check if trial was performed overground
    if (strcmp(environmentType,'Overground'))
    
        % Find closest global axis
        [~, idx] = max(abs(walkDir));   %get largest component
        walkGlob = [0; 0; 0];   %create global walking vector
        dirSign = sign(walkDir(idx));    %get sign of walking direction
        walkGlob(idx) = dirSign; %set walking direction
    
        % Find angle between desired and actual walking direction
        alpha = atan2d(norm(cross(desDir,walkGlob)),dot(desDir,walkGlob));
    
        % Create rotation matrix for rotating coordinate system around z-axis
        rotMat =    [cosd(alpha), -sind(alpha), 0;
                     sind(alpha), cosd(alpha), 0;
                     0, 0, 1];
    
        % Obtain required translation for origin
        transOrigin = (rotMat*S.points.SACR(1,:)')';
    
        % Iterate over all marker and rotate and translate coordinates
        for iFields = 1: length(fieldsToChange)
            
            % Rotate marker positions to agree with desired walking direction
            rotPoints = (rotMat*S.points.(fieldsToChange{iFields})')';
        
            % Translate origin 1 m behind and 1 m left of SACR-marker at frame 1
            correctPoints.(fieldsToChange{iFields})(:,2) = rotPoints(:,2) - transOrigin(1,2) + 1000; %Y Set origin @1m behind sacrum@Frame1
            correctPoints.(fieldsToChange{iFields})(:,1) = rotPoints(:,1) - transOrigin(1,1) + 1000; %X Set origin @1m left sacrum@Frame1
            correctPoints.(fieldsToChange{iFields})(:,3) = rotPoints(:,3); %do not change z-position
        end
        
        % Store trial type
        S.stats.trialType = 'overground';
    else
        
        % Obtain recorded walking direction on treadmill
        walkDir = mean((S.points.RASI(:,1:2) + S.points.LASI(:,1:2))/2 - S.points.SACR(:,1:2));    %direction from first frame SACR to midpoint between RASI and LASI, ignore movement in z-direction
        
        % Find closest global axis
        [~, idx] = max(abs(walkDir));   %get largest component
        walkGlob = [0; 0; 0];   %create global walking vector
        dirSign = sign(walkDir(idx));    %get sign of walking direction
        walkGlob(idx) = dirSign; %set walking direction
    
        % Find angle between desired and actual walking direction
        alpha = atan2d(norm(cross(desDir,walkGlob)),dot(desDir,walkGlob));
    
        % Create rotation matrix for rotating coordinate system around z-axis
        rotMat =    [cosd(alpha), -sind(alpha), 0;
                     sind(alpha), cosd(alpha), 0;
                     0, 0, 1];
    
        % Obtain required translation for origin
        transOrigin = (rotMat*S.points.SACR(1,:)')';
    
        % Iterate over all marker and rotate and translate coordinates
        for iFields = 1: length(fieldsToChange)
            
            % Rotate marker positions to agree with desired walking direction
            rotPoints = (rotMat*S.points.(fieldsToChange{iFields})')';
        
            % Translate origin 1 m behind and 1 m left of SACR-marker at frame 1
            correctPoints.(fieldsToChange{iFields})(:,2) = rotPoints(:,2) - transOrigin(1,2) + 1000; %Y Set origin @1m behind sacrum@Frame1
            correctPoints.(fieldsToChange{iFields})(:,1) = rotPoints(:,1) - transOrigin(1,1) + 1000; %X Set origin @1m left sacrum@Frame1
            correctPoints.(fieldsToChange{iFields})(:,3) = rotPoints(:,3); %do not change z-position
        end

        S.stats.trialType = 'treadmill';                       
    end
    
    % Store corrected points, translation from previous origin and
    % rotation matrix
    S.points = correctPoints;
    S.transformation.originOffset = transOrigin;
    S.transformation.rotMat = rotMat;
end

%% ------------------- END OF CODE -------------------