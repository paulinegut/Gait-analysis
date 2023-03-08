%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% Arm Phase Dispersion calculation
%
% Version 3. December 2020
% Author: Pauline Rose Gut
% #########################################################################

function [S] = ArmPhaseDispersion(S)

% Right Leg
if length(S.evts.RArmProtaction) < length(S.evts.LArmProtaction)
    if S.evts.RArmProtaction(1,1) < S.evts.LArmProtaction(1,1)
        for i = 1:size(S.evts.RArmProtaction, 2)-1
            RP(i,1) = S.evts.RArmProtaction(1,i+1) - S.evts.RArmProtaction(1,i);
            LP(i,1) = S.evts.LArmProtaction(1,i) - S.evts.RArmProtaction(1,i);
            S.PhaseDispersion.Arm(i,1) = LP(i,1)*100/RP(i,1);
        end
        clear i RP LP
    else
        for i = 1:size(S.evts.RArmProtaction, 2)-1
            LP(i,1) = S.evts.LArmProtaction(1,i+1) - S.evts.LArmProtaction(1,i);
            RP(i,1) = S.evts.RArmProtaction(1,i) - S.evts.LArmProtaction(1,i);
            S.PhaseDispersion.Arm(i,1) = RP(i,1)*100/LP(i,1);
        end
        clear i RP LP
    end 
else
     if S.evts.RArmProtaction(1,1) < S.evts.LArmProtaction(1,1)
        for i = 1:size(S.evts.LArmProtaction, 2)-1
            RP(i,1) = S.evts.RArmProtaction(1,i+1) - S.evts.RArmProtaction(1,i);
            LP(i,1) = S.evts.LArmProtaction(1,i) - S.evts.RArmProtaction(1,i);
            S.PhaseDispersion.Arm(i,1) = LP(i,1)*100/RP(i,1);
        end
        clear i RP LP
    else
        for i = 1:size(S.evts.LArmProtaction, 2)-1
            LP(i,1) = S.evts.LArmProtaction(1,i+1) - S.evts.LArmProtaction(1,i);
            RP(i,1) = S.evts.RArmProtaction(1,i) - S.evts.LArmProtaction(1,i);
            S.PhaseDispersion.Arm(i,1) = RP(i,1)*100/LP(i,1);
        end
        clear i RP LP
    end 
end