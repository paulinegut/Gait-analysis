%% ########################################################################
% Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% Spine lateral flexion calculation (frontal plane)
%
% Angle between the long axis of the thorax and the long axis of the pelvis, 
% around a floating transverse axis.
%
% Version 15. January 2021
% Author: Pauline Rose Gut
% #########################################################################

function [S] = SpineLateralFlexion(S)

% Spine Lateral Flexion
% Right cycle
for i = 1:length(S.R)
    a1(:,i) = S.R(i).angs.RSpineAngles(:,2); 
end
clear i;
b1 = mean(a1,2); 
for i = 1:size(a1,1)
    c1(i,1) = std(a1(i,:));
end
clear i;

% Left cycle
for i = 1:length(S.L)
    a2(:,i) = S.L(i).angs.RSpineAngles(:,2);
end
clear i;
b2 = mean(a2,2); 
for i = 1:size(a2,1)
    c2(i,1) = std(a2(i,:));
end
clear i;

X = [a1 a2];
S.Spine.LateralFlexion.Angles = X; 
clear X a1 a2;
S.Spine.LateralFlexion.Mean(:,1) = mean([b1 b2], 2); % Right is +, Left is -
clear b1 b2; 
S.Spine.LateralFlexion.Mean(:,2) = mean([c1 c2], 2);
clear c1 c2;

end