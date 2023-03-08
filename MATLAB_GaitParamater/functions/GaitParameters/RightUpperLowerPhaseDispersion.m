%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% Right Upper Lower Phase Dispersion
%
% Version 3. December 2020
% Author: Pauline Rose Gut
% #########################################################################

function [S] = RightUpperLowerPhaseDispersion(S)

if length(S.evts.Right_Foot_Off) < length(S.evts.RArmProtaction)
    if S.evts.Right_Foot_Off(1,1) < S.evts.RArmProtaction(1,1)
        for i = 1:size(S.evts.Right_Foot_Off, 2)-1
            RO(i,1) = S.evts.Right_Foot_Off(1,i+1) - S.evts.Right_Foot_Off(1,i);
            RP(i,1) = S.evts.RArmProtaction(1,i) - S.evts.Right_Foot_Off(1,i);
            S.PhaseDispersion.RightUpperLower(i,1) = RP(i,1)*100/RO(i,1);
        end
    clear i RP RO
    else
        for i = 1:size(S.evts.Right_Foot_Off, 2)-1
            RO(i,1) = S.evts.Right_Foot_Off(1,i+1) - S.evts.Right_Foot_Off(1,i);
            RP(i,1) = S.evts.RArmProtaction(1,i+1) - S.evts.Right_Foot_Off(1,i);
            S.PhaseDispersion.RightUpperLower(i,1) = RP(i,1)*100/RO(i,1);
        end
    clear i RP RO
    end 

else
    if S.evts.Right_Foot_Off(1,1) < S.evts.RArmProtaction(1,1)
        for i = 1:size(S.evts.RArmProtaction, 2)-1
            RO(i,1) = S.evts.Right_Foot_Off(1,i+1) - S.evts.Right_Foot_Off(1,i);
            RP(i,1) = S.evts.RArmProtaction(1,i) - S.evts.Right_Foot_Off(1,i);
            S.PhaseDispersion.RightUpperLower(i,1) = RP(i,1)*100/RO(i,1);
        end
    clear i RP RO
    else
        for i = 1:size(S.evts.RArmProtaction, 2)-1
            RO(i,1) = S.evts.Right_Foot_Off(1,i+1) - S.evts.Right_Foot_Off(1,i);
            RP(i,1) = S.evts.RArmProtaction(1,i+1) - S.evts.Right_Foot_Off(1,i);
            S.PhaseDispersion.RightUpperLower(i,1) = RP(i,1)*100/RO(i,1);
        end
    clear i RP RO
    end 
end 

% if S.evts.Right_Foot_Off(1,1) < S.evts.RArmProtaction(1,1)
%     for i = 1:size(S.evts.Right_Foot_Off, 2)-1
%         RO(i,1) = S.evts.Right_Foot_Off(1,i+1) - S.evts.Right_Foot_Off(1,i);
%         RP(i,1) = S.evts.RArmProtaction(1,i) - S.evts.Right_Foot_Off(1,i);
%         S.PhaseDispersion.RightUpperLower(i,1) = RP(i,1)*100/RO(i,1);
%     end
%     clear i RP RO
% else
%     for i = 1:size(S.evts.RArmProtaction, 2)-1
%         RO(i,1) = S.evts.Right_Foot_Off(1,i+1) - S.evts.Right_Foot_Off(1,i);
%         RP(i,1) = S.evts.RArmProtaction(1,i+1) - S.evts.Right_Foot_Off(1,i);
%         S.PhaseDispersion.RightUpperLower(i,1) = RP(i,1)*100/RO(i,1);
%     end
%     clear i RP RO
% end 
end