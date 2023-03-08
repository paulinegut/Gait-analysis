%% ########################################################################
% Gait Analysis
% Extraction of ACC with the Plug-in-Gait Model
% ACC calculation
%
% Version 15. March 2021
% Author: Pauline Rose Gut
% #########################################################################

function [ACC] = ACC_specTra(S1, S2)

% Right
for ii = 1:length(S1.R)
    stepAnkleR1(ii,:) = S1.R(ii).angs.RAnkleAngles(:,1)';
    stepKneeR1(ii,:) = S1.R(ii).angs.RKneeAngles(:,1)';
    stepHipR1(ii,:) = S1.R(ii).angs.RHipAngles(:,1)';
end
clear ii;
for ii = 1:length(S2.R)
    stepAnkleR2(ii,:) = S2.R(ii).angs.RAnkleAngles(:,1)';
    stepKneeR2(ii,:) = S2.R(ii).angs.RKneeAngles(:,1)';
    stepHipR2(ii,:) = S2.R(ii).angs.RHipAngles(:,1)';
end
clear ii;

stepAnkleR = [stepAnkleR1; stepAnkleR2]; clear stepAnkleR1 stepAnkleR2;
stepKneeR = [stepKneeR1; stepKneeR2]; clear stepKneeR1 stepKneeR2;
stepHipR = [stepHipR1; stepHipR2]; clear stepHipR1 stepHipR2;

% Left
for ii = 1:length(S1.L)
    stepAnkleL1(ii,:) = S1.L(ii).angs.LAnkleAngles(:,1)';
    stepKneeL1(ii,:) = S1.L(ii).angs.LKneeAngles(:,1)';
    stepHipL1(ii,:) = S1.L(ii).angs.LHipAngles(:,1)';
end
clear ii;
for ii = 1:length(S2.L)
    stepAnkleL2(ii,:) = S2.L(ii).angs.LAnkleAngles(:,1)';
    stepKneeL2(ii,:) = S2.L(ii).angs.LKneeAngles(:,1)';
    stepHipL2(ii,:) = S2.L(ii).angs.LHipAngles(:,1)';
end
clear ii;

stepAnkleL = [stepAnkleL1; stepAnkleL2]; clear stepAnkleL1 stepAnkleL2;
stepKneeL = [stepKneeL1; stepKneeL2]; clear stepKneeL1 stepKneeL2;
stepHipL =  [stepHipL1; stepHipL2]; clear stepHipL1 stepHipL2;

% Hip-Knee
[ACC.R.HipKnee, ACC.R.HipKnee_std] = calculateACC(stepHipR, stepKneeR);
[ACC.L.HipKnee, ACC.L.HipKnee_std] = calculateACC(stepHipL, stepKneeL);

% Knee-Ankle
[ACC.R.KneeAnkle, ACC.R.KneeAnkle_std] = calculateACC(stepKneeR, stepAnkleR);
[ACC.L.KneeAnkle, ACC.L.KneeAnkle_std] = calculateACC(stepKneeL, stepAnkleL);

clear stepHipR stepHipL stepKneeR stepKneeL stepAnkleR stepAnkleL

end