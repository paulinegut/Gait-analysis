%% File: extractJointAngles
% Description: Function which calculates lower limb joint angles for single
%              left and right gait cycles based on simple vector geometry.
%
% Usage: Run 'Gait Parameter Extraction' script package which calls this
%        function
%
% Input: S - structure containing all parameters extracted from c3d files
%        jointAngleType - character string being either 'Vectors' or 
%                         'Model'
%
% Output: S - MATLAB structure containing extracted c3d parameters
%
% Other files required: 'Gait Parameter Extraction' script package
%
% Date        Author      Revision
% 20191010    CMey&MBan   Adapted code from CMey for script package
% 20191128    MBan        Added warning if no model angles exist
%

%% ------------------- BEGIN CODE -------------------

function [S] = extractJointAngles(S, jointAngleType)

if (strcmp(jointAngleType,'Vectors'))
    % For each right step
    for iStep = 1:length(S.R)
        
        % Calibration
        
        % Load static calibration trial and calculate zero values for hip angle
        % [Filename,Pathname]=uigetfile('*.c3d','Calibration trial');
        % cd(Pathname);
        %
        % c3d = btkReadAcquisition(Filename); %aquire handle for reading c3d
        % markerDataCal = btkGetMarkers(c3d);%obtain marker position data
        % btkCloseAcquisition(c3d);
        %     markerDataCal.Vector_LFemur(1,:)=markerDataCal.LKNE(1,:)-markerDataCal.LFEP(1,:);
        %     markerDataCal.Vector_LCrest(1,:)=markerDataCal.SACR(1,:)-markerDataCal.LFEP(1,:);
        %     markerDataCal.LHip(1,1)=acosd(dot(markerDataCal.Vector_LCrest(1,:),markerDataCal.Vector_LFemur(1,:))/(norm(markerDataCal.Vector_LCrest(1,:))*norm(markerDataCal.Vector_LFemur(1,:))));
        %
        %     markerDataCal.Vector_RFemur(1,:) = S.R.points.RKNE(1,:)- S.R.points.RFEP(1,:);
        %     markerDataCal.Vector_RCrest(1,:) = S.R.points.SACR(1,:)-S.R.points.RFEP(1,:);
        %     S.R(step).angs.Rhip = acosd(dot(markerDataCal.Vector_RCrest(1,:),S.R.points.Vector_RFemur(1,:))/(norm(markerDataCal.Vector_RCrest(1,:))*norm(markerDataCal.Vector_RFemur(1,:))));
        %
        %     corr_right=mean(markerDataCal.RHip);
        %     corr_left=mean(markerDataCal.LHip);
        %
        %     RTOE_corr=markerDataCal.RTOE(10,3);
        %     LTOE_corr=markerDataCal.LTOE(10,3);
        
        % Define vectors for joint angles
        markerData.Vector_RTibia = S.R(iStep).points.RANK - S.R(iStep).points.RKNE;
        markerData.Vector_RFoot = S.R(iStep).points.RTOE - S.R(iStep).points.RANK;
        markerData.Vector_RFemur = S.R(iStep).points.RKNE - S.R(iStep).points.RFEP;
        markerData.Vector_RCrest = S.R(iStep).points.SACR - S.R(iStep).points.RFEP;
        
        for j = 1:length(markerData.Vector_RTibia)
            S.R(iStep).angs.Rank(j) = acosd(dot(markerData.Vector_RTibia(j,:),markerData.Vector_RFoot(j,:))/(norm(markerData.Vector_RTibia(j,:))*norm(markerData.Vector_RFoot(j,:))));
            S.R(iStep).angs.Rkne(j) = acosd(dot(markerData.Vector_RTibia(j,:),markerData.Vector_RFemur(j,:))/(norm(markerData.Vector_RTibia(j,:))*norm(markerData.Vector_RFemur(j,:))));
            S.R(iStep).angs.Rhip(j) = acosd(dot(markerData.Vector_RCrest(j,:),markerData.Vector_RFemur(j,:))/(norm(markerData.Vector_RCrest(j,:))*norm(markerData.Vector_RFemur(j,:))));
        end
        
        % Correct hip and ankle angles
        %markerData.RHip=markerData.RHip-corr_right;
        %markerData.RAnkle=markerData.RAnkle-90;
        
        %markerData.RTOE_y=markerData.RTOE(:,2)-markerData.SACR(:,2);
        %markerData.RTOE_z=markerData.RTOE(:,3)-RTOE_corr;
    end
    
    % For each left step
    for iStep = 1:length(S.L)
        
        % Define vectors for joint angles
        markerData.Vector_LTibia = S.L(iStep).points.LANK - S.L(iStep).points.LKNE;
        markerData.Vector_LFoot = S.L(iStep).points.LTOE - S.L(iStep).points.LANK;
        markerData.Vector_LFemur = S.L(iStep).points.LKNE - S.L(iStep).points.LFEP;
        markerData.Vector_LCrest = S.L(iStep).points.SACR - S.L(iStep).points.LFEP;
        
        for j = 1:length(markerData.Vector_LTibia)
            S.L(iStep).angs.Lank(j) = acosd(dot(markerData.Vector_LTibia(j,:),markerData.Vector_LFoot(j,:))/(norm(markerData.Vector_LTibia(j,:))*norm(markerData.Vector_LFoot(j,:))));
            S.L(iStep).angs.Lkne(j) = acosd(dot(markerData.Vector_LTibia(j,:),markerData.Vector_LFemur(j,:))/(norm(markerData.Vector_LTibia(j,:))*norm(markerData.Vector_LFemur(j,:))));
            S.L(iStep).angs.Lhip(j) = acosd(dot(markerData.Vector_LCrest(j,:),markerData.Vector_LFemur(j,:))/(norm(markerData.Vector_LCrest(j,:))*norm(markerData.Vector_LFemur(j,:))));
        end
        
    end
    
else
    % If Plugin-Gait model angles were selected by user but do not exist
    if(isempty(fieldnames(S.angs)))
        % Warn user that the trial contains no model angles
        disp(["No model angles found in trial " S.stats.trialName]); 
    end
end


