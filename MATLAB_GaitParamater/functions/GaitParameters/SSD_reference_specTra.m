%% ########################################################################
% Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% SSD calculation
%
% Version 15. March 2021
% Author: Pauline Rose Gut
% #########################################################################

function [SSDspecTra] = SSD_reference_specTra(S1, S2, nhr)
% Knee
for i = 1:100
    for ii = 1:length(S1.R)
        x1R(ii,i) = S1.R(ii).angs.RKneeAngles(i,1); y1R(ii,i) = S1.R(ii).angs.RKneeAngles(i,2); z1R(ii,i) = S1.R(ii).angs.RKneeAngles(i,3);
    end
    for ii = 1:length(S1.L)
        x1L(ii,i) = S1.L(ii).angs.LKneeAngles(i,1); y1L(ii,i) = S1.L(ii).angs.LKneeAngles(i,2); z1L(ii,i) = S1.L(ii).angs.LKneeAngles(i,3);
    end
end
clear i ii;
for i = 1:100
    for ii = 1:length(S2.R)
        x2R(ii,i) = S2.R(ii).angs.RKneeAngles(i,1); y2R(ii,i) = S2.R(ii).angs.RKneeAngles(i,2); z2R(ii,i) = S2.R(ii).angs.RKneeAngles(i,3);
    end
    for ii = 1:length(S2.L)
        x2L(ii,i) = S2.L(ii).angs.LKneeAngles(i,1); y2L(ii,i) = S2.L(ii).angs.LKneeAngles(i,2); z2L(ii,i) = S2.L(ii).angs.LKneeAngles(i,3);
    end
end
clear i ii;

xR = [x1R; x2R]; yR = [y1R; y2R]; zR = [z1R; z2R]; clear x1R x2R y1R y2R z1R z2R
xL = [x1L; x2L]; yL = [y1L; y2L]; zL = [z1L; z2L]; clear x1L x2L y1L y2L z1L z2L

KR(1,:) = mean(xR,1); KR(2,:) = mean(yR,1); KR(3,:) = mean(zR,1);
KL(1,:) = mean(xL,1); KL(2,:) = mean(yL,1); KL(3,:) = mean(zL,1);
clear xR xL yR yL zR zL; 

% Hip
for i = 1:100
    for ii = 1:length(S1.R)
        x1R(ii,i) = S1.R(ii).angs.RHipAngles(i,1); y1R(ii,i) = S1.R(ii).angs.RHipAngles(i,2); z1R(ii,i) = S1.R(ii).angs.RHipAngles(i,3);
    end
    for ii = 1:length(S1.L)
        x1L(ii,i) = S1.L(ii).angs.LHipAngles(i,1); y1L(ii,i) = S1.L(ii).angs.LHipAngles(i,2); z1L(ii,i) = S1.L(ii).angs.LHipAngles(i,3);
    end
end
clear i ii;
for i = 1:100
    for ii = 1:length(S2.R)
        x2R(ii,i) = S2.R(ii).angs.RHipAngles(i,1); y2R(ii,i) = S2.R(ii).angs.RHipAngles(i,2); z2R(ii,i) = S2.R(ii).angs.RHipAngles(i,3);
    end
    for ii = 1:length(S2.L)
        x2L(ii,i) = S2.L(ii).angs.LHipAngles(i,1); y2L(ii,i) = S2.L(ii).angs.LHipAngles(i,2); z2L(ii,i) = S2.L(ii).angs.LHipAngles(i,3);
    end
end
clear i ii;

xR = [x1R; x2R]; yR = [y1R; y2R]; zR = [z1R; z2R]; clear x1R x2R y1R y2R z1R z2R
xL = [x1L; x2L]; yL = [y1L; y2L]; zL = [z1L; z2L]; clear x1L x2L y1L y2L z1L z2L

HR(1,:) = mean(xR,1); HR(2,:) = mean(yR,1); HR(3,:) = mean(zR,1);
HL(1,:) = mean(xL,1); HL(2,:) = mean(yL,1); HL(3,:) = mean(zL,1);
clear xR xL yR yL zR zL; 

% Ankle
for i = 1:100
    for ii = 1:length(S1.R)
        x1R(ii,i) = S1.R(ii).angs.RAnkleAngles(i,1); y1R(ii,i) = S1.R(ii).angs.RAnkleAngles(i,2); z1R(ii,i) = S1.R(ii).angs.RAnkleAngles(i,3);
    end
    for ii = 1:length(S1.L)
        x1L(ii,i) = S1.L(ii).angs.LAnkleAngles(i,1); y1L(ii,i) = S1.L(ii).angs.LAnkleAngles(i,2); z1L(ii,i) = S1.L(ii).angs.LAnkleAngles(i,3);
    end
end
clear i ii;
for i = 1:100
    for ii = 1:length(S2.R)
        x2R(ii,i) = S2.R(ii).angs.RAnkleAngles(i,1); y2R(ii,i) = S2.R(ii).angs.RAnkleAngles(i,2); z2R(ii,i) = S2.R(ii).angs.RAnkleAngles(i,3);
    end
    for ii = 1:length(S2.L)
        x2L(ii,i) = S2.L(ii).angs.LAnkleAngles(i,1); y2L(ii,i) = S2.L(ii).angs.LAnkleAngles(i,2); z2L(ii,i) = S2.L(ii).angs.LAnkleAngles(i,3);
    end
end
clear i ii;

xR = [x1R; x2R]; yR = [y1R; y2R]; zR = [z1R; z2R]; clear x1R x2R y1R y2R z1R z2R
xL = [x1L; x2L]; yL = [y1L; y2L]; zL = [z1L; z2L]; clear x1L x2L y1L y2L z1L z2L

AR(1,:) = mean(xR,1); AR(2,:) = mean(yR,1); AR(3,:) = mean(zR,1);
AL(1,:) = mean(xL,1); AL(2,:) = mean(yL,1); AL(3,:) = mean(zL,1);
clear xR xL yR yL zR zL; 

% SSD
SSDspecTra.R.HipKneeSag = SSD(HR(1,:), KR(1,:), nhr.Angles.Sagittal.mRHip,nhr.Angles.Sagittal.mRKnee);
SSDspecTra.L.HipKneeSag = SSD(HL(1,:), KL(1,:), nhr.Angles.Sagittal.mLHip, nhr.Angles.Sagittal.mLKnee);

SSDspecTra.R.KneeAnkleSag = SSD(KR(1,:), AR(1,:), nhr.Angles.Sagittal.mRKnee, nhr.Angles.Sagittal.mRAnkle);
SSDspecTra.L.KneeAnkleSag = SSD(KL(1,:), AL(1,:), nhr.Angles.Sagittal.mLKnee, nhr.Angles.Sagittal.mLAnkle);
clear AL AR KL KR HL HR
end