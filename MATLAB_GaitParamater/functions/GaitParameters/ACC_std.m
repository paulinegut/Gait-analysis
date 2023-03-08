function [ACC] = ACC_std(Angle1,Angle2)
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

ACC_std = std(Mvec_length);
end