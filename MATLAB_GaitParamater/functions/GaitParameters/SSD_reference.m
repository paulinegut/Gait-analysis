%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% SSD calculation
%
% Version 12. December 2020
% Author: Pauline Rose Gut
% #########################################################################

function [S] = SSD_reference(S, nhr)
% Knee
for i = 1:100
    for ii = 1:length(S.R)
        xR(ii,i) = S.R(ii).angs.RKneeAngles(i,1); yR(ii,i) = S.R(ii).angs.RKneeAngles(i,2); zR(ii,i) = S.R(ii).angs.RKneeAngles(i,3);
    end
    for ii = 1:length(S.L)
        xL(ii,i) = S.L(ii).angs.LKneeAngles(i,1); yL(ii,i) = S.L(ii).angs.LKneeAngles(i,2); zL(ii,i) = S.L(ii).angs.LKneeAngles(i,3);
    end
end
clear i ii;

KR(1,:) = mean(xR,1); KR(2,:) = mean(yR,1); KR(3,:) = mean(zR,1);
KL(1,:) = mean(xL,1); KL(2,:) = mean(yL,1); KL(3,:) = mean(zL,1);
clear xR xL yR yL zR zL; 

% Hip
for i = 1:100
    for ii = 1:length(S.R)
        xR(ii,i) = S.R(ii).angs.RHipAngles(i,1); yR(ii,i) = S.R(ii).angs.RHipAngles(i,2); zR(ii,i) = S.R(ii).angs.RHipAngles(i,3);
    end
    for ii = 1:length(S.L)
        xL(ii,i) = S.L(ii).angs.LHipAngles(i,1); yL(ii,i) = S.L(ii).angs.LHipAngles(i,2); zL(ii,i) = S.L(ii).angs.LHipAngles(i,3);
    end
end
clear i ii;

HR(1,:) = mean(xR,1); HR(2,:) = mean(yR,1); HR(3,:) = mean(zR,1);
HL(1,:) = mean(xL,1); HL(2,:) = mean(yL,1); HL(3,:) = mean(zL,1);
clear xR xL yR yL zR zL; 

% Ankle
for i = 1:100
    for ii = 1:length(S.R)
        xR(ii,i) = S.R(ii).angs.RAnkleAngles(i,1); yR(ii,i) = S.R(ii).angs.RAnkleAngles(i,2); zR(ii,i) = S.R(ii).angs.RAnkleAngles(i,3);
    end
    for ii = 1:length(S.L)
        xL(ii,i) = S.L(ii).angs.LAnkleAngles(i,1); yL(ii,i) = S.L(ii).angs.LAnkleAngles(i,2); zL(ii,i) = S.L(ii).angs.LAnkleAngles(i,3);
    end
end
clear i ii;

AR(1,:) = mean(xR,1); AR(2,:) = mean(yR,1); AR(3,:) = mean(zR,1);
AL(1,:) = mean(xL,1); AL(2,:) = mean(yL,1); AL(3,:) = mean(zL,1);
clear xR xL yR yL zR zL; 

% SSD
S.cyclograms.SSD.R.HipKneeSag(1,1) = SSD(HR(1,:), KR(1,:), nhr.Angles.Sagittal.mRHip,nhr.Angles.Sagittal.mRKnee);
S.cyclograms.SSD.L.HipKneeSag(1,1) = SSD(HL(1,:), KL(1,:), nhr.Angles.Sagittal.mLHip, nhr.Angles.Sagittal.mLKnee);

S.cyclograms.SSD.R.KneeAnkleSag(1,1) = SSD(KR(1,:), AR(1,:), nhr.Angles.Sagittal.mRKnee, nhr.Angles.Sagittal.mRAnkle);
S.cyclograms.SSD.L.KneeAnkleSag(1,1) = SSD(KL(1,:), AL(1,:), nhr.Angles.Sagittal.mLKnee, nhr.Angles.Sagittal.mLAnkle);
clear AL AR KL KR HL HR
end