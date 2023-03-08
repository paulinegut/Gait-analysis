%% ########################################################################
% Extraction of gait parameters 
%
% Version 15. March 2021
% Author: Pauline Rose Gut
% #########################################################################

function [S] = extractGaitParameters_ViconSensors(S, jointAngleType)
S = extractJointAngles(S, jointAngleType);
S = extractCoM(S);
S =  extractSpatioTemp(S);
S = extractROM(S);
S = extractCyclogramsACC(S, jointAngleType);
S = ASI(S); 
S = ToeHeight(S); 
S = C7TrajectoryLength(S); 
S = CoMRange(S); 
S = LegPhaseDispersion(S); 
% S = SSD_reference(S, nhr);
S = SpineLateralFlexion(S); 
S = SpineFlexionExtension(S);
S.StepWidth = mean([[S.R.stepWidth].'; [S.L.stepWidth].']);
S = DoubleLimbSupport(S); 
S = Stance(S);
S.COV.RightStepLength = std([S.R.stepLength].')/mean([S.R.stepLength].');
S.COV.LeftStepLength = std([S.L.stepLength].')/mean([S.L.stepLength].');
S.COV.StepWidth = std([[S.R.stepWidth].'; [S.L.stepWidth].'])/mean([[S.R.stepWidth].'; [S.L.stepWidth].']);
S.COV.C7 = std(S.C7TrajectoryLength)/mean(S.C7TrajectoryLength);
S = WristTrajectoryLength(S); 
S = ArmProtaction(S); 
S = ArmPhaseDispersion(S);
% S = RightUpperLowerPhaseDispersion(S);
% S = LeftUpperLowerPhaseDispersion(S);
end