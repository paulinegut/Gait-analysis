%% File: extractCyclogramsSSD
% Description: Function which calculates SSD values for each step in a
%              single trial.
%
% Usage: Run 'Gait Parameter Extraction' script package which calls this
%        function
%
% Input: S - structure containing all parameters extracted from c3d files
%        jointAngleType - character string being either 'Vectors' or
%                         'Model'
%
% Output: S - MATLAB structure containing extracted c3d parameters
%
% Other files required: 'Gait Parameter Extraction' script package
%
% Date        Author      Revision
%

%% ------------------- BEGIN CODE -------------------
% Created 21.July.16 in Zürich, Switzerland
% Dependencies: Matlab R2015b and BTK Toolkit 0.3.0 Matlab wrapper
% Author: Christian Kopp
%
% This function calculates the sum of squared distances between a shape
% defined by two vectors and a comparison shape, also defined by two
% vectors, which is a measure of shape difference between two cyclograms.
%
%
%   Data100: Array containing all normalized steps (category, data)
%
%   AngleX1: Angle data as arrays the form (category, 100 datapoints)
%   AngleY1: Angle data as arrays the form (category, 100 datapoints)
%
%   Note: Ideal angle data is derived from a healthy young adult at
%   his preferred speed.
%   AngleX2: Ideal angle data as arrays the form (category, 100 datapoints)
%   AngleY2: Ideal angle data as arrays the form (category, 100 datapoints)
%
%   Plane1: Anatomical plane for the data (sagittal = 'Y');
%   Plane2: Anatomical plane for the data (sagittal = 'Y');
%


function [S] = extractCyclogramsSSD(S, jointAngleType)

    % Check if angles were calculated from vectors or model
    if (strcmp(jointAngleType,'Vectors'))
        ank = 'ank';
        kne = 'kne';
        hip = 'hip';
    else
        ank = 'AnkleAngles';
        kne = 'KneeAngles';
        hip = 'HipAngles';
    end

    % Iterate over every right step
    for ii = 1:length(S.R)
    
        % Hip-Knee SSD
        S.cyclograms.SSD.R(ii).HipKnee = calculateSSD(S.R(ii).angs.(['R' hip])(:,1), S.R(ii).angs.(['R' kne])(:,1), ...
            S.cyclograms.normDataSSD.normRHip, S.cyclograms.normDataSSD.normRKnee);
    
        % Knee-Ankle SSD
        S.cyclograms.SSD.R(ii).KneeAnkle = calculateSSD(S.R(ii).angs.(['R' kne])(:,1), S.R(ii).angs.(['R' ank])(:,1), ...
            S.cyclograms.normDataSSD.normRKnee, S.cyclograms.normDataSSD.normRAnkle);
    end

    % Iterate over every left step
    for ii = 1:length(S.L)
        % Hip-Knee SSD
        S.cyclograms.SSD.L(ii).HipKnee = calculateSSD(S.L(ii).angs.(['L' hip])(:,1), S.L(ii).angs.(['L' kne])(:,1), ...
            S.cyclograms.normDataSSD.normLHip, S.cyclograms.normDataSSD.normLKnee);
    
        % Knee-Ankle SSD
        S.cyclograms.SSD.L(ii).KneeAnkle = calculateSSD(S.L(ii).angs.(['L' kne])(:,1), S.L(ii).angs.(['L' ank])(:,1), ...
            S.cyclograms.normDataSSD.normLKnee, S.cyclograms.normDataSSD.normLAnkle);
    end
end

% Calculate SSD for a single step
function SSD = calculateSSD(AngleX1, AngleY1, AngleX2, AngleY2)

    if(length(AngleX1(:,1)) ~= 1000)
        % Transpose angles
        AngleX1 = AngleX1';
        AngleY1 = AngleY1'; 
    end

    % Average all datasets
    AngleX1_mean = nanmean(AngleX1);
    AngleY1_mean = nanmean(AngleY1);
    AngleX2_mean = nanmean(AngleX2);
    AngleY2_mean = nanmean(AngleY2);
    
    % Center each angle individually by subtracting the mean from each
    % point
    AngleX1_centered = AngleX1 - AngleX1_mean;
    AngleX2_centered = AngleX2 - AngleX2_mean;
    AngleY1_centered = AngleY1 - AngleY1_mean;
    AngleY2_centered = AngleY2 - AngleY2_mean;
    
    %calculate the scaling factors
    aux1 = sum(AngleX1_centered.^2 + AngleY1_centered.^2);
    S1 = sqrt(aux1/length(AngleX1_centered));
    aux2 = sum(AngleX2_centered.^2 + AngleY2_centered.^2);
    S2 = sqrt(aux2/length(AngleX2_centered));
    
    % Rescale the angles
    AngleX1_rescaled = AngleX1_centered ./S1;
    AngleY1_rescaled = AngleY1_centered ./S1;
    AngleX2_rescaled = AngleX2_centered ./S2;
    AngleY2_rescaled = AngleY2_centered ./S2;
    
    % Calculate the centroids to center the cyclograms
%     C_x1 = (max(AngleX1_mean) - min(AngleX1_mean)) / 2;
%     C_y1 = (max(AngleY1_mean) - min(AngleY1_mean)) / 2;
%     C_x2 = (max(AngleX2_mean) - min(AngleX2_mean)) / 2;
%     C_y2 = (max(AngleY2_mean) - min(AngleY2_mean)) / 2;

    % Center the cyclograms
%     AngleX1_centered = AngleX1_mean - min(AngleX1_mean) - C_x1;
%     AngleY1_centered = AngleY1_mean - min(AngleY1_mean) - C_y1;
%     AngleX2_centered = AngleX2_mean - min(AngleX2_mean) - C_x2;
%     AngleY2_centered = AngleY2_mean - min(AngleY2_mean) - C_y2;
    


    % Rescale the cyclograms
%     AngleX1_rescaled = AngleX1_centered ./ max(AngleX1_centered);
%     AngleY1_rescaled = AngleY1_centered ./ max(AngleY1_centered);
%     AngleX2_rescaled = AngleX2_centered ./ max(AngleX2_centered);
%     AngleY2_rescaled = AngleY2_centered ./ max(AngleY2_centered);

    % Compute SSD
    for n1=1:size(AngleX1_rescaled,2)
      squared_distances(n1) = ( AngleX1_rescaled(n1) - AngleX2_rescaled(n1) ) ^2 + ( AngleY1_rescaled(n1) - AngleY2_rescaled(n1) ) ^2;
    end
    
    
    
    % This is an approximation. The best way to do this would be to mean
    % the angles for stance and swing according to each FO
    %SSDstance = sqrt( sum( squared_distances(1:round(nanmean(FO))) ) );
    %SSDswing = sqrt( sum( squared_distances(1000-round(nanmean(FO)):end) ) );
    SSD = sqrt( sum( squared_distances )  );
    %%continuous SSD
    %SSD = squared_distances;   
    
end
