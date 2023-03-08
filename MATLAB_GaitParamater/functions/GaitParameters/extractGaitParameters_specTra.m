%% ########################################################################
% specTra poject
% Extraction of gait parameters 
%
% Version 11. January 2021
% Author: Pauline Rose Gut
% #########################################################################

function [S] = extractGaitParameters_specTra(S, jointAngleType, nhr)
S = extractJointAngles(S, jointAngleType);
S = extractCoM(S);
S = extractSpatioTemp(S);
S = extractROM(S);
S = extractCyclogramsACC(S, jointAngleType);
S = ASI(S); 
S = CoMRange(S); 
S = LegPhaseDispersion(S); 
S = SSD_reference(S, nhr);
S = SpineLateralFlexion(S); 
S = SpineFlexionExtension(S);
S.StepWidth = mean([mean([S.R.stepWidth].'), mean([S.L.stepWidth].')]);
S = DoubleLimbSupport(S); 
S = C7TrajectoryLength(S);
S.COV.RightStepLength = std([S.R.stepLength].')/mean([S.R.stepLength].');
S.COV.LeftStepLength = std([S.L.stepLength].')/mean([S.L.stepLength].');
S.COV.C7 = std(S.C7TrajectoryLength.All)/mean(S.C7TrajectoryLength.All);
end