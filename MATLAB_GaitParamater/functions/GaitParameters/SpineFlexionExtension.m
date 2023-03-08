%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% Spine flexion/extension calculation (sagittal plane)
%
% Angle between the sagittal thorax axis and the sagittal pelvis axis 
% around the fixed transverse axis of the pelvis.
%
% A positive angle value corresponds to the situation in which the thorax 
% is tilted forward.
% Relative 
%
% Version 15. January 2021
% Author: Pauline Rose Gut
% #########################################################################

function [S] = SpineFlexionExtension(S)

% Spine Lateral Flexion
% Right cycle
for i = 1:length(S.R)
    a1(:,i) = S.R(i).angs.RSpineAngles(:,1); 
end
clear i;
b1 = mean(a1,2); 
for i = 1:size(a1,1)
    c1(i,1) = std(a1(i,:));
end
clear i;
% Left cycle
for i = 1:length(S.L)
    a2(:,i) = S.L(i).angs.RSpineAngles(:,1);
end
clear i;
b2 = mean(a2,2); 
for i = 1:size(a2,1)
    c2(i,1) = std(a2(i,:));
end
clear i;

X = [a1 a2];
S.Spine.FlexionExtension.Angles = X; % + is forward, - is backward
clear X a1 a2;
S.Spine.FlexionExtension.Mean = mean([b1 b2], 2); 
clear b1 b2;
S.Spine.FlexionExtension.Mean(:,2) = mean([c1 c2], 2);
clear c1 c2;

end