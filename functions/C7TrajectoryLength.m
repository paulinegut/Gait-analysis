%% ########################################################################
% Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% C7 Trajectory Length calculation
%
% Version 15. March 2021
% Author: Pauline Rose Gut
% #########################################################################

function [S] = C7TrajectoryLength(S)
for i = 1:size(S.L, 2)
    for ii = 1:size(S.L(i).points.C7, 1) - 1 
        DistanceL(ii,:) = sqrt((S.L(i).points.C7(ii+1,1) - S.L(i).points.C7(ii,1))^2 + ...
                                (S.L(i).points.C7(ii+1,2) - S.L(i).points.C7(ii,2))^2 + ...
                                (S.L(i).points.C7(ii+1,3) - S.L(i).points.C7(ii,3))^2);
    end
    
    C7TrajectoryLengthL(i,1) = sum(DistanceL);
    clear DistanceL
end
clear i ii;

for i = 1:size(S.R, 2)
    for ii = 1:size(S.R(i).points.C7, 1) - 1 
        DistanceR(ii,:) = sqrt((S.R(i).points.C7(ii+1,1) - S.R(i).points.C7(ii,1))^2 + ...
                                (S.R(i).points.C7(ii+1,2) - S.R(i).points.C7(ii,2))^2 + ...
                                (S.R(i).points.C7(ii+1,3) - S.R(i).points.C7(ii,3))^2);
    end
    
    C7TrajectoryLengthR(i,1) = sum(DistanceR);
    clear DistanceR
end
clear i ii;

S.C7TrajectoryLength.All(:,1) = [C7TrajectoryLengthL; C7TrajectoryLengthR];
S.C7TrajectoryLength.Left(:,1) = C7TrajectoryLengthL;
S.C7TrajectoryLength.Right(:,1) = C7TrajectoryLengthR;

end