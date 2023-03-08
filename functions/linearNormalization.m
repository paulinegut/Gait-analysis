%% File: linearNormalization
% Description: Function which linearly normalizes the provided signal to 
%              the fixed number of data points specified.
%
% Usage: Executed from segmentSteps function
%
% Input: inSig - vector of data points which should be normalized
%        nPoints - number of points for normalization
%
% Output: normSig - vector of linearly normalized inSig
%
% Other files required: -
% Other m-files required: -
%
% Date        Author      Revision
% YYYYMMDD    Name        Description

%% ------------------- BEGIN CODE -------------------

function normSig = linearNormalization(inSig, nPoints)

% Create linearly spaced vector from 1 to length(inSig) with nPoints
interpVec = linspace(1,length(inSig),nPoints);
% Linearly interpolate inSig at interpVec positions
normSig = interp1(1:length(inSig),inSig,interpVec);

end

%% ------------------- END OF CODE -------------------
