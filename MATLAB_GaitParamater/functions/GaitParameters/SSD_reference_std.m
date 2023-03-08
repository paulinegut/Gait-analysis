%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% SSD calculation
%
% Version 25. February 2021
% Author: Pauline Rose Gut
% #########################################################################

function [S] = SSD_reference_std(S, nhr)
% Knee
for i = 1:100
    for ii = 1:length(S.R)
        xRKnee(ii,i) = S.R(ii).angs.RKneeAngles(i,1); yRKnee(ii,i) = S.R(ii).angs.RKneeAngles(i,2); zRKnee(ii,i) = S.R(ii).angs.RKneeAngles(i,3);
    end
    for ii = 1:length(S.L)
        xLKnee(ii,i) = S.L(ii).angs.LKneeAngles(i,1); yLKnee(ii,i) = S.L(ii).angs.LKneeAngles(i,2); zLKnee(ii,i) = S.L(ii).angs.LKneeAngles(i,3);
    end
end
clear i ii;

% Hip
for i = 1:100
    for ii = 1:length(S.R)
        xRHip(ii,i) = S.R(ii).angs.RHipAngles(i,1); yRHip(ii,i) = S.R(ii).angs.RHipAngles(i,2); zRHip(ii,i) = S.R(ii).angs.RHipAngles(i,3);
    end
    for ii = 1:length(S.L)
        xLHip(ii,i) = S.L(ii).angs.LHipAngles(i,1); yLHip(ii,i) = S.L(ii).angs.LHipAngles(i,2); zLHip(ii,i) = S.L(ii).angs.LHipAngles(i,3);
    end
end
clear i ii;

% Ankle
for i = 1:100
    for ii = 1:length(S.R)
        xRAnkle(ii,i) = S.R(ii).angs.RAnkleAngles(i,1); yRAnkle(ii,i) = S.R(ii).angs.RAnkleAngles(i,2); zRAnkle(ii,i) = S.R(ii).angs.RAnkleAngles(i,3);
    end
    for ii = 1:length(S.L)
        xLAnkle(ii,i) = S.L(ii).angs.LAnkleAngles(i,1); yLAnkle(ii,i) = S.L(ii).angs.LAnkleAngles(i,2); zLAnkle(ii,i) = S.L(ii).angs.LAnkleAngles(i,3);
    end
end
clear i ii;

% SSD
for ii = 1:length(S.R)
    SSD_RHipKnee_step(ii,1) = SSD(xRHip(ii,:), xRKnee(ii,:), nhr.Angles.Sagittal.mRHip,nhr.Angles.Sagittal.mRKnee);
    SSD_RKneeAnkle_step(ii,1) = SSD(xRKnee(ii,:), xRAnkle(ii,:), nhr.Angles.Sagittal.mRKnee, nhr.Angles.Sagittal.mRAnkle);
end 
clear ii;

for ii = 1:length(S.L)
    SSD_LHipKnee_step(ii,1) = SSD(xLHip(ii,:), xLKnee(ii,:), nhr.Angles.Sagittal.mLHip, nhr.Angles.Sagittal.mLKnee);
    SSD_LKneeAnkle_step(ii,1) = SSD(xLKnee(ii,:), xLAnkle(ii,:), nhr.Angles.Sagittal.mLKnee, nhr.Angles.Sagittal.mLAnkle);
end
clear ii;

% M1 = mean(SSD_RHipKnee_step);
% M2 = mean(SSD_RKneeAnkle_step);
% M3 = mean(SSD_LHipKnee_step);
% M4 = mean(SSD_LKneeAnkle_step);

S1 = std(SSD_RHipKnee_step);
S2 = std(SSD_RKneeAnkle_step);
S3 = std(SSD_LHipKnee_step);
S4 = std(SSD_LKneeAnkle_step);

S.cyclograms.SSD.R.HipKneeSag_std = S1;
S.cyclograms.SSD.L.HipKneeSag_std = S3;

S.cyclograms.SSD.R.KneeAnkleSag_std = S2;
S.cyclograms.SSD.L.KneeAnkleSag_std = S4;

clear AL AR KL KR HL HR S1 S2 S3 S4 xLKnee xLAnkle xLHip xRKnee xRAnkle xRHip;
clear yLKnee yLAnkle yLHip yRKnee yRAnkle yRHip zLKnee zLAnkle zLHip zRKnee zRAnkle zRHip;
clear SSD_RHipKnee_step SSD_RKneeAnkle_step SSD_LHipKnee_step SSD_LKneeAnkle_step;
end