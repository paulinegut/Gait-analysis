function [S] = extractROM(S, angs, plane)

planeNames = {'Sag', 'Frnt', 'Trans'};

if nargin == 1
    plane = [1, 2, 3];  %1: sagittal, 2: frontal, 3: transversal
    angs = fieldnames(S.angs);
    % Remove side angle label (works only for symmetric angles)
    angs = unique(cellfun(@(x) x(2:end),angs,'UniformOutput',false));
end
if nargin == 2
    plane = [1, 2, 3];  %1: sagittal, 2: frontal, 3: transversal
end

for iPlane = plane
    for iAng = 1:length(angs)
        for iStep = 1 : length(S.L)
            S.L(iStep).(['ROM' angs{iAng} 'Range' planeNames{iPlane} ]) = range(S.L(iStep).angs.(['L' angs{iAng}])(:,iPlane));
            S.L(iStep).(['ROM' angs{iAng} 'Min' planeNames{iPlane} ]) = min(S.L(iStep).angs.(['L' angs{iAng}])(:,iPlane));
            S.L(iStep).(['ROM' angs{iAng} 'Max' planeNames{iPlane} ]) = max(S.L(iStep).angs.(['L' angs{iAng}])(:,iPlane));
        end
        for iStep = 1 : length(S.R)
            S.R(iStep).(['ROM' angs{iAng} 'Range' planeNames{iPlane} ]) = range(S.R(iStep).angs.(['R' angs{iAng}])(:,iPlane));
            S.R(iStep).(['ROM' angs{iAng} 'Min' planeNames{iPlane} ]) = min(S.R(iStep).angs.(['R' angs{iAng}])(:,iPlane));
            S.R(iStep).(['ROM' angs{iAng} 'Max' planeNames{iPlane} ]) = max(S.R(iStep).angs.(['R' angs{iAng}])(:,iPlane));
        end
    end
end
end
