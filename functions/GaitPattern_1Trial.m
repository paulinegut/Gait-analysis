%% ########################################################################
% specTra poject
% Plot angles of all gait cycles
%
% Version 18. March 2021
% Author: Pauline Rose Gut
% #########################################################################

function GaitPattern_1Trial(S1, Deficits, nhr, Pathname)

% ROM
% Right
for i = 1:length(S1.R)
    x1(:,i) = S1.R(i).angs.RHipAngles(:,1);
    meanRHipAngles(:,1) = mean(x1,2);
    x3(:,i) = S1.R(i).angs.RHipAngles(:,2);
    meanRHipFrntAngles(:,1) = mean(x3,2);
    x5(:,i) = S1.R(i).angs.RKneeAngles(:,1);
    meanRKneeAngles(:,1) = mean(x5,2);
    x7(:,i) = S1.R(i).angs.RAnkleAngles(:,1);
    meanRAnkleAngles(:,1) = mean(x7,2);
end

clear i;

% Left
for i = 1:length(S1.L)
    x2(:,i) = S1.L(i).angs.LHipAngles(:,1);
    meanLHipAngles(:,1) = mean(x2,2);
    x4(:,i) = S1.L(i).angs.LHipAngles(:,2);
    meanLHipFrntAngles(:,1) = mean(x4,2);
    x6(:,i) = S1.L(i).angs.LKneeAngles(:,1);
    meanLKneeAngles(:,1) = mean(x6,2);
    x8(:,i) = S1.L(i).angs.LAnkleAngles(:,1);
    meanLAnkleAngles(:,1) = mean(x8,2);
end
clear i;

% ROM plot if deficit
if Deficits(1,1) ~= 0
    for i = 1:size(nhr.Angles.Sagittal.RHip,2)
        ss(1,i) = std(nhr.Angles.Sagittal.RHip(:,i));
    end
    clear i;
    figure('Name', 'Right Hip Flexion/Extension');
    %nexttile
    ciplot(nhr.Angles.Sagittal.mRHip',nhr.Angles.Sagittal.mRHip'+2*ss',1:100,[0 0.69 0.31]);
    hold on;
    ciplot(nhr.Angles.Sagittal.mRHip',nhr.Angles.Sagittal.mRHip'-2*ss',1:100,[0 0.69 0.31]);
    hold on;
    plot(x1, 'k');
    xlabel('Gait Cycle (%)', 'FontSize', 14);
    ylabel('Range of motion (deg)', 'FontSize', 14);
    title('Right Hip Flexion/Extension', 'FontSize', 16);
    box on;
    hold off;
    clear ss;
    clc;
    saveas(gcf, [Pathname(1:end-11) 'Report\Right_Hip_FlexionExtension.tiff'])
end

if Deficits(2,1) ~= 0
    for i = 1:size(nhr.Angles.Sagittal.LHip,2)
        ss(1,i) = std(nhr.Angles.Sagittal.LHip(:,i));
    end
    clear i;
    figure('Name', 'Left Hip Flexion/Extension');
    ciplot(nhr.Angles.Sagittal.mLHip',nhr.Angles.Sagittal.mLHip'+2*ss',1:100,[0 0.69 0.31]);
    hold on;
    ciplot(nhr.Angles.Sagittal.mLHip',nhr.Angles.Sagittal.mLHip'-2*ss',1:100,[0 0.69 0.31]);
    hold on;
    plot(x2, 'k');
    xlabel('Gait Cycle (%)', 'FontSize', 14);
    ylabel('Range of motion (deg)', 'FontSize', 14);
    title('Left Hip Flexion/Extension', 'FontSize', 16);
    box on;
    hold off;
    clear ss;
    clc;
saveas(gcf, [Pathname(1:end-11) 'Report\Left_Hip_FlexionExtension.tiff'])
end
clear i;


if Deficits(3,1) ~= 0
    for i = 1:size(nhr.Angles.Frontal.RHip,2)
        ss(1,i) = std(nhr.Angles.Frontal.RHip(:,i));
    end
    clear i;
    figure
    ciplot(nhr.Angles.Frontal.mRHip',nhr.Angles.Frontal.mRHip'+2*ss',1:100,[0 0.69 0.31]);
    hold on;
    ciplot(nhr.Angles.Frontal.mRHip',nhr.Angles.Frontal.mRHip'-2*ss',1:100,[0 0.69 0.31]);
    hold on;
    plot(x3, 'k');
    xlabel('Gait Cycle (%)', 'FontSize', 14);
    ylabel('Range of motion (deg)', 'FontSize', 14);
    title('Right Hip Abduction/Adduction', 'FontSize', 16);
    box on;
    hold off;
    clear ss;
    clc;
    saveas(gcf, [Pathname(1:end-11) 'Report\Right_Hip_AbductionAdduction.tiff'])
end
clear i;

if Deficits(4,1) ~= 0
    for i = 1:size(nhr.Angles.Frontal.LHip,2)
        ss(1,i) = std(nhr.Angles.Frontal.LHip(:,i));
    end
    clear i;
    figure
    ciplot(nhr.Angles.Frontal.mLHip',nhr.Angles.Frontal.mLHip'+2*ss',1:100,[0 0.69 0.31]);
    hold on;
    ciplot(nhr.Angles.Frontal.mLHip',nhr.Angles.Frontal.mLHip'-2*ss',1:100,[0 0.69 0.31]);
    hold on;
    plot(x4, 'k');
    xlabel('Gait Cycle (%)', 'FontSize', 14);
    ylabel('Range of motion (deg)', 'FontSize', 14);
    title('Left Hip Abduction/Adduction', 'FontSize', 16);
    box on;
    hold off;
    clear ss;
    clc;
    saveas(gcf, [Pathname(1:end-11) 'Report\Left_Hip_AbductionAdduction.tiff'])
end
clear i;

if Deficits(5,1) ~= 0
    for i = 1:size(nhr.Angles.Sagittal.RKnee,2)
        ss(1,i) = std(nhr.Angles.Sagittal.RKnee(:,i));
    end
    clear i;
    figure('Name', 'Right Knee Flexion/Extension');
    ciplot(nhr.Angles.Sagittal.mRKnee',nhr.Angles.Sagittal.mRKnee'+2*ss',1:100,[0 0.69 0.31]);
    hold on;
    ciplot(nhr.Angles.Sagittal.mRKnee',nhr.Angles.Sagittal.mRKnee'-2*ss',1:100,[0 0.69 0.31]);
    hold on;
    plot(x5, 'k');
    xlabel('Gait Cycle (%)', 'FontSize', 14);
    ylabel('Range of motion (deg)', 'FontSize', 14);
    title('Right Knee Flexion/Extension', 'FontSize', 16);
    box on;
    hold off;
    clear ss;
    clc;
    saveas(gcf, [Pathname(1:end-11) 'Report\Right_Knee_FlexionExtension.tiff'])
end
clear i;

if Deficits(6,1) ~= 0
    for i = 1:size(nhr.Angles.Sagittal.LKnee,2)
        ss(1,i) = std(nhr.Angles.Sagittal.LKnee(:,i));
    end
    clear i;
    figure('Name', 'Left Knee Flexion/Extension');
    ciplot(nhr.Angles.Sagittal.mLKnee',nhr.Angles.Sagittal.mLKnee'+2*ss',1:100,[0 0.69 0.31]);
    hold on;
    ciplot(nhr.Angles.Sagittal.mLKnee',nhr.Angles.Sagittal.mLKnee'-2*ss',1:100,[0 0.69 0.31]);
    hold on;
    plot(x6, 'k');
    xlabel('Gait Cycle (%)', 'FontSize', 14);
    ylabel('Range of motion (deg)', 'FontSize', 14);
    title('Left Knee Flexion/Extension', 'FontSize', 16);
    box on;
    hold off;
    clear ss;
    clc;
    saveas(gcf, [Pathname(1:end-11) 'Report\Left_Knee_FlexionExtension.tiff'])
end
clear i;

if Deficits(7,1) ~= 0
    for i = 1:size(nhr.Angles.Sagittal.RAnkle,2)
        ss(1,i) = std(nhr.Angles.Sagittal.RAnkle(:,i));
    end
    clear i;
    figure('Name', 'Right Ankle Flexion/Extension');
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
    saveas(gcf, [Pathname(1:end-11) 'Report\Right_Ankle_FlexionExtension.tiff'])
end
clear i;

if Deficits(8,1) ~= 0
    for i = 1:size(nhr.Angles.Sagittal.LAnkle,2)
        ss(1,i) = std(nhr.Angles.Sagittal.LAnkle(:,i));
    end
    clear i;
    figure('Name', 'Left Ankle Flexion/Extension');
    ciplot(nhr.Angles.Sagittal.mLAnkle',nhr.Angles.Sagittal.mLAnkle'+2*ss',1:100,[0 0.69 0.31]);
    hold on;
    ciplot(nhr.Angles.Sagittal.mLAnkle',nhr.Angles.Sagittal.mLAnkle'-2*ss',1:100,[0 0.69 0.31]);
    hold on;
    plot(x8, 'k');
    xlabel('Gait Cycle (%)', 'FontSize', 14);
    ylabel('Range of motion (deg)', 'FontSize', 14);
    title('Left Ankle Flexion/Extension', 'FontSize', 16);
    box on;
    hold off;
    clear ss;
    clc;
    saveas(gcf, [Pathname(1:end-11) 'Report\Left_Ankle_FlexionExtension.tiff'])
end
clear i;

if Deficits(9,1) ~= 0
    for i = 1:size(nhr.Angles.Sagittal.Spine,2)
        ss(1,i) = std(nhr.Angles.Sagittal.Spine(:,i));
    end
    clear i;
    figure('Name', 'Spine Lateral Flexion');
    ciplot(nhr.Angles.Sagittal.mSpine',nhr.Angles.Sagittal.mSpine'+2*ss',1:100,[0 0.69 0.31]);
    hold on;
    ciplot(nhr.Angles.Sagittal.mSpine',nhr.Angles.Sagittal.mSpine'-2*ss',1:100,[0 0.69 0.31]);
    hold on;
    plot([S1.Spine.LateralFlexion.Angles, S2.Spine.LateralFlexion.Angles], 'k');
    xlabel('Gait Cycle (%)', 'FontSize', 14);
    ylabel('Range of motion (deg)', 'FontSize', 14);
    title('Spine Lateral Flexion', 'FontSize', 16);
    box on;
    hold off;
    clear ss;
    clc;
    saveas(gcf, [Pathname(1:end-11) 'Report\Spine_LateralFlexion.tiff'])
end
clear i;

if Deficits(10,1) ~= 0
    for i = 1:size(nhr.Angles.Frontal.Spine,2)
        ss(1,i) = std(nhr.Angles.Frontal.Spine(:,i));
    end
    clear i;
    figure('Name', 'Spine Flexion/Extension');
    ciplot(nhr.Angles.Frontal.mSpine',nhr.Angles.Frontal.mSpine'+2*ss',1:100,[0 0.69 0.31]);
    hold on;
    ciplot(nhr.Angles.Frontal.mSpine',nhr.Angles.Frontal.mSpine'-2*ss',1:100,[0 0.69 0.31]);
    hold on;
    plot([S1.Spine.FlexionExtension.Angles, S2.Spine.FlexionExtension.Angles], 'k');
    xlabel('Gait Cycle (%)', 'FontSize', 14);
    ylabel('Range of motion (deg)', 'FontSize', 14);
    title('Spine Flexion/Extension', 'FontSize', 16);
    box on;
    hold off;
    clear ss;
    clc;
    saveas(gcf, [Pathname(1:end-11) 'Report\Spine_FlexionExtension.tiff'])
end
clear i;

% Cyclograms if deficit
if Deficits(13,1) ~= 0 || Deficits(17,1) ~= 0
    figure('Name', 'Right Hip Knee cyclogram');
    % plot(nhr.Angles.Sagittal.RHip', nhr.Angles.Sagittal.RKnee')
    plot(nhr.Angles.Sagittal.mRHip', nhr.Angles.Sagittal.mRKnee', 'Color', [0 0.69 0.31], 'LineWidth', 1.5)
    hold on;
    plot(mean(x1,2), mean(x5,2), 'k', 'LineWidth', 1.5)
    hold on;
    plot(x1, x5, 'Color', [0 0 0 0.2]);
    hold on;
    xlabel('Hip (deg)', 'FontSize', 14)
    ylabel('Knee (deg)', 'FontSize', 14)
    title('Right Hip Knee Cyclograms', 'FontSize', 16)
    legend('Healthy', 'Patient', 'FontSize', 12, 'Location', 'Best')
    hold off;
    saveas(gcf, [Pathname(1:end-11) 'Report\Cyclogram_RightHipKnee.tiff'])
end

if Deficits(14,1) ~= 0 || Deficits(18,1) ~= 0
    figure('Name', 'Left Hip Knee cyclogram');
    plot(nhr.Angles.Sagittal.mLHip', nhr.Angles.Sagittal.mLKnee', 'Color', [0 0.69 0.31], 'LineWidth', 1.5)
    hold on;
    plot(mean(x2,2), mean(x6,2), 'k', 'LineWidth', 1.5)
    hold on;
    plot(x2, x6, 'Color', [0 0 0 0.2]);
    hold on;
    xlabel('Hip (deg)', 'FontSize', 14)
    ylabel('Knee (deg)', 'FontSize', 14)
    title('Left Hip Knee Cyclograms', 'FontSize', 16)
    legend('Healthy', 'Patient', 'FontSize', 12, 'Location', 'Best')
    hold off;
    saveas(gcf, [Pathname(1:end-11) 'Report\Cyclogram_LeftHipKnee.tiff'])
end

if Deficits(15,1) ~= 0 || Deficits(19,1) ~= 0
    figure('Name', 'Right Knee Ankle cyclogram');
    plot(nhr.Angles.Sagittal.mRKnee', nhr.Angles.Sagittal.mRAnkle', 'Color', [0 0.69 0.31], 'LineWidth', 1.5)
    hold on;
    plot(mean(x5,2), mean(x7,2), 'k', 'LineWidth', 1.5)
    hold on;
    plot(x5, x7, 'Color', [0 0 0 0.2]);
    hold on;
    xlabel('Knee (deg)', 'FontSize', 14)
    ylabel('Ankle (deg)', 'FontSize', 14)
    title('Right Knee Ankle Cyclograms', 'FontSize', 16)
    legend('Healthy', 'Patient', 'FontSize', 12, 'Location', 'Best')
    hold off;
    saveas(gcf, [Pathname(1:end-11) 'Report\Cyclogram_RightKneeAnkle.tiff'])
end

if Deficits(16,1) ~= 0 || Deficits(20,1) ~= 0
    figure('Name', 'Left Knee Ankle cyclogram');
    plot(nhr.Angles.Sagittal.mLKnee', nhr.Angles.Sagittal.mLAnkle', 'Color', [0 0.69 0.31], 'LineWidth', 1.5)
    hold on;
    plot(mean(x6,2), mean(x8,2), 'k', 'LineWidth', 1.5)
    hold on;
    plot(x6, x8, 'Color', [0 0 0 0.2]);
    hold on;
    xlabel('Knee (deg)', 'FontSize', 14)
    ylabel('Ankle (deg)', 'FontSize', 14)
    title('Left Knee Ankle Cyclograms', 'FontSize', 16)
    legend('Healthy', 'Patient', 'FontSize', 12, 'Location', 'Best')
    hold off;
    saveas(gcf, [Pathname(1:end-11) 'Report\Cyclogram_LeftKneeAnkle.tiff'])
end

clear x1 x2 x3 x4 x5 x6 x7 x8 x9 x10;
end



