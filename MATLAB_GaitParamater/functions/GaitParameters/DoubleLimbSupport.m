%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% Double limb support calculation
%
% Version 19. April 2021
% Author: Pauline Rose Gut
% #########################################################################

function [S] = DoubleLimbSupport(S)
A = [S.R.stanceTime].' + [S.R.swingTime].';
B = [S.R.doubleStance].';

for i = 1:length(A)
    DLSR(i,1) = B(i,1)*100/A(i,1);
end
clear i A B

A = [S.L.stanceTime].' + [S.L.swingTime].';
B = [S.L.doubleStance].';

for i = 1:length(A)
    DLSL(i,1) = B(i,1)*100/A(i,1);
end
clear i A B

S.DoubleLimbSupport.DLS = [DLSL; DLSR];
S.DoubleLimbSupport.DLS_Left = DLSL;
S.DoubleLimbSupport.DLS_Right = DLSR;
S.DoubleLimbSupport.Mean = mean(S.DoubleLimbSupport.DLS); % [%]
S.DoubleLimbSupport.Std = std(S.DoubleLimbSupport.DLS);
clear DLSL DLSR;
end