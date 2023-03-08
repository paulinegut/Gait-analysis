%% ########################################################################
% specTra poject
% Training Time in minutes
%
% Version 18.March 2021
% Author: Pauline Rose Gut
% #########################################################################

function [Deficits, Percentage, TrainingTime] = TrainingTime(Deficits)

TotalDeficit = sum(abs(Deficits), 'all');

for i = 1:size(Deficits, 1)
    Percentage(i,1) = abs(Deficits(i,1))*100/TotalDeficit;
    TrainingTime(i,1) = round(abs(Deficits(i,1))*180/TotalDeficit); % [min]
end
clear i;
% sum(TrainingTime(:,1))

Deficits(:,2) = Deficits(:,1);

for i = 1:size(TrainingTime)
    if TrainingTime(i,1) < 10
        Deficits(i,2) = 0;
    end
end 
clear i;

TotalDeficit(1,2) = sum(abs(Deficits(:,2)), 'all');

for i = 1:size(Deficits(:,2), 1)
    Percentage(i,2) = abs(Deficits(i,2))*100/TotalDeficit(1,2);
    TrainingTime(i,2) = round(abs(Deficits(i,2))*180/TotalDeficit(1,2)); % [min]
end
clear i;

end