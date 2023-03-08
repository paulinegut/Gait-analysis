%% ########################################################################
% Gait Analysis
% Extraction of gait parameters with the CGM Model
% Asymmetry calculation
%
% Version 19. March 2021
% Author: Pauline Rose Gut
% #########################################################################

function [S] = ASI_CGM(S)

if length(S.R) > length(S.L)
    % Hip ASI
    a = [S.L.ROMHipAngles_cgm24_Range_Sag].' - [S.R(1:end-1).ROMHipAngles_cgm24_Range_Sag].';
    b = max([S.L.ROMHipAngles_cgm24_Range_Sag].', [S.R(1:end-1).ROMHipAngles_cgm24_Range_Sag].');
    c = a./b;
    S.ASI.HipASI(:,1) = abs(c*100);
    clear a b c

    % Knee ASI
    a = [S.L.ROMKneeAngles_cgm24_Range_Sag].' - [S.R(1:end-1).ROMKneeAngles_cgm24_Range_Sag].';
    b = max([S.L.ROMKneeAngles_cgm24_Range_Sag].', [S.R(1:end-1).ROMKneeAngles_cgm24_Range_Sag].');
    c = a./b;
    S.ASI.KneeASI(:,1) = abs(c*100);
    clear a b c

    % Ankle ASI
    a = [S.L.ROMAnkleAngles_cgm24_Range_Sag].' - [S.R(1:end-1).ROMAnkleAngles_cgm24_Range_Sag].';
    b = max([S.L.ROMAnkleAngles_cgm24_Range_Sag].', [S.R(1:end-1).ROMAnkleAngles_cgm24_Range_Sag].');
    c = a./b;
    S.ASI.AnkleASI(:,1) = abs(c*100);
    clear a b c
    
elseif length(S.R) < length(S.L)
    % Hip ASI
    a = [S.L(1:end-1).ROMHipAngles_cgm24_Range_Sag].' - [S.R.ROMHipAngles_cgm24_Range_Sag].';
    b = max([S.L(1:end-1).ROMHipAngles_cgm24_Range_Sag].', [S.R.ROMHipAngles_cgm24_Range_Sag].');
    c = a./b;
    S.ASI.HipASI(:,1) = abs(c*100);
    clear a b c

    % Knee ASI
    a = [S.L(1:end-1).ROMKneeAngles_cgm24_Range_Sag].' - [S.R.ROMKneeAngles_cgm24_Range_Sag].';
    b = max([S.L(1:end-1).ROMKneeAngles_cgm24_Range_Sag].', [S.R.ROMKneeAngles_cgm24_Range_Sag].');
    c = a./b;
    S.ASI.KneeASI(:,1) = abs(c*100);
    clear a b c

    % Ankle ASI
    a = [S.L(1:end-1).ROMAnkleAngles_cgm24_Range_Sag].' - [S.R.ROMAnkleAngles_cgm24_Range_Sag].';
    b = max([S.L(1:end-1).ROMAnkleAngles_cgm24_Range_Sag].', [S.R.ROMAnkleAngles_cgm24_Range_Sag].');
    c = a./b;
    S.ASI.AnkleASI(:,1) = abs(c*100);
    clear a b c
    
else 
    % Hip ASI
    a = [S.L.ROMHipAngles_cgm24_Range_Sag].' - [S.R.ROMHipAngles_cgm24_Range_Sag].';
    b = max([S.L.ROMHipAngles_cgm24_Range_Sag].', [S.R.ROMHipAngles_cgm24_Range_Sag].');
    c = a./b;
    S.ASI.HipASI(:,1) = abs(c*100);
    clear a b c

    % Knee ASI
    a = [S.L.ROMKneeAngles_cgm24_Range_Sag].' - [S.R.ROMKneeAngles_cgm24_Range_Sag].';
    b = max([S.L.ROMKneeAngles_cgm24_Range_Sag].', [S.R.ROMKneeAngles_cgm24_Range_Sag].');
    c = a./b;
    S.ASI.KneeASI(:,1) = abs(c*100);
    clear a b c

    % Ankle ASI
    a = [S.L.ROMAnkleAngles_cgm24_Range_Sag].' - [S.R.ROMAnkleAngles_cgm24_Range_Sag].';
    b = max([S.L.ROMAnkleAngles_cgm24_Range_Sag].', [S.R.ROMAnkleAngles_cgm24_Range_Sag].');
    c = a./b;
    S.ASI.AnkleASI(:,1) = abs(c*100);
    clear a b c
end
end