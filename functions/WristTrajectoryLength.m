%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% Wrist Trajectory Length calculation
%
% Version 3. December 2020
% Author: Pauline Rose Gut
% #########################################################################

function [S] = WristTrajectoryLength(S)
for i = 1:size(S.R, 2)
    for ii = 1:size(S.R(i).points.RWRA, 1)
        RWristCenter(ii, :) = [(S.R(i).points.RWRA(ii,1) + S.R(i).points.RWRB(ii,1))/2, ...
                                (S.R(i).points.RWRA(ii,2) + S.R(i).points.RWRB(ii,2))/2, ...
                                (S.R(i).points.RWRA(ii,3) + S.R(i).points.RWRB(ii,3))/2];
    end
    
    for ii = 1:size(S.R(i).points.RWRA, 1) - 1 
        Distance(ii,:) = sqrt((RWristCenter(ii+1,1) - RWristCenter(ii,1))^2 + ...
                                (RWristCenter(ii+1,2) - RWristCenter(ii,2))^2 + ...
                                (RWristCenter(ii+1,3) - RWristCenter(ii,3))^2);
    end
    
    S.WristTrajectoryLength.RWristTrajectoryLength(i,1) = sum(Distance);
    clear RWristCenter Distance
end
clear i ii

for i = 1:size(S.L, 2)
    for ii = 1:size(S.L(i).points.LWRA, 1)
        LWristCenter(ii, :) = [(S.L(i).points.LWRA(ii,1) + S.L(i).points.LWRB(ii,1))/2, ...
                                (S.L(i).points.LWRA(ii,2) + S.L(i).points.LWRB(ii,2))/2, ...
                                (S.L(i).points.LWRA(ii,3) + S.L(i).points.LWRB(ii,3))/2];
    end
    
    for ii = 1:size(S.L(i).points.LWRA, 1) - 1 
        Distance(ii,:) = sqrt((LWristCenter(ii+1,1) - LWristCenter(ii,1))^2 + ...
                                (LWristCenter(ii+1,2) - LWristCenter(ii,2))^2 + ...
                                (LWristCenter(ii+1,3) - LWristCenter(ii,3))^2);
    end
    
    S.WristTrajectoryLength.LWristTrajectoryLength(i,1) = sum(Distance);
    clear LWristCenter Distance
end
clear i ii
end
