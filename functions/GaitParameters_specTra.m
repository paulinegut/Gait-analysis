%% ########################################################################
% specTra
% Extraction of gait parameters with the Plug-in-Gait Model
% specTra: 23 gait parameters
%
% Version 15. March 2021
% Author: Pauline Rose Gut
% #########################################################################

function [Parameters] = GaitParameters_specTra(S1, S2, Cyclograms, COV)
% Range of motion
Parameters(1,1) = mean([[S1.R.ROMHipAnglesRangeSag].'; [S2.R.ROMHipAnglesRangeSag].']);
Parameters(2,1) = mean([[S1.L.ROMHipAnglesRangeSag].'; [S2.L.ROMHipAnglesRangeSag].']);
Parameters(3,1) = mean([[S1.R.ROMHipAnglesRangeFrnt].'; [S2.R.ROMHipAnglesRangeFrnt].']);
Parameters(4,1) = mean([[S1.L.ROMHipAnglesRangeFrnt].'; [S2.L.ROMHipAnglesRangeFrnt].']);
Parameters(5,1) = mean([[S1.R.ROMKneeAnglesRangeSag].'; [S2.R.ROMKneeAnglesRangeSag].']);
Parameters(6,1) = mean([[S1.L.ROMKneeAnglesRangeSag].'; [S2.L.ROMKneeAnglesRangeSag].']);
Parameters(7,1) = mean([[S1.R.ROMAnkleAnglesRangeSag].'; [S2.R.ROMAnkleAnglesRangeSag].']);
Parameters(8,1) = mean([[S1.L.ROMAnkleAnglesRangeSag].'; [S2.L.ROMAnkleAnglesRangeSag].']);
Parameters(9,1) = mean([S1.Spine.LateralFlexion.Mean(:,1); S2.Spine.LateralFlexion.Mean(:,1)]);
Parameters(10,1) = mean([S1.Spine.FlexionExtension.Mean(:,1); S2.Spine.FlexionExtension.Mean(:,1)]);

% Interlimb coordination
Parameters(12,1) = mean([S1.PhaseDispersion.Leg; S2.PhaseDispersion.Leg]);

% Intralimb coordination
% SSD
Parameters(13,1) = Cyclograms.SSD.R.HipKneeSag;
Parameters(14,1) = Cyclograms.SSD.L.HipKneeSag;
Parameters(15,1) = Cyclograms.SSD.R.KneeAnkleSag;
Parameters(16,1) = Cyclograms.SSD.L.KneeAnkleSag;
% ACC
Parameters(17,1) = Cyclograms.ACC.R.HipKnee;
Parameters(18,1) = Cyclograms.ACC.L.HipKnee;
Parameters(19,1) = Cyclograms.ACC.R.KneeAnkle;
Parameters(20,1) = Cyclograms.ACC.L.KneeAnkle;

% Variability
Parameters(21,1) = COV.RightStepLength;
Parameters(22,1) = COV.LeftStepLength;
Parameters(23,1) = COV.C7;
end