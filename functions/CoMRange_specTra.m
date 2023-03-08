%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% Center of Mass (CoM) ML and AP range
%
% Version 15. March 2021
% Author: Pauline Rose Gut
% #########################################################################


function COM = CoMRange_specTra(S1, S2)
% Left
for i = 1:size(S1.L, 2)
    COM.ML.Left(i,:) = range(S1.L(i).points.CentreOfMassFloor(:,1));
    COM.AP.Left(i,:) = range(S1.L(i).points.CentreOfMassFloor(:,2));
end
clear i
for i = 1:size(S2.L, 2)
    COM.ML.Left(i,:) = range(S2.L(i).points.CentreOfMassFloor(:,1));
    COM.AP.Left(i,:) = range(S2.L(i).points.CentreOfMassFloor(:,2));
end
clear i 
% Right
for i = 1:size(S1.R, 2)
    COM.ML.Right(i,:) = range(S1.R(i).points.CentreOfMassFloor(:,1));
    COM.AP.Right(i,:) = range(S1.R(i).points.CentreOfMassFloor(:,2));
end
clear i
for i = 1:size(S2.R, 2)
    COM.ML.Right(i,:) = range(S2.R(i).points.CentreOfMassFloor(:,1));
    COM.AP.Right(i,:) = range(S2.R(i).points.CentreOfMassFloor(:,2));
end
clear i

end