



function [ACC] = ACC(Angle1,Angle2)


% Centering is not infleuncing the ACC values, since it is only a measure
% for shape!

% % Centering the cyclograms
% for c=1:size(Angle1,1)
%     centering1(c,1)=mean(Angle1(c,:));
%     centering2(c,1)=mean(Angle2(c,:));
%     for k=1:100
%     Angle1(c,k)=Angle1(c,k)-centering1(c,1);
%     Angle2(c,k)=Angle2(c,k)-centering2(c,1);
%     
%     end
%     
% end



for i=1:99
    Intervals_Angle1(:,i)=Angle1(:,i+1)-Angle1(:,i);
    Intervals_Angle2(:,i)=Angle2(:,i+1)-Angle2(:,i);
end

Intervals_Angle1_squared=Intervals_Angle1.^2;
Intervals_Angle2_squared=Intervals_Angle2.^2;

Interval_sum=Intervals_Angle1_squared+Intervals_Angle2_squared;
Interval_sum_sqrt=sqrt(Interval_sum);

cos=Intervals_Angle1./Interval_sum_sqrt;
sin=Intervals_Angle2./Interval_sum_sqrt;

for i=1:99
Mcos(1,i)=mean(cos(:,i));
Msin(1,i)=mean(sin(:,i));
end

Mvec_length=sqrt(Mcos.^2+Msin.^2);

ACC= mean(Mvec_length);
end