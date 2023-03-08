%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% Z-scores
%
% Version 15. March 2021
% Author: Pauline Rose Gut
% #########################################################################

function [Zscores_nhr] = Zscores_specTra(S1, S2, nhr, Cyclograms, COV)

% Range of motion

% Hip
% Sagittal: Flexion/Extension
Zscores_nhr(1,1) = (mean([[S1.R.ROMHipAnglesRangeSag].'; [S2.R.ROMHipAnglesRangeSag].']) - mean(nhr.ROM.Sagittal.RHip(:,1)))/std(nhr.ROM.Sagittal.RHip(:,1));
Zscores_nhr(2,1) = (mean([[S1.L.ROMHipAnglesRangeSag].'; [S2.L.ROMHipAnglesRangeSag].']) - mean(nhr.ROM.Sagittal.LHip(:,1)))/std(nhr.ROM.Sagittal.LHip(:,1));
% Frontal: Abduction/Aduction
Zscores_nhr(3,1) = (mean([[S1.R.ROMHipAnglesRangeFrnt].'; [S2.R.ROMHipAnglesRangeFrnt].']) - mean(nhr.ROM.Frontal.RHip(:,1)))/std(nhr.ROM.Frontal.RHip(:,1));
Zscores_nhr(4,1) = (mean([[S1.L.ROMHipAnglesRangeFrnt].'; [S2.L.ROMHipAnglesRangeFrnt].']) - mean(nhr.ROM.Frontal.LHip(:,1)))/std(nhr.ROM.Frontal.LHip(:,1));

% Knee
% Sagittal: Flexion/Extension
Zscores_nhr(5,1) = (mean([[S1.R.ROMKneeAnglesRangeSag].'; [S2.R.ROMKneeAnglesRangeSag].']) - mean(nhr.ROM.Sagittal.RKnee(:,1)))/std(nhr.ROM.Sagittal.RKnee(:,1));
Zscores_nhr(6,1) = (mean([[S1.L.ROMKneeAnglesRangeSag].'; [S2.L.ROMKneeAnglesRangeSag].']) - mean(nhr.ROM.Sagittal.LKnee(:,1)))/std(nhr.ROM.Sagittal.LKnee(:,1));

% Ankle
% Sagittal: Flexion/Extension
Zscores_nhr(7,1) = (mean([[S1.R.ROMAnkleAnglesRangeSag].'; [S2.R.ROMAnkleAnglesRangeSag].']) - mean(nhr.ROM.Sagittal.RAnkle(:,1)))/std(nhr.ROM.Sagittal.RAnkle(:,1));
Zscores_nhr(8,1) = (mean([[S1.L.ROMAnkleAnglesRangeSag].'; [S2.L.ROMAnkleAnglesRangeSag].']) - mean(nhr.ROM.Sagittal.LAnkle(:,1)))/std(nhr.ROM.Sagittal.LAnkle(:,1));

for i = 1:size(nhr.Angles.Frontal.Spine,1)
    xFrnt(i,1) = mean(nhr.Angles.Frontal.Spine(i,:), 2);
end
clear i;
for i = 1:size(nhr.Angles.Sagittal.Spine,1)
    xSag(i,1) = mean(nhr.Angles.Sagittal.Spine(i,:), 2);
end
clear i;

% Spine
% Frontal : Lateral Flexion
Zscores_nhr(9,1) = (mean([S1.Spine.LateralFlexion.Mean(:,1); S2.Spine.LateralFlexion.Mean(:,1)]) - mean(xFrnt))/std(xFrnt); clear xFrnt;
% Sagittal: Flexion/Extension
Zscores_nhr(10,1) = (mean([S1.Spine.FlexionExtension.Mean(:,1); S2.Spine.FlexionExtension.Mean(:,1)]) - mean(xSag))/std(xSag); clear xSag;

% Stability/Balance
StepWidth = mean([mean([[S1.R.stepWidth].'; [S2.R.stepWidth].']), mean([[S1.L.stepWidth].'; [S2.L.stepWidth].'])]);
Zscores_nhr(11,1) = (StepWidth - mean(nhr.StepWidth(:,1)))/std(nhr.StepWidth(:,1)); clear StepWidth
% X2 = (S.DoubleLimbSupport.Mean - mean(nhr.DoubleLimbSupport(:,1)))/std(nhr.DoubleLimbSupport(:,1));
% X3 = (mean(S.COM.ML) - mean(nhr.COM.ML(:,1)))/std(nhr.COM.ML(:,1));
% X4 = (mean(S.COM.AP) - mean(nhr.COM.AP(:,1)))/std(nhr.COM.AP(:,1));
% X5 = (mean(S.C7TrajectoryLength) - mean(nhr.C7TrajectoryLength(:,1)))/std(nhr.C7TrajectoryLength(:,1));
% clear X2 X3 X4 X5

% Interlimb coordination
Zscores_nhr(12,1) = abs((mean([S1.PhaseDispersion.Leg; S2.PhaseDispersion.Leg]) - mean(nhr.PhaseDispersion.Leg(:,1)))/std(nhr.PhaseDispersion.Leg(:,1)));

% Intralimb coordination
% SSD
Zscores_nhr(13,1) = (Cyclograms.SSD.R.HipKneeSag - mean(nhr.cyclograms.SSD.Sagittal.RHipRKnee(:,1)))/std(nhr.cyclograms.SSD.Sagittal.RHipRKnee(:,1));
Zscores_nhr(14,1) = (Cyclograms.SSD.L.HipKneeSag - mean(nhr.cyclograms.SSD.Sagittal.LHipLKnee(:,1)))/std(nhr.cyclograms.SSD.Sagittal.LHipLKnee(:,1));
Zscores_nhr(15,1) = (Cyclograms.SSD.R.KneeAnkleSag - mean(nhr.cyclograms.SSD.Sagittal.RKneeRAnkle(:,1)))/std(nhr.cyclograms.SSD.Sagittal.RKneeRAnkle(:,1));
Zscores_nhr(16,1) = (Cyclograms.SSD.L.KneeAnkleSag - mean(nhr.cyclograms.SSD.Sagittal.LKneeLAnkle(:,1)))/std(nhr.cyclograms.SSD.Sagittal.LKneeLAnkle(:,1));

% ACC
Zscores_nhr(17,1) = (Cyclograms.ACC.R.HipKnee - mean(nhr.cyclograms.ACC.RHipRKnee(:,1)))/std(nhr.cyclograms.ACC.RHipRKnee(:,1));
Zscores_nhr(18,1) = (Cyclograms.ACC.L.HipKnee - mean(nhr.cyclograms.ACC.LHipLKnee(:,1)))/std(nhr.cyclograms.ACC.LHipLKnee(:,1));
Zscores_nhr(19,1) = (Cyclograms.ACC.R.KneeAnkle - mean(nhr.cyclograms.ACC.RKneeRAnkle(:,1)))/std(nhr.cyclograms.ACC.RKneeRAnkle(:,1));
Zscores_nhr(20,1) = (Cyclograms.ACC.L.KneeAnkle - mean(nhr.cyclograms.ACC.LKneeLAnkle(:,1)))/std(nhr.cyclograms.ACC.LKneeLAnkle(:,1));

% Variability
Zscores_nhr(21,1) = (COV.RightStepLength - mean(nhr.COV.RStepLength(:,1)))/std(nhr.COV.RStepLength(:,1));
Zscores_nhr(22,1) = (COV.LeftStepLength - mean(nhr.COV.LStepLength(:,1)))/std(nhr.COV.LStepLength(:,1));
Zscores_nhr(23,1) = (COV.C7 - mean(nhr.COV.C7(:,1)))/std(nhr.COV.C7(:,1));
end