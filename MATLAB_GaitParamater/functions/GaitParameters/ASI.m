%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% Asymmetry calculation
%
% Version 10. December 2020
% Author: Pauline Rose Gut
% #########################################################################

function [S] = ASI(S)

if length(S.R) > length(S.L)
    % Hip ASI
    a = [S.L.ROMHipAnglesRangeSag].' - [S.R(1:end-1).ROMHipAnglesRangeSag].';
    b = max([S.L.ROMHipAnglesRangeSag].', [S.R(1:end-1).ROMHipAnglesRangeSag].');
    c = a./b;
    S.ASI.HipASI(:,1) = abs(c*100);
    clear a b c

    % Knee ASI
    a = [S.L.ROMKneeAnglesRangeSag].' - [S.R(1:end-1).ROMKneeAnglesRangeSag].';
    b = max([S.L.ROMKneeAnglesRangeSag].', [S.R(1:end-1).ROMKneeAnglesRangeSag].');
    c = a./b;
    S.ASI.KneeASI(:,1) = abs(c*100);
    clear a b c

    % Ankle ASI
    a = [S.L.ROMAnkleAnglesRangeSag].' - [S.R(1:end-1).ROMAnkleAnglesRangeSag].';
    b = max([S.L.ROMAnkleAnglesRangeSag].', [S.R(1:end-1).ROMAnkleAnglesRangeSag].');
    c = a./b;
    S.ASI.AnkleASI(:,1) = abs(c*100);
    clear a b c
    
elseif length(S.R) < length(S.L)
    % Hip ASI
    a = [S.L(1:end-1).ROMHipAnglesRangeSag].' - [S.R.ROMHipAnglesRangeSag].';
    b = max([S.L(1:end-1).ROMHipAnglesRangeSag].', [S.R.ROMHipAnglesRangeSag].');
    c = a./b;
    S.ASI.HipASI(:,1) = abs(c*100);
    clear a b c

    % Knee ASI
    a = [S.L(1:end-1).ROMKneeAnglesRangeSag].' - [S.R.ROMKneeAnglesRangeSag].';
    b = max([S.L(1:end-1).ROMKneeAnglesRangeSag].', [S.R.ROMKneeAnglesRangeSag].');
    c = a./b;
    S.ASI.KneeASI(:,1) = abs(c*100);
    clear a b c

    % Ankle ASI
    a = [S.L(1:end-1).ROMAnkleAnglesRangeSag].' - [S.R.ROMAnkleAnglesRangeSag].';
    b = max([S.L(1:end-1).ROMAnkleAnglesRangeSag].', [S.R.ROMAnkleAnglesRangeSag].');
    c = a./b;
    S.ASI.AnkleASI(:,1) = abs(c*100);
    clear a b c
    
else 
    % Hip ASI
    a = [S.L.ROMHipAnglesRangeSag].' - [S.R.ROMHipAnglesRangeSag].';
    b = max([S.L.ROMHipAnglesRangeSag].', [S.R.ROMHipAnglesRangeSag].');
    c = a./b;
    S.ASI.HipASI(:,1) = abs(c*100);
    clear a b c

    % Knee ASI
    a = [S.L.ROMKneeAnglesRangeSag].' - [S.R.ROMKneeAnglesRangeSag].';
    b = max([S.L.ROMKneeAnglesRangeSag].', [S.R.ROMKneeAnglesRangeSag].');
    c = a./b;
    S.ASI.KneeASI(:,1) = abs(c*100);
    clear a b c

    % Ankle ASI
    a = [S.L.ROMAnkleAnglesRangeSag].' - [S.R.ROMAnkleAnglesRangeSag].';
    b = max([S.L.ROMAnkleAnglesRangeSag].', [S.R.ROMAnkleAnglesRangeSag].');
    c = a./b;
    S.ASI.AnkleASI(:,1) = abs(c*100);
    clear a b c
end
end