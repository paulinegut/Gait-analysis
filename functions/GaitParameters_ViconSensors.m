%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% Clinical gait profile containing 38 gait parameters
%
% Version 15. March 2021
% Author: Pauline Rose Gut
% #########################################################################

function [Parameters] = GaitParameters_ViconSensors(S, Handrails)
% Endpoint excursion
Parameters(1,1) = mean([S.R.stepLength].');
Parameters(2,1) = mean([S.L.stepLength].');
Parameters(3,1) = mean(S.ToeHeight.RToeHeight);
Parameters(4,1) = mean(S.ToeHeight.LToeHeight);
if Handrails == 0
    Parameters(5,1) = mean(S.WristTrajectoryLength.RWristTrajectoryLength);
    Parameters(6,1) = mean(S.WristTrajectoryLength.LWristTrajectoryLength);
else
    Parameters(5,1) = 0; Parameters(5,1) = standardizeMissing(Parameters(5,1),0);
    Parameters(6,1) = 0; Parameters(6,1) = standardizeMissing(Parameters(6,1),0);
end

% Range of motion
Parameters(7,1) = mean([S.R.ROMHipAnglesRangeSag].');
Parameters(8,1) = mean([S.L.ROMHipAnglesRangeSag].');
Parameters(9,1) = mean([S.R.ROMKneeAnglesRangeSag].');
Parameters(10,1) = mean([S.L.ROMKneeAnglesRangeSag].');
Parameters(11,1) = mean([S.R.ROMAnkleAnglesRangeSag].');
Parameters(12,1) = mean([S.L.ROMAnkleAnglesRangeSag].');

% Asymmetry
Parameters(13,1) = mean(S.ASI.HipASI);
Parameters(14,1) = mean(S.ASI.KneeASI);
Parameters(15,1) = mean(S.ASI.AnkleASI);

% Stability
x2 = mean([S.R.stepWidth].'); x3 = mean([S.L.stepWidth].'); 
Parameters(16,1) = mean([x2 x3]); clear x2 x3;
Parameters(17,1) = mean(S.C7TrajectoryLength);
Parameters(18,1) = mean(S.COM.ML);
Parameters(19,1) = mean(S.COM.AP);

% Interlimb coordination
Parameters(20,1) = mean(S.PhaseDispersion.Leg);
if Handrails == 0
    Parameters(21,1) = mean(S.PhaseDispersion.Arm);
else 
    Parameters(21,1) = 0; Parameters(21,1) = standardizeMissing(Parameters(21,1),0);
end

% Temporal
Parameters(22,1) = S.DoubleLimbSupport.Mean;
Parameters(23,1) = mean(S.Stance.Right);
Parameters(24,1) = mean(S.Stance.Left);

% Variability
Parameters(25,1) = S.COV.RightStepLength;
Parameters(26,1) = S.COV.LeftStepLength;
Parameters(27,1) = S.COV.StepWidth;
Parameters(28,1) = S.COV.C7;

% Intralimb coordination
% SSD
% Parameters(29,1) = S.cyclograms.SSD.R.HipKneeSag;
% Parameters(30,1) = S.cyclograms.SSD.L.HipKneeSag;
% Parameters(31,1) = S.cyclograms.SSD.R.KneeAnkleSag;
% Parameters(32,1) = S.cyclograms.SSD.L.KneeAnkleSag;
% ACC
Parameters(33,1) = S.cyclograms.ACC.R.HipKnee;
Parameters(34,1) = S.cyclograms.ACC.L.HipKnee;
Parameters(35,1) = S.cyclograms.ACC.R.KneeAnkle;
Parameters(36,1) = S.cyclograms.ACC.L.KneeAnkle;
end