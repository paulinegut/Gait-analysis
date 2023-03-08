% Extracts spatial gait parameters and times of gait cycle phases from
% marker and event data
function [S] =  extractSpatioTemp(S)

%for every left step
for iStep = 1 : length(S.L)
    % Gait cycle:
    % Numbers behind gait events stand for storage indices (S.L.events)
    % Left Foot Strike (1) - Right Foot Off (4) - Right Foot Strike (3) - Left Foot Off (2)
    
    % Calculate globally used parameters
    % Number of total cycle data points for conversion from frames to seconds
    nPoints = length(S.L(iStep).points.LTOE) - 1;
    %Y-distance (anterior-posterior) of toe marker travelled during stance phase (used for treadmill speed)
    dSurface = S.L(iStep).points.LTOE(S.L(iStep).events(4),2) - S.L(iStep).points.LTOE(S.L(iStep).events(3),2); %[mm]
    % Time during stance phase (used for treadmill speed)
    tSurface = ((S.L(iStep).events(3) - S.L(iStep).events(4)) / nPoints ) * S.L(iStep).stepDuration;% time passing between CL TO (evt3) and CL HS (evt4) [s]
    % Surface motion velocity during stance phase
    vSurface = dSurface / tSurface; %[mm/s]
    % If surface velocity is small (e.g. overground where only minimal motion is present due to heel off)
    if vSurface < 20
        vSurface = 0;   %set surface motion to zero
    end
    
    % Obtain left and right foot lengths (used for step length calculation)
    [footLength] = calcFootLength(S.L(iStep)); %[L, R]
    
    % Test plot
%     figure(); hold on
%     scatter(S.L(iStep).points.LHEE(:,1), S.L(iStep).points.LHEE(:, 2), 'markerFaceColor', 'red', 'markerEdgeColor', 'none')
%     scatter(S.L(iStep).points.RHEE(:,1), S.L(iStep).points.RHEE(:, 2), 'markerFaceColor', 'green', 'markerEdgeColor', 'none')
%     line([S.L(iStep).points.RHEE(1,1) S.L(iStep).points.LHEE(1,1)], [S.L(iStep).points.LHEE(1,2) S.L(iStep).points.LHEE(1,2)], 'lineWidth', 2)
%     line([S.L(iStep).points.LHEE(1,1) S.L(iStep).points.LHEE(1,1)], [S.L(iStep).points.LHEE(1,2) S.L(iStep).points.RHEE(1,2)], 'lineWidth', 2)
%     axis equal
%     pause();
    
    %% Temporal Parameters
    % Swing time: left foot off (index 2) till end of cycle
    S.L(iStep).swingTime = ((nPoints - S.L(iStep).events(2)) / nPoints ) * S.L(iStep).stepDuration; %[s]
    % Stance time: from start of cycle to left foot off (index 2)
    S.L(iStep).stanceTime = ((S.L(iStep).events(2)) / nPoints ) * S.L(iStep).stepDuration; %[s]
    % Duty cycle: percentage of stance time from whole step duration
    S.L(iStep).dutyCycle = S.L(iStep).stanceTime / S.L(iStep).stepDuration; %[s]
    % Double stance: time during which both feet are on the ground (from current foot strike to contralateral foot off (index 4) plus from contralateral foot strike to current foot off (index 2 - 3))
    S.L(iStep).doubleStance = ((S.L(iStep).events(4) + (S.L(iStep).events(2) - S.L(iStep).events(3))) / nPoints)* S.L(iStep).stepDuration; %[s]
    % Single stance: time during which stance foot is on the ground (from contralateral foot off to foot strike (index 3 - 4))
    S.L(iStep).singleStance = ((S.L(iStep).events(3) - S.L(iStep).events(4)) / nPoints)* S.L(iStep).stepDuration; %[s]
    
    %% Spatial parameters
    % Step width determined from left step at HS
    S.L(iStep).stepWidth = S.L(iStep).points.RHEE(1,1) - S.L(iStep).points.LHEE(1,1); %[mm]
    % StepLength determined from left step HS to HS plus
    S.L(iStep).stepLength = S.L(iStep).points.LHEE(end,2) - S.L(iStep).points.RHEE(S.L(iStep).events(2),2) + vSurface*S.L(iStep).swingTime; %[mm]
    % Alternative calculation from heel to toe
    %S.L(iStep).stepLength = S.L(iStep).points.LHEE(1,2) - S.L(iStep).points.RTOE(1,2) + footLength(1); %[mm]
    % Stride Length determined from left step HS to HS plus
    %S.L(iStep).strideLength = S.L(iStep).points.LHEE(end,2) - S.L(iStep).points.LHEE(S.L(iStep).events(3),2) + footLength(1) + vSurface*S.L(iStep).swingTime; %[mm]
    S.L(iStep).strideLength = S.L(iStep).points.LHEE(end,2) - S.L(iStep).points.LTOE(S.L(iStep).events(2),2) + footLength(1) + vSurface*S.L(iStep).swingTime; %[mm] 
    
    %% Speed
    % Center of mass AP velocity
    S.L(iStep).velocityHuman = ((S.L(iStep).points.CoM(end,2) - S.L(iStep).points.CoM(1,2))/1000 ) /S.L(iStep).stepDuration; % [m/s]
    % Ground velocity during stance phase
    S.L(iStep).velocitySurface = vSurface/1000; %[m/s]
    
    %% Cadence
    % calculate cadence per step
    S.L(iStep).cadence = 60 / S.L(iStep).stepDuration;
end

%for every right step
for iStep = 1 : length(S.R)
    % Gait cycle:
    % Numbers behind gait events stand for storage indices (S.R.events)
    % Right Foot Strike (1) - Left Foot Off (4) - Left Foot Strike (3) - Right Foot Off (2)
    
    % Calculate globally used parameters
    % Number of total cycle data points for conversion from frames to seconds
    nPoints = length(S.R(iStep).points.RTOE) - 1;
    %Y-distance (anterior-posterior) of toe marker travelled during stance phase (used for treadmill speed)
    dSurface = S.R(iStep).points.RTOE(S.R(iStep).events(4),2) - S.R(iStep).points.RTOE(S.R(iStep).events(3),2); %[mm/second]
    % Time during stance phase (used for treadmill speed)
    tSurface = ((S.R(iStep).events(3) - S.R(iStep).events(4)) / nPoints ) * S.R(iStep).stepDuration;
    % Surface motion velocity during stance phase
    vSurface = dSurface / tSurface; %[mm/s]
    % If surface velocity is small (e.g. overground where only minimal motion is present due to heel off)
    if vSurface < 20
        vSurface = 0;   %set surface motion to zero
    end
    
    % Obtain left and right foot lengths (used for step length calculation)
    [footLength] = calcFootLength(S.R(iStep)); %[L, R]
    
    % Test plot
%     figure(); hold on
%     scatter(S.L(iStep).points.LHEE(:,1), S.L(iStep).points.LHEE(:, 2), 'markerFaceColor', 'red', 'markerEdgeColor', 'none')
%     scatter(S.L(iStep).points.RHEE(:,1), S.L(iStep).points.RHEE(:, 2), 'markerFaceColor', 'green', 'markerEdgeColor', 'none')
%     line([S.L(iStep).points.RHEE(1,1) S.L(iStep).points.LHEE(1,1)], [S.L(iStep).points.LHEE(1,2) S.L(iStep).points.LHEE(1,2)], 'lineWidth', 2)
%     line([S.L(iStep).points.LHEE(1,1) S.L(iStep).points.LHEE(1,1)], [S.L(iStep).points.LHEE(1,2) S.L(iStep).points.RHEE(1,2)], 'lineWidth', 2)
%     axis equal
%     pause();
    
    %% Temporal Parameters
    % Swing time: right foot off (index 2) till end of cycle
    S.R(iStep).swingTime = ((nPoints - S.R(iStep).events(2)) / nPoints ) * S.R(iStep).stepDuration; %[s]
    % Stance time: from start of cycle to right foot off (index 2)
    S.R(iStep).stanceTime = ((S.R(iStep).events(2)) / nPoints ) * S.R(iStep).stepDuration; %[s]
    % Duty cycle: percentage of stance time from whole step duration
    S.R(iStep).dutyCycle = S.R(iStep).stanceTime / S.R(iStep).stepDuration;
    % Double stance: time during which both feet are on the ground (from current foot strike to contralateral foot off (index 4) plus from contralateral foot strike to current foot off (index 2 - 3))
    S.R(iStep).doubleStance = ((S.R(iStep).events(4) + (S.R(iStep).events(2) - S.R(iStep).events(3))) / nPoints)* S.R(iStep).stepDuration; %[s]
    % Single stance: time during which stance foot is on the ground (from contralateral foot off to foot strike (index 3 - 4))
    S.R(iStep).singleStance = ((S.R(iStep).events(3) - S.R(iStep).events(4)) / nPoints)* S.R(iStep).stepDuration; %[s]
    
    %% Spatial parameters
    % Step width determined at HS
    S.R(iStep).stepWidth = S.R(iStep).points.RHEE(1,1) - S.R(iStep).points.LHEE(1,1); %[mm]
    % Step length determined from left step HS to right HS plus
    S.R(iStep).stepLength = S.R(iStep).points.RHEE(end,2) - S.R(iStep).points.LHEE(S.R(iStep).events(2),2) + vSurface*S.R(iStep).swingTime; %[mm]
    % Alternative calculation from heel to toe
    %S.R(iStep).stepLength = S.R(iStep).points.RHEE(1,2) - S.R(iStep).points.LTOE(1,2) + footLength(2); %[mm]
    % Stride Length determined from left step HS to HS plus
    %S.R(iStep).strideLength = S.R(iStep).points.RHEE(end,2) - S.R(iStep).points.RHEE(S.R(iStep).events(3),2) + footLength(2) + vSurface*S.R(iStep).swingTime; %[mm]
    S.R(iStep).strideLength = S.R(iStep).points.RHEE(end,2) - S.R(iStep).points.RTOE(S.R(iStep).events(2),2) + footLength(2) + vSurface*S.R(iStep).swingTime; %[mm]
    
    %% Speed
    % Center of mass AP velocity
    S.R(iStep).velocityHuman = ((S.R(iStep).points.CoM(end,2) - S.R(iStep).points.CoM(1,2))/1000 ) /S.R(iStep).stepDuration; % [m/s]
    % Ground velocity during stance phase
    S.R(iStep).velocitySurface = vSurface/1000; %[m/s]
    
    %% Cadence
    % calculate cadence per step
    S.R(iStep).cadence = 60 / S.R(iStep).stepDuration;
end

end

% Obtain mean left and right foot lengths
function FL = calcFootLength(S)
% Calculate euclidean distance between toe and heel markers (foot length)
%WARNING: More precise would be the foot length during stance phase instead
%of the full gait cycle
tFL(:,1) = sqrt(sum((S.points.LTOE - S.points.LHEE).^2,2)); % 3D distance
tFL(:,2) = sqrt(sum((S.points.RTOE - S.points.RHEE).^2,2)); % 3D distance
% Return average foot length over whole trial (left and right)
FL = median(tFL,1);
end
