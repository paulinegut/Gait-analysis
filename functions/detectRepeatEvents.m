function S = detectRepeatEvents(S)
%DetectRepeatEvents Detects repeated events and corrects them
% Repeating event types (foot strike / foot off) are detected and first
% occurance is deleted

fields = fieldnames (S.evts);
checkVec = [];
% Extract events into an event matrix
for i = 1: length(fields)
    tmpVec = S.evts.(fields{i})' ;
    tmpVec(:,2) = i;
    checkVec = vertcat(checkVec, tmpVec);
    clear tmpVec
end

% Sort the event matrix according to time
[p,sortInd] = sort(checkVec(:,1));
p(:,2) = checkVec(sortInd,2);

% Find any repeating event ID
falseSteps = find(diff(p(:,2)) == 0 ); %checks if an event is repeated

if isempty(falseSteps)
    
    % Correct the repeating events (default is removing the earlier event!!!)
    p(falseSteps, :) = [];
    
    for i = 1 : length(fields)
        S.evts.(fields{i}) = [];
        S.evts.(fields{i}) = p(p(:,2) == i)';
    end
    
    % Log the repeating events in the error log
    S.errors(end+1) = {[num2str(length(falseSteps)) ' repeating events detected and corrected (final HS is retained)']}; % count the false steps
end
end