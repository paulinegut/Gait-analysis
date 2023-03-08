function S = detectFalseSteps(S)
%DetectFalseSteps Detects false steps and erases them
% Single gait cycles are checked for correct sequence of step events (left
% and right foot strikes and foot offs) and deleted if any anomalies are
% present

fields = {'Left_Foot_Strike' 'Right_Foot_Strike', 'Left_Foot_Off', 'Right_Foot_Off'};
checkVec = [];
allVec = [];
% Extract events into an event matrix
for i = 1:2
    tmpVec = S.evts.(fields{i})' ;
    tmpVec(:,2) = i;
    checkVec = vertcat(checkVec, tmpVec);
    
end

for i = 1:4
    tmpVec = S.evts.(fields{i})' ;
    tmpVec(:,2) = i;
    allVec = vertcat(allVec, tmpVec);
    clear tmpVec
end

%sort the checkVec according to time
[p,sortInd] = sort(checkVec(:,1));
p(:,2) = checkVec(sortInd,2);

%sort the allVec according to time
clear sortInd
[sortedVec,sortInd] = sort(allVec(:,1));
sortedVec(:,2) = allVec(sortInd,2);


%find any repeating heelstrikes (steps without a contralateral step)
falseSteps = find(diff(p(:,2)) == 0 ); %
S.errors(end+1) = {[num2str(length(falseSteps)) ' erronous steps detected']}; % count the false steps

if length(falseSteps) > 0
    
    % correct the doubleSteps
    for pp = 1: length(falseSteps)
        doubleStep(pp) = find(sortedVec(:,1) == p(falseSteps(pp),1));
    end
    sortedVec ([doubleStep doubleStep+1], :) = [];
    
    
    for i = 1 : length(fields)
        S.evts.(fields{i}) = [];
        S.evts.(fields{i}) = sortedVec(sortedVec(:,2) == i)';
    end
end

S.stats.duration = [sortedVec(1,1)/S.stats.pointFq sortedVec(end,1)/S.stats.pointFq];
end
