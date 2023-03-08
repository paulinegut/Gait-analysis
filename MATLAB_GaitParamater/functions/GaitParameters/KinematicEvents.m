function [RHeelstrikes,LHeelstrikes,RFootOff,LFootOff] = KinematicEvents(RHEE,LHEE,RTOE,LTOE,vis)
% Treadmill event detection according to kinematics (Zeni) using velocity in
% y-direction 
% Input are the marker data of RHeel, LHeel, RTOE and LTOE during treadmill
% walking. Vis determines if a visual control is carried out or not (1=yes,
% 0=no).

   diff_signal=diff(RHEE(:,2));  
   for j = 1:length(diff_signal)
       if diff_signal(j,1) < 0
           temp(j,1)=1;
       else
           temp(j,1)=0;    
       end
   end
   RHeelstrikes=diff(temp);
   RHeelstrikes=find(RHeelstrikes==1)+1;
   
   if vis==1
   plot(diff_signal)
   title('Right Heelstrikes')
   hold on
   scatter(RHeelstrikes,diff_signal(RHeelstrikes),'r')
   pause
   close all
   end
   
   clear temp diff_signal
   

   diff_signal=diff(LHEE(:,2));  
   for j = 1:length(diff_signal)
       if diff_signal(j,1) < 0
           temp(j,1)=1;
       else
           temp(j,1)=0;    
       end
   end
   LHeelstrikes=diff(temp);
   LHeelstrikes=find(LHeelstrikes==1)+1;
   
   if vis==1
   plot(diff_signal)
   title('Left Heelstrikes')
   hold on
   scatter(LHeelstrikes,diff_signal(LHeelstrikes),'r')
   pause
   close all
   end
   
   clear temp diff_signal
   
   
   
   diff_signal=diff(RTOE(:,2));  
   for j = 1:length(diff_signal)
       if diff_signal(j,1) > 0
           temp(j,1)=1;
       else
           temp(j,1)=0;    
       end
   end
   RFootOff=diff(temp);
   RFootOff=find(RFootOff==1)+1;
   
   if vis==1
   plot(diff_signal)
   hold on
   scatter(RFootOff,diff_signal(RFootOff),'r')
   pause
   close all
   end
   
   clear temp diff_signal
   
   
   
    diff_signal=diff(LTOE(:,2));  
   for j = 1:length(diff_signal)
       if diff_signal(j,1) > 0
           temp(j,1)=1;
       else
           temp(j,1)=0;    
       end
   end
   LFootOff=diff(temp);
   LFootOff=find(LFootOff==1)+1;
   
   if vis==1
   plot(diff_signal)
   hold on
   scatter(LFootOff,diff_signal(LFootOff),'r')
   pause
   close all
   end
   
   clear temp diff_signal
   
   


end

