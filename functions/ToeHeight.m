%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% Toe Height calculation
%
% Version 3. December 2020
% Author: Pauline Rose Gut
% #########################################################################

function [S] = ToeHeight(S)
% Right Foot
% Find toe height at mid swing and mid stance
if S.evts.Right_Foot_Off(1,1) < S.evts.Right_Foot_Strike(1,1)
    for i = 1: size(S.evts.Right_Foot_Off, 2)-1
        Right_Mid_Swing(i,1) = round((S.evts.Right_Foot_Off(1,i) + S.evts.Right_Foot_Strike(1,i))/2);
        Right_Mid_Stance(i,1) = round((S.evts.Right_Foot_Off(1,i+1) + S.evts.Right_Foot_Strike(1,i))/2);
    end
    clear i
    
else
    for i = 1: size(S.evts.Right_Foot_Off, 2)-1
        Right_Mid_Swing(i,1) = round((S.evts.Right_Foot_Off(1,i) + S.evts.Right_Foot_Strike(1,i+1))/2);
        Right_Mid_Stance(i,1) = round((S.evts.Right_Foot_Off(1,i) + S.evts.Right_Foot_Strike(1,i))/2);
    end
    clear i
end

% Left Foot
% Find toe height at mid swing and mid stance
if S.evts.Left_Foot_Off(1,1) < S.evts.Left_Foot_Strike(1,1)
    for i = 1: size(S.evts.Left_Foot_Off, 2)-1
        Left_Mid_Swing(i,1) = round((S.evts.Left_Foot_Off(1,i) + S.evts.Left_Foot_Strike(1,i))/2);
        Left_Mid_Stance(i,1) = round((S.evts.Left_Foot_Off(1,i+1) + S.evts.Left_Foot_Strike(1,i))/2);
    end
    clear i
    
else
    for i = 1: size(S.evts.Left_Foot_Off, 2)-1
        Left_Mid_Swing(i,1) = round((S.evts.Left_Foot_Off(1,i) + S.evts.Left_Foot_Strike(1,i+1))/2);
        Left_Mid_Stance(i,1) = round((S.evts.Left_Foot_Off(1,i) + S.evts.Left_Foot_Strike(1,i))/2);
    end
    clear i
end

% Calculate range
for i = 1:size(Right_Mid_Swing, 1)
    RToeHeight(i,1) = S.points.RTOE(Right_Mid_Swing(i,1), 3) - S.points.RTOE(Right_Mid_Stance(i,1), 3);
end
clear i

for i = 1:size(Left_Mid_Swing, 1)
    LToeHeight(i,1) = S.points.LTOE(Left_Mid_Swing(i,1), 3) - S.points.LTOE(Left_Mid_Stance(i,1), 3);
end
clear i Left_Mid_Swing Left_Mid_Stance Right_Mid_Swing Right_Mid_Stance

S.ToeHeight.RToeHeight = RToeHeight;
S.ToeHeight.LToeHeight = LToeHeight;

end