function [S] = extractROM_CGM(S, angs, plane)

planeNames = {'Sag', 'Frnt', 'Trans'};
ev = {'Trajectory', 'Velocity'};

if nargin == 1
    plane = [1, 2, 3];  %1: sagittal, 2: frontal, 3: transversal
    angs = fieldnames(S.angs);
    % Remove side angle label (works only for symmetric angles)
    angs = unique(cellfun(@(x) x(2:end),angs,'UniformOutput',false));
end
if nargin == 2
    plane = [1, 2, 3];  %1: sagittal, 2: frontal, 3: transversal
end

for e = 1:length(ev)
    for iPlane = plane
        for iAng = 1:length(angs)
            for iStep = 1 : length(S.L.(ev{e}))
                S.L.(ev{e})(iStep).(['ROM' angs{iAng} '_Range_' planeNames{iPlane} ]) = range(S.L.(ev{e})(iStep).angs.(['L' angs{iAng}])(:,iPlane));
                S.L.(ev{e})(iStep).(['ROM' angs{iAng} '_Min_' planeNames{iPlane} ]) = min(S.L.(ev{e})(iStep).angs.(['L' angs{iAng}])(:,iPlane));
                S.L.(ev{e})(iStep).(['ROM' angs{iAng} '_Max_' planeNames{iPlane} ]) = max(S.L.(ev{e})(iStep).angs.(['L' angs{iAng}])(:,iPlane));
            end
            for iStep = 1 : length(S.R.(ev{e}))
                S.R.(ev{e})(iStep).(['ROM' angs{iAng} '_Range_' planeNames{iPlane} ]) = range(S.R.(ev{e})(iStep).angs.(['R' angs{iAng}])(:,iPlane));
                S.R.(ev{e})(iStep).(['ROM' angs{iAng} '_Min_' planeNames{iPlane} ]) = min(S.R.(ev{e})(iStep).angs.(['R' angs{iAng}])(:,iPlane));
                S.R.(ev{e})(iStep).(['ROM' angs{iAng} '_Max_' planeNames{iPlane} ]) = max(S.R.(ev{e})(iStep).angs.(['R' angs{iAng}])(:,iPlane));
            end
        end
    end
end
end
