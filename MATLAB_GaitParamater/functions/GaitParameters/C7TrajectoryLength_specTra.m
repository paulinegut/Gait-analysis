%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% C7 Trajectory Length calculation
%
% Version 15. March 2021
% Author: Pauline Rose Gut
% #########################################################################

function [C7TrajectoryLength] = C7TrajectoryLength_specTra(S1, S2)
% Left
for i = 1:size(S1.L, 2)
    for ii = 1:size(S1.L(i).points.C7, 1) - 1 
        DistanceL1(ii,:) = sqrt((S1.L(i).points.C7(ii+1,1) - S1.L(i).points.C7(ii,1))^2 + ...
                                (S1.L(i).points.C7(ii+1,2) - S1.L(i).points.C7(ii,2))^2 + ...
                                (S1.L(i).points.C7(ii+1,3) - S1.L(i).points.C7(ii,3))^2);
    end
    
    C7TrajectoryLengthL1(i,1) = sum(DistanceL1);
    clear DistanceL1
end
clear i ii

for i = 1:size(S2.L, 2)
    for ii = 1:size(S2.L(i).points.C7, 1) - 1 
        DistanceL2(ii,:) = sqrt((S2.L(i).points.C7(ii+1,1) - S2.L(i).points.C7(ii,1))^2 + ...
                                (S2.L(i).points.C7(ii+1,2) - S2.L(i).points.C7(ii,2))^2 + ...
                                (S2.L(i).points.C7(ii+1,3) - S2.L(i).points.C7(ii,3))^2);
    end
    
    C7TrajectoryLengthL2(i,1) = sum(DistanceL2);
    clear DistanceL2
end
clear i ii

% Right
for i = 1:size(S1.R, 2)
    for ii = 1:size(S1.R(i).points.C7, 1) - 1 
        DistanceR1(ii,:) = sqrt((S1.R(i).points.C7(ii+1,1) - S1.R(i).points.C7(ii,1))^2 + ...
                                (S1.R(i).points.C7(ii+1,2) - S1.R(i).points.C7(ii,2))^2 + ...
                                (S1.R(i).points.C7(ii+1,3) - S1.R(i).points.C7(ii,3))^2);
    end
    
    C7TrajectoryLengthR1(i,1) = sum(DistanceR1);
    clear DistanceR1
end
clear i ii

for i = 1:size(S2.R, 2)
    for ii = 1:size(S2.R(i).points.C7, 1) - 1 
        DistanceR2(ii,:) = sqrt((S2.R(i).points.C7(ii+1,1) - S2.R(i).points.C7(ii,1))^2 + ...
                                (S2.R(i).points.C7(ii+1,2) - S2.R(i).points.C7(ii,2))^2 + ...
                                (S2.R(i).points.C7(ii+1,3) - S2.R(i).points.C7(ii,3))^2);
    end
    
    C7TrajectoryLengthR2(i,1) = sum(DistanceR2);
    clear DistanceR2
end
clear i ii


C7TrajectoryLength.Left = [C7TrajectoryLengthL1; C7TrajectoryLengthL2]; clear C7TrajectoryLengthL1 C7TrajectoryLengthL2
C7TrajectoryLength.Right = [C7TrajectoryLengthR1; C7TrajectoryLengthR2]; clear C7TrajectoryLengthR1 C7TrajectoryLengthR2

end