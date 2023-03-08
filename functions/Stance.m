%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% Right stance and left stance calculation
%
% Version 9. December 2020
% Author: Pauline Rose Gut
% #########################################################################

function [S] = Stance(S)
A = [S.R.stanceTime].' + [S.R.swingTime].';
B = [S.R.stanceTime].';

for i = 1:length(A)
    S.Stance.Right(i,1) = B(i,1)*100/A(i,1); % [%]
end
clear i A B

A = [S.L.stanceTime].' + [S.L.swingTime].';
B = [S.L.stanceTime].';

for i = 1:length(A)
    S.Stance.Left(i,1) = B(i,1)*100/A(i,1); % [%]
end
clear i A B
end