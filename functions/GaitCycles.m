%% ########################################################################
% Clinical Gait Analysis
% Plot angles of all gait cycles
%
% Version 5. March 2021
% Author: Pauline Rose Gut
% #########################################################################

function GaitCycles(S, nhr)
% ROM
% Right
for i = 1:length(S.R)
    x1(:,i) = S.R(i).angs.RHipAngles(:,1);
    meanRHipAngles(:,1) = mean(x1,2);
    x5(:,i) = S.R(i).angs.RKneeAngles(:,1);
    meanRKneeAngles(:,1) = mean(x5,2);
    x7(:,i) = S.R(i).angs.RAnkleAngles(:,1);
    meanRAnkleAngles(:,1) = mean(x7,2);
end
clear i;
% Left
for i = 1:length(S.L)
    x2(:,i) = S.L(i).angs.LHipAngles(:,1);
    meanLHipAngles(:,1) = mean(x2,2);
    x6(:,i) = S.L(i).angs.LKneeAngles(:,1);
    meanLKneeAngles(:,1) = mean(x6,2);
    x8(:,i) = S.L(i).angs.LAnkleAngles(:,1);
    meanLAnkleAngles(:,1) = mean(x8,2);
end
clear i;

s = get(0, 'ScreenSize');
figure('Position', [0 0 s(3) s(4)], 'Name', 'Gait Cycles'); clear s

% Right Hip
for i = 1:size(nhr.Angles.Sagittal.RHip,2)
    ss(1,i) = std(nhr.Angles.Sagittal.RHip(:,i));
end
clear i;
subplot(3,2,1)
ciplot(nhr.Angles.Sagittal.mRHip',nhr.Angles.Sagittal.mRHip'+2*ss',1:100,[0 0.69 0.31]);
hold on;
ciplot(nhr.Angles.Sagittal.mRHip',nhr.Angles.Sagittal.mRHip'-2*ss',1:100,[0 0.69 0.31]);
hold on;
plot(x1, 'k');
% xlabel('Gait Cycle (%)', 'FontSize', 14);
ylabel('Range of motion (deg)', 'FontSize', 14);
title('Right Hip Flexion/Extension', 'FontSize', 16);
box on;
clear ss;
clc;

% Left Hip
for i = 1:size(nhr.Angles.Sagittal.LHip,2)
    ss(1,i) = std(nhr.Angles.Sagittal.LHip(:,i));
end
clear i;
subplot(3,2,2)
ciplot(nhr.Angles.Sagittal.mLHip',nhr.Angles.Sagittal.mLHip'+2*ss',1:100,[0 0.69 0.31]);
hold on;
ciplot(nhr.Angles.Sagittal.mLHip',nhr.Angles.Sagittal.mLHip'-2*ss',1:100,[0 0.69 0.31]);
hold on;
plot(x2, 'k');
% xlabel('Gait Cycle (%)', 'FontSize', 14);
% ylabel('Range of motion (deg)', 'FontSize', 14);
title('Left Hip Flexion/Extension', 'FontSize', 16);
box on;
clear ss;
clc;

% Right Knee
for i = 1:size(nhr.Angles.Sagittal.RKnee,2)
    ss(1,i) = std(nhr.Angles.Sagittal.RKnee(:,i));
end
clear i;
subplot(3,2,3)
ciplot(nhr.Angles.Sagittal.mRKnee',nhr.Angles.Sagittal.mRKnee'+2*ss',1:100,[0 0.69 0.31]);
hold on;
ciplot(nhr.Angles.Sagittal.mRKnee',nhr.Angles.Sagittal.mRKnee'-2*ss',1:100,[0 0.69 0.31]);
hold on;
plot(x5, 'k');
% xlabel('Gait Cycle (%)', 'FontSize', 14);
ylabel('Range of motion (deg)', 'FontSize', 14);
title('Right Knee Flexion/Extension', 'FontSize', 16);
box on;
hold off;
clear ss;
clc;

% Left Knee
for i = 1:size(nhr.Angles.Sagittal.LKnee,2)
    ss(1,i) = std(nhr.Angles.Sagittal.LKnee(:,i));
end
clear i;
subplot(3,2,4)
ciplot(nhr.Angles.Sagittal.mLKnee',nhr.Angles.Sagittal.mLKnee'+2*ss',1:100,[0 0.69 0.31]);
hold on;
ciplot(nhr.Angles.Sagittal.mLKnee',nhr.Angles.Sagittal.mLKnee'-2*ss',1:100,[0 0.69 0.31]);
hold on;
plot(x6, 'k');
% xlabel('Gait Cycle (%)', 'FontSize', 14);
% ylabel('Range of motion (deg)', 'FontSize', 14);
title('Left Knee Flexion/Extension', 'FontSize', 16);
box on;
hold off;
clear ss;
clc;

% Right Ankle
for i = 1:size(nhr.Angles.Sagittal.RAnkle,2)
    ss(1,i) = std(nhr.Angles.Sagittal.RAnkle(:,i));
end
clear i;
subplot(3,2,5)
ciplot(nhr.Angles.Sagittal.mRAnkle',nhr.Angles.Sagittal.mRAnkle'+2*ss',1:100,[0 0.69 0.31]);
hold on;
ciplot(nhr.Angles.Sagittal.mRAnkle',nhr.Angles.Sagittal.mRAnkle'-2*ss',1:100,[0 0.69 0.31]);
hold on;
plot(x7, 'k');
xlabel('Gait Cycle (%)', 'FontSize', 14);
ylabel('Range of motion (deg)', 'FontSize', 14);
title('Right Ankle Flexion/Extension', 'FontSize', 16);
box on;
hold off;
clear ss;
clc;
    
% Left Ankle
for i = 1:size(nhr.Angles.Sagittal.LAnkle,2)
    ss(1,i) = std(nhr.Angles.Sagittal.LAnkle(:,i));
end
clear i;
subplot(3,2,6)
ciplot(nhr.Angles.Sagittal.mLAnkle',nhr.Angles.Sagittal.mLAnkle'+2*ss',1:100,[0 0.69 0.31]);
hold on;
ciplot(nhr.Angles.Sagittal.mLAnkle',nhr.Angles.Sagittal.mLAnkle'-2*ss',1:100,[0 0.69 0.31]);
hold on;
plot(x8, 'k');
xlabel('Gait Cycle (%)', 'FontSize', 14);
% ylabel('Range of motion (deg)', 'FontSize', 14);
title('Left Ankle Flexion/Extension', 'FontSize', 16);
box on;
hold off;
clear ss;
clc;

clear x1 x2 x3 x4 x5 x6 x7 x8 x9 x10;
end



