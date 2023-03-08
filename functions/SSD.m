%
% 
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


function [ SSD ] = SSD(AngleX1, AngleY1, AngleX2, AngleY2)


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
