%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% Center of Mass (CoM) ML and AP range
%
% Version 15. March 2021
% Author: Pauline Rose Gut
% #########################################################################


function [S] = CoMRange(S)
for i = 1:size(S.L, 2)
    COMML_L(i,:) = range(S.L(i).points.CentreOfMassFloor(:,1));
    COMAP_L(i,:) = range(S.L(i).points.CentreOfMassFloor(:,2));
end
clear i ii;

for i = 1:size(S.R, 2)
    COMML_R(i,:) = range(S.R(i).points.CentreOfMassFloor(:,1));
    COMAP_R(i,:) = range(S.R(i).points.CentreOfMassFloor(:,2));
end
clear i ii;

S.COM.ML = [COMML_L; COMML_R]; 
S.COM.ML_Left = COMML_L;
S.COM.ML_Right = COMML_R; clear COMML_L COMML_R;
S.COM.AP = [COMAP_L; COMAP_R];
S.COM.AP_Left = COMAP_L;
S.COM.AP_Right = COMAP_R; clear COMAP_L COMAP_R;
end