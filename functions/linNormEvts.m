%% File: linNormEvts
% Description: Change events into interpolated frames of the normalized step
%
% Usage: Executed from segmentSteps function
%
% Input: inEvt - Single gait cylce events in frames
%        nFrames - Total gait cycle duration in frames
%        segPoints - Number of data points used for gait cycle normalization
%
% Output: normEvts - Normalized event values
%
% Other files required: -
% Other m-files required: linearNormalization.m, makePercEvts.m
%
% Date        Author      Revision
% YYYYMMDD    Name        Description

%% ------------------- BEGIN CODE -------------------

function normEvts = linNormEvts(evts, nFrames, segPoints)

% Shift event frames to start with ipsilateral foot strike (frame 1)
evts = evts - (evts(1) - 1);
% Normalize event frame to amount of segPoints
normEvts = round(interp1([1 nFrames],[1 segPoints],evts));

end

%% ------------------- END OF CODE -------------------
