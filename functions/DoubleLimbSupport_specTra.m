%% ########################################################################
% Clinical Gait Analysis
% Extraction of gait parameters with the Plug-in-Gait Model
% Double limb support calculation
%
% Version 15. March 2021
% Author: Pauline Rose Gut
% #########################################################################

function DoubleLimbSupport = DoubleLimbSupport_specTra(S1, S2)
A1 = [S1.R.stanceTime].' + [S1.R.swingTime].';
B1 = [S1.R.doubleStance].';

A2 = [S2.R.stanceTime].' + [S2.R.swingTime].';
B2 = [S2.R.doubleStance].';

for i = 1:length(A1)
    DLSR1(i,1) = B1(i,1)*100/A1(i,1);
end
clear i A1 B1;
for i = 1:length(A2)
    DLSR2(i,1) = B2(i,1)*100/A2(i,1);
end
clear i A2 B2;

A1 = [S1.L.stanceTime].' + [S1.L.swingTime].';
B1 = [S1.L.doubleStance].';

A2 = [S2.L.stanceTime].' + [S2.L.swingTime].';
B2 = [S2.L.doubleStance].';

for i = 1:length(A1)
    DLSL1(i,1) = B1(i,1)*100/A1(i,1);
end
clear i A1 B1
for i = 1:length(A2)
    DLSL2(i,1) = B2(i,1)*100/A2(i,1);
end
clear i A2 B2;

m1 = mean([DLSR1; DLSR2]);
m2 = mean([DLSL1; DLSL2]);
std1 = std([DLSR1; DLSR2]);
std2 = std([DLSL1; DLSL2]);
DoubleLimbSupport.Mean = mean([m1 m2]); % [%]
DoubleLimbSupport.Std = mean([std1 std2]); 
clear DLSL1 DLSL2 DLSR1 DLSR2 m1 m2 std1 std2
end