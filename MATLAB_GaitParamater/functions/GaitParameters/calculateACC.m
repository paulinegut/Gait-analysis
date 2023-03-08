% Calculate ACC over all steps
function [ACC, ACC_std] = calculateACC(Angle1, Angle2)

    Intervals_Angle1 = diff(Angle1,1,2);
    Intervals_Angle2 = diff(Angle2,1,2);

    Intervals_Angle1_squared = Intervals_Angle1.^2;
    Intervals_Angle2_squared = Intervals_Angle2.^2;

    Interval_sum = Intervals_Angle1_squared+Intervals_Angle2_squared;
    Interval_sum_sqrt = sqrt(Interval_sum);

    cos = Intervals_Angle1./Interval_sum_sqrt;
    sin = Intervals_Angle2./Interval_sum_sqrt;

    Mcos = mean(cos);
    Msin = mean(sin);


    Mvec_length = sqrt(Mcos.^2 + Msin.^2);

    ACC = mean(Mvec_length);
    ACC_std = std(Mvec_length);
end