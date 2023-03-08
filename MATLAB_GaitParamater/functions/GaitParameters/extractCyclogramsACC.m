%% File: extractCyclogramsACC
% Author: cmey
% Date: 15.01.2020
% Matlab Version: 2019b
% Description: Function which calculates ACC values over all steps in a
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
% Date                  Author              Revision
% 25. February 2021     Pauline Gut

%% ------------------- BEGIN CODE -------------------

function [S] = extractCyclogramsACC(S, jointAngleType)

% Check if angles were calculated from vectors or model
if (strcmp(jointAngleType,'Vectors'))
    ank = 'ank';
    kne = 'kne';
    hip = 'hip';
    
    % Create array of right steps for all angles
    for ii = 1:length(S.R)
        stepAnkleR(ii,:) = S.R(ii).angs.(['R' ank]);
        stepKneeR(ii,:) = S.R(ii).angs.(['R' kne]);
        stepHipR(ii,:) = S.R(ii).angs.(['R' hip]);
    end
    
    for ii = 1:length(S.L)
        stepAnkleL(ii,:) = S.L(ii).angs.(['L' ank]);
        stepKneeL(ii,:) = S.L(ii).angs.(['L' kne]);
        stepHipL(ii,:) = S.L(ii).angs.(['L' hip]);
    end
else
    ank = 'AnkleAngles';
    kne = 'KneeAngles';
    hip = 'HipAngles';
    
    % Create array of right steps for all angles
    for ii = 1:length(S.R)
        stepAnkleR(ii,:) = S.R(ii).angs.(['R' ank])(:,1)';
        stepKneeR(ii,:) = S.R(ii).angs.(['R' kne])(:,1)';
        stepHipR(ii,:) = S.R(ii).angs.(['R' hip])(:,1)';
    end
    
    for ii = 1:length(S.L)
        stepAnkleL(ii,:) = S.L(ii).angs.(['L' ank])(:,1)';
        stepKneeL(ii,:) = S.L(ii).angs.(['L' kne])(:,1)';
        stepHipL(ii,:) = S.L(ii).angs.(['L' hip])(:,1)';
    end
end

% Hip-Knee
[S.cyclograms.ACC.R.HipKnee, S.cyclograms.ACC.R.HipKnee_std] = calculateACC(stepHipR, stepKneeR);
[S.cyclograms.ACC.L.HipKnee, S.cyclograms.ACC.L.HipKnee_std] = calculateACC(stepHipL, stepKneeL);

% Knee-Ankle
[S.cyclograms.ACC.R.KneeAnkle, S.cyclograms.ACC.R.KneeAnkle_std] = calculateACC(stepKneeR, stepAnkleR);
[S.cyclograms.ACC.L.KneeAnkle, S.cyclograms.ACC.L.KneeAnkle_std] = calculateACC(stepKneeL, stepAnkleL);

end

% Calculate ACC over all steps
function [ACC, ACC_std] = calculateACC(Angle1, Angle2)


    Intervals_Angle1 = diff(Angle1,1,2);
    Intervals_Angle2 = diff(Angle2,1,2);

    Intervals_Angle1_squared = Intervals_Angle1.^2;
    Intervals_Angle2_squared = Intervals_Angle2.^2;

    Interval_sum = Intervals_Angle1_squared+Intervals_Angle2_squared;
    Interval_sum_sqrt = sqrt(Interval_sum);

    cos = Intervals_Angle1./Interval_sum_sqrt;
    sin = Intervals_Angle2./Interval_sum_sqrt;

    Mcos = mean(cos);
    Msin = mean(sin);


    Mvec_length = sqrt(Mcos.^2 + Msin.^2);

    ACC = mean(Mvec_length);
    ACC_std = std(Mvec_length);
end

%% ------------------- END CODE -------------------