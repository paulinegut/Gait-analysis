%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% Clinical gait profile containing 38 gait parameters
%
% Version 5. March 2021
% Author: Pauline Rose Gut
% #########################################################################

function [Parameters] = GaitParameters_Std(S, Handrails, nhr)
% Endpoint excursion
Parameters(1,1) = std([S.R.stepLength].');
Parameters(2,1) = std([S.L.stepLength].');
Parameters(3,1) = std(S.ToeHeight.RToeHeight);
Parameters(4,1) = std(S.ToeHeight.LToeHeight);
if Handrails == 0
    Parameters(5,1) = std(S.WristTrajectoryLength.RWristTrajectoryLength);
    Parameters(6,1) = std(S.WristTrajectoryLength.LWristTrajectoryLength);
else
    Parameters(5,1) = 0; Parameters(5,1) = standardizeMissing(Parameters(5,1),0);
    Parameters(6,1) = 0; Parameters(6,1) = standardizeMissing(Parameters(6,1),0);
end

% Range of motion
Parameters(7,1) = std([S.R.ROMHipAnglesRangeSag].');
Parameters(8,1) = std([S.L.ROMHipAnglesRangeSag].');
Parameters(9,1) = std([S.R.ROMKneeAnglesRangeSag].');
Parameters(10,1) = std([S.L.ROMKneeAnglesRangeSag].');
Parameters(11,1) = std([S.R.ROMAnkleAnglesRangeSag].');
Parameters(12,1) = std([S.L.ROMAnkleAnglesRangeSag].');

% Asymmetry
Parameters(13,1) = std(S.ASI.HipASI);
Parameters(14,1) = std(S.ASI.KneeASI);
Parameters(15,1) = std(S.ASI.AnkleASI);

% Stability
x2 = std([S.R.stepWidth].'); x3 = std([S.L.stepWidth].'); 
Parameters(16,1) = mean([x2 x3]); clear x2 x3;
Parameters(17,1) = std(S.C7TrajectoryLength);
Parameters(18,1) = std(S.COM.ML);
Parameters(19,1) = std(S.COM.AP);

% Interlimb coordination
Parameters(20,1) = std(S.PhaseDispersion.Leg);
if Handrails == 0
    Parameters(21,1) = std(S.PhaseDispersion.Arm);
else 
    Parameters(21,1) = 0; Parameters(21,1) = standardizeMissing(Parameters(21,1),0);
end

% Temporal
Parameters(22,1) = S.DoubleLimbSupport.Std;
Parameters(23,1) = std(S.Stance.Right);
Parameters(24,1) = std(S.Stance.Left);

% Variability
Parameters(25,1) = 0; Parameters(25,1) = standardizeMissing(Parameters(25,1),0);
Parameters(26,1) = 0; Parameters(26,1) = standardizeMissing(Parameters(26,1),0);
Parameters(27,1) = 0; Parameters(27,1) = standardizeMissing(Parameters(27,1),0);
Parameters(28,1) = 0; Parameters(28,1) = standardizeMissing(Parameters(28,1),0);

% Intralimb coordination
% SSD
[S] = SSD_reference_std(S, nhr);
Parameters(29,1) = S.cyclograms.SSD.R.HipKneeSag_std;
Parameters(30,1) = S.cyclograms.SSD.L.HipKneeSag_std;
Parameters(31,1) = S.cyclograms.SSD.R.KneeAnkleSag_std;
Parameters(32,1) = S.cyclograms.SSD.L.KneeAnkleSag_std;
% ACC
Parameters(33,1) = S.cyclograms.ACC.R.HipKnee_std;
Parameters(34,1) = S.cyclograms.ACC.L.HipKnee_std;
Parameters(35,1) = S.cyclograms.ACC.R.KneeAnkle_std;
Parameters(36,1) = S.cyclograms.ACC.L.KneeAnkle_std;
end