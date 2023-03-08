%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% Left Upper Lower Phase Dispersion
%
% Version 3. December 2020
% Author: Pauline Rose Gut
% #########################################################################

function [S] = LeftUpperLowerPhaseDispersion(S)

if length(S.evts.Left_Foot_Off) < length(S.evts.LArmProtaction)
   if S.evts.Left_Foot_Off(1,1) < S.evts.LArmProtaction(1,1)
        for i = 1:size(S.evts.Left_Foot_Off, 2)-1
            LO(i,1) = S.evts.Left_Foot_Off(1,i+1) - S.evts.Left_Foot_Off(1,i);
            LP(i,1) = S.evts.LArmProtaction(1,i) - S.evts.Left_Foot_Off(1,i);
            S.PhaseDispersion.LeftUpperLower(i,1) = LP(i,1)*100/LO(i,1);
        end
    clear i LP LO
    else
        for i = 1:size(S.evts.Left_Foot_Off, 2)-1
            LO(i,1) = S.evts.Left_Foot_Off(1,i+1) - S.evts.Left_Foot_Off(1,i);
            LP(i,1) = S.evts.LArmProtaction(1,i+1) - S.evts.Left_Foot_Off(1,i);
            S.PhaseDispersion.LeftUpperLower(i,1) = LP(i,1)*100/LO(i,1);
        end
    clear i LP LO
    end 
else
    if S.evts.Left_Foot_Off(1,1) < S.evts.LArmProtaction(1,1)
        for i = 1:size(S.evts.LArmProtaction, 2)-1
            LO(i,1) = S.evts.Left_Foot_Off(1,i+1) - S.evts.Left_Foot_Off(1,i);
            LP(i,1) = S.evts.LArmProtaction(1,i) - S.evts.Left_Foot_Off(1,i);
            S.PhaseDispersion.LeftUpperLower(i,1) = LP(i,1)*100/LO(i,1);
        end
    clear i LP LO
    else
        for i = 1:size(S.evts.LArmProtaction, 2)-1
            LO(i,1) = S.evts.Left_Foot_Off(1,i+1) - S.evts.Left_Foot_Off(1,i);
            LP(i,1) = S.evts.LArmProtaction(1,i+1) - S.evts.Left_Foot_Off(1,i);
            S.PhaseDispersion.LeftUpperLower(i,1) = LP(i,1)*100/LO(i,1);
        end
    clear i LP LO
    end 
end
end