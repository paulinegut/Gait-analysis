%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% Leg Phase Dispersion calculation
%
% Version 3. December 2020
% Author: Pauline Rose Gut
% #########################################################################

function [S] = LegPhaseDispersion(S)

% Right Leg
if S.evts.Right_Foot_Strike(1,1) < S.evts.Left_Foot_Strike(1,1)
    for i = 1:size(S.evts.Right_Foot_Strike, 2)-1
        RS(i,1) = S.evts.Right_Foot_Strike(1,i+1) - S.evts.Right_Foot_Strike(1,i);
        LS(i,1) = S.evts.Left_Foot_Strike(1,i) - S.evts.Right_Foot_Strike(1,i);
        S.PhaseDispersion.Leg(i,1) = LS(i,1)*100/RS(i,1);
    end
    clear i RS LS
else
    for i = 1:size(S.evts.Left_Foot_Strike, 2)-1
        LS(i,1) = S.evts.Left_Foot_Strike(1,i+1) - S.evts.Left_Foot_Strike(1,i);
        RS(i,1) = S.evts.Right_Foot_Strike(1,i) - S.evts.Left_Foot_Strike(1,i);
        S.PhaseDispersion.Leg(i,1) = RS(i,1)*100/LS(i,1);
    end
    clear i RS LS
end 

end