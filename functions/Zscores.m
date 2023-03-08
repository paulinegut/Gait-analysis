%% ########################################################################
% Gait Analysis
% Z-scores
%
% Version 5. March 2021
% Author: Pauline Rose Gut
% #########################################################################

function [Zscores] = Zscores(S, Handrails, nhr)
% Endpoint excursion
Zscores(1,1) = (mean([S.R.stepLength].') - mean(nhr.StepLength.RStepLength(:,1)))/std(nhr.StepLength.RStepLength(:,1));
Zscores(2,1) = (mean([S.L.stepLength].') - mean(nhr.StepLength.LStepLength(:,1)))/std(nhr.StepLength.LStepLength(:,1));
Zscores(3,1) = (mean(S.ToeHeight.RToeHeight) - mean(nhr.ToeHeight.RToeHeight(:,1)))/std(nhr.ToeHeight.RToeHeight(:,1));
Zscores(4,1) = (mean(S.ToeHeight.LToeHeight) - mean(nhr.ToeHeight.LToeHeight(:,1)))/std(nhr.ToeHeight.LToeHeight(:,1));
if Handrails == 0
    Zscores(5,1) = (mean(S.WristTrajectoryLength.RWristTrajectoryLength) - mean(nhr.WristTrajectoryLength.RWristTrajectoryLength(:,1)))/std(nhr.WristTrajectoryLength.RWristTrajectoryLength(:,1));
    Zscores(6,1) = (mean(S.WristTrajectoryLength.LWristTrajectoryLength) - mean(nhr.WristTrajectoryLength.LWristTrajectoryLength(:,1)))/std(nhr.WristTrajectoryLength.LWristTrajectoryLength(:,1));
else
    Zscores(5,1) = 0; Zscores(5,1) = standardizeMissing(Zscores(5,1),0);
    Zscores(6,1) = 0; Zscores(6,1) = standardizeMissing(Zscores(6,1),0);
end

% Range of motion
% Hip Sagittal: Flexion/Extension
Zscores(7,1) = (mean([S.R.ROMHipAnglesRangeSag].') - mean(nhr.ROM.Sagittal.RHip(:,1)))/std(nhr.ROM.Sagittal.RHip(:,1));
Zscores(8,1) = (mean([S.L.ROMHipAnglesRangeSag].') - mean(nhr.ROM.Sagittal.LHip(:,1)))/std(nhr.ROM.Sagittal.LHip(:,1));
% Knee Sagittal: Flexion/Extension
Zscores(9,1) = (mean([S.R.ROMKneeAnglesRangeSag].') - mean(nhr.ROM.Sagittal.RKnee(:,1)))/std(nhr.ROM.Sagittal.RKnee(:,1));
Zscores(10,1) = (mean([S.L.ROMKneeAnglesRangeSag].') - mean(nhr.ROM.Sagittal.LKnee(:,1)))/std(nhr.ROM.Sagittal.LKnee(:,1));
% Ankle Sagittal: Flexion/Extension
Zscores(11,1) = (mean([S.R.ROMAnkleAnglesRangeSag].') - mean(nhr.ROM.Sagittal.RAnkle(:,1)))/std(nhr.ROM.Sagittal.RAnkle(:,1));
Zscores(12,1) = (mean([S.L.ROMAnkleAnglesRangeSag].') - mean(nhr.ROM.Sagittal.LAnkle(:,1)))/std(nhr.ROM.Sagittal.LAnkle(:,1));

% Asymmetry
Zscores(13,1) = (mean(S.ASI.HipASI) - mean(nhr.ASI.HipASI(:,1)))/std(nhr.ASI.HipASI(:,1));
Zscores(14,1) = (mean(S.ASI.KneeASI) - mean(nhr.ASI.KneeASI(:,1)))/std(nhr.ASI.KneeASI(:,1));
Zscores(15,1) = (mean(S.ASI.AnkleASI) - mean(nhr.ASI.AnkleASI(:,1)))/std(nhr.ASI.AnkleASI(:,1));

% Stability/Balance
Zscores(16,1) = (S.StepWidth - mean(nhr.StepWidth(:,1)))/std(nhr.StepWidth(:,1));
Zscores(17,1) = (mean(S.C7TrajectoryLength) - mean(nhr.C7TrajectoryLength(:,1)))/std(nhr.C7TrajectoryLength(:,1));
Zscores(18,1) = (mean(S.COM.ML) - mean(nhr.COM.ML(:,1)))/std(nhr.COM.ML(:,1));
Zscores(19,1) = (mean(S.COM.AP) - mean(nhr.COM.AP(:,1)))/std(nhr.COM.AP(:,1));

% Interlimb coordination
Zscores(20,1) = abs((mean(S.PhaseDispersion.Leg) - mean(nhr.PhaseDispersion.Leg(:,1)))/std(nhr.PhaseDispersion.Leg(:,1)));
if Handrails == 0
    Zscores(21,1) = abs((mean(S.PhaseDispersion.Arm) - mean(nhr.PhaseDispersion.Arm(:,1)))/std(nhr.PhaseDispersion.Arm(:,1)));
else
    Zscores(21,1) = 0; Zscores(21,1) = standardizeMissing(Zscores(21,1),0);
end

% Temporal
Zscores(22,1) = (S.DoubleLimbSupport.Mean - mean(nhr.DoubleLimbSupport(:,1)))/std(nhr.DoubleLimbSupport(:,1));
Zscores(23,1) = (mean(S.Stance.Right) - mean(nhr.Stance.RStance(:,1)))/std(nhr.Stance.RStance(:,1));
Zscores(24,1) = (mean(S.Stance.Left) - mean(nhr.Stance.LStance(:,1)))/std(nhr.Stance.LStance(:,1));

% Variability
Zscores(25,1) = (S.COV.RightStepLength - mean(nhr.COV.RStepLength(:,1)))/std(nhr.COV.RStepLength(:,1));
Zscores(26,1) = (S.COV.LeftStepLength - mean(nhr.COV.LStepLength(:,1)))/std(nhr.COV.LStepLength(:,1));
Zscores(27,1) = (S.COV.StepWidth - mean(nhr.COV.StepWidth(:,1)))/std(nhr.COV.StepWidth(:,1));
Zscores(28,1) = (S.COV.C7 - mean(nhr.COV.C7(:,1)))/std(nhr.COV.C7(:,1));

% Intralimb coordination
% SSD
Zscores(29,1) = (S.cyclograms.SSD.R.HipKneeSag - mean(nhr.cyclograms.SSD.Sagittal.RHipRKnee(:,1)))/std(nhr.cyclograms.SSD.Sagittal.RHipRKnee(:,1));
Zscores(30,1) = (S.cyclograms.SSD.L.HipKneeSag - mean(nhr.cyclograms.SSD.Sagittal.LHipLKnee(:,1)))/std(nhr.cyclograms.SSD.Sagittal.LHipLKnee(:,1));
Zscores(31,1) = (S.cyclograms.SSD.R.KneeAnkleSag - mean(nhr.cyclograms.SSD.Sagittal.RKneeRAnkle(:,1)))/std(nhr.cyclograms.SSD.Sagittal.RKneeRAnkle(:,1));
Zscores(32,1) = (S.cyclograms.SSD.L.KneeAnkleSag - mean(nhr.cyclograms.SSD.Sagittal.LKneeLAnkle(:,1)))/std(nhr.cyclograms.SSD.Sagittal.LKneeLAnkle(:,1));

% ACC
Zscores(33,1) = (S.cyclograms.ACC.R.HipKnee - mean(nhr.cyclograms.ACC.RHipRKnee(:,1)))/std(nhr.cyclograms.ACC.RHipRKnee(:,1));
Zscores(34,1) = (S.cyclograms.ACC.L.HipKnee - mean(nhr.cyclograms.ACC.LHipLKnee(:,1)))/std(nhr.cyclograms.ACC.LHipLKnee(:,1));
Zscores(35,1) = (S.cyclograms.ACC.R.KneeAnkle - mean(nhr.cyclograms.ACC.RKneeRAnkle(:,1)))/std(nhr.cyclograms.ACC.RKneeRAnkle(:,1));
Zscores(36,1) = (S.cyclograms.ACC.L.KneeAnkle - mean(nhr.cyclograms.ACC.LKneeLAnkle(:,1)))/std(nhr.cyclograms.ACC.LKneeLAnkle(:,1));
end