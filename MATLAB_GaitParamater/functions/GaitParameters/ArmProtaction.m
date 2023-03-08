%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% Toe Height calculation
%
% Version 3. December 2020
% Author: Pauline Rose Gut
% #########################################################################

function [S] = ArmProtaction(S)

% Right Arm Protaction
SignChange = diff(S.points.RWRA(:,2));  
for j = 1:length(SignChange)
   if SignChange(j,1) > 0
       temp(j,1) = 1;
   else
       temp(j,1) = 0;    
   end
end
RArmProtaction = diff(temp);
RArmProtaction = find(RArmProtaction==1)+1;
S.evts.RArmProtaction = RArmProtaction';
clear j temp SignChange RArmProtaction

% Left Arm Protaction
SignChange = diff(S.points.LWRA(:,2));  
for j = 1:length(SignChange)
   if SignChange(j,1) > 0
       temp(j,1) = 1;
   else
       temp(j,1) = 0;    
   end
end
LArmProtaction = diff(temp);
LArmProtaction = find(LArmProtaction==1)+1;
S.evts.LArmProtaction = LArmProtaction';
clear j temp SignChange LArmProtaction

end

