%% ########################################################################
% specTra poject
% Training Schedule
%
% Version 14. January 2021
% Author: Pauline Rose Gut
% #########################################################################

function [Schedule] = Schedule(TrainingTime, Parameters, Deficits)

TT = TrainingTime(~all(TrainingTime == 0, 2),:);
index = find(TrainingTime(:,1) ~= 0);

for i = 1:size(index,1)
    Label{i,1} = Parameters{index(i,1),1};
end
clear i

% Colors
c1 = [181 225 174]/256;
c2 = [253 220 132]/256;
c3 = [200 178 180]/256;
c4 = [255 255 176]/256;
c5 = [204 236 239]/256;
c6 = [253 222 238]/256;

Schedule = figure('Name', 'Schedule', 'Position', [400 -30 800 1000]);
% Z-scores
subplot(2,1,1)
for i = 1:size(index,1)
    if index(i,1) <= 10
        bar(i, Deficits(index(i,1),1), 0.3, 'FaceColor',c1);
        hold on;
    elseif index(i,1) == 11
        bar(i, Deficits(index(i,1),1), 0.3, 'FaceColor',c2); 
        hold on;
    elseif index(i,1) == 12
        bar(i, Deficits(index(i,1),1), 0.3, 'FaceColor',c3);
        hold on;
    elseif 12 < index(i,1) <= 16
        bar(i, Deficits(index(i,1),1), 0.3, 'FaceColor',c4);
        hold on;
    elseif 16 < index(i,1) <=20
        bar(i, Deficits(index(i,1),1), 0.3, 'FaceColor',c5);
        hold on;
    elseif 20 < index(i,1)
        bar(i, Deficits(index(i,1),1), 0.3, 'FaceColor',c6);
        hold on;
    end
    ax = gca;
    set(gca, 'XTick', 1:size(index,1), 'XTickLabel', Label,'FontSize', 12);
end
clear i
ax.XTickLabelRotation = 45;
ylabel('z-score', 'FontSize', 12);
box on;
grid on;
title('Deficits', 'FontSize', 14);


subplot(2,1,2)
for i = 1:size(index,1)
    if index(i,1) <= 10
        bar(i, TT(i,1), 0.3, 'FaceColor',c1);
        hold on;
    elseif index(i,1) == 11
        bar(i, TT(i,1), 0.3, 'FaceColor',c2); 
        hold on;
    elseif index(i,1) == 12
        bar(i, TT(i,1), 0.3, 'FaceColor',c3);
        hold on;
    elseif 12 < index(i,1) <= 16
        bar(i, TT(i,1), 0.3, 'FaceColor',c4);
        hold on;
    elseif 16 < index(i,1)
        bar(i, TT(i,1), 0.3, 'FaceColor',c5);
        hold on;
    end
    ax = gca;
    set(gca, 'XTick', 1:size(index,1), 'XTickLabel', Label,'FontSize', 12);
end
clear i
ax.XTickLabelRotation = 45;
ylabel('Training time [min]', 'FontSize', 12);
box on;
grid on;
title('Training schedule for each week', 'FontSize', 14);
hold off;

clear TT Label index

end
