%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% Stability
%
% Version 15. March 2021
% Author: Pauline Rose Gut
% #########################################################################

function Stability = Stability(S1, S2)
Stability.StepWidth = mean([mean([[S1.R.stepWidth].'; [S2.R.stepWidth].']), mean([[S1.L.stepWidth].'; [S2.L.stepWidth].'])]);
Stability.DoubleLimbSupport = DoubleLimbSupport_specTra(S1, S2);
C7TrajectoryLength = C7TrajectoryLength_specTra(S1, S2);
Stability.C7TrajectoryLength = mean([mean(C7TrajectoryLength.Right), mean(C7TrajectoryLength.Left)]); clear C7TrajectoryLength;
Stability.COM = CoMRange_specTra(S1, S2);
end