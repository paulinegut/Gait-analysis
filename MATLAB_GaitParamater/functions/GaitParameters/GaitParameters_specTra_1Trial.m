%% ########################################################################
% specTra
% Extraction of gait parameters with the Plug-in-Gait Model
% specTra: 23 gait parameters
%
% Version 15. March 2021
% Author: Pauline Rose Gut
% #########################################################################

function [Parameters] = GaitParameters_specTra_1Trial(S1)
% Range of motion
Parameters(1,1) = mean([S1.R.ROMHipAnglesRangeSag].');
Parameters(2,1) = mean([S1.L.ROMHipAnglesRangeSag].');
Parameters(3,1) = mean([S1.R.ROMHipAnglesRangeFrnt].');
Parameters(4,1) = mean([S1.L.ROMHipAnglesRangeFrnt].');
Parameters(5,1) = mean([S1.R.ROMKneeAnglesRangeSag].');
Parameters(6,1) = mean([S1.L.ROMKneeAnglesRangeSag].');
Parameters(7,1) = mean([S1.R.ROMAnkleAnglesRangeSag].');
Parameters(8,1) = mean([S1.L.ROMAnkleAnglesRangeSag].');
Parameters(9,1) = mean(S1.Spine.LateralFlexion.Mean(:,1));
Parameters(10,1) = mean(S1.Spine.FlexionExtension.Mean(:,1));

% Interlimb coordination
Parameters(12,1) = mean(S1.PhaseDispersion.Leg);

% Intralimb coordination
% SSD
Parameters(13,1) = S1.cyclograms.SSD.R.HipKneeSag;
Parameters(14,1) = S1.cyclograms.SSD.L.HipKneeSag;
Parameters(15,1) = S1.cyclograms.SSD.R.KneeAnkleSag;
Parameters(16,1) = S1.cyclograms.SSD.L.KneeAnkleSag;
% ACC
Parameters(17,1) = S1.cyclograms.ACC.R.HipKnee;
Parameters(18,1) = S1.cyclograms.ACC.L.HipKnee;
Parameters(19,1) = S1.cyclograms.ACC.R.KneeAnkle;
Parameters(20,1) = S1.cyclograms.ACC.L.KneeAnkle;

% Variability
Parameters(21,1) = S1.COV.RightStepLength;
Parameters(22,1) = S1.COV.LeftStepLength;
Parameters(23,1) = S1.COV.C7;
end