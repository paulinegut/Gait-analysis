%% ########################################################################
% 
% Extraction of deficits
%
% Version 14. January 2021
% Author: Pauline Rose Gut
% #########################################################################

function [Deficits] = Deficits(Zscores)
% ROM
for i = 1:10
    if abs(Zscores(i,1)) >= 2
        Deficits(i,1) = Zscores(i,1);
    else
        Deficits(i,1) = 0;
    end
end
clear i;

% Stability/Balance; Interlimb coord.; SSD; Variability
for i = 11:16
    if Zscores(i,1) >= 2
        Deficits(i,1) = Zscores(i,1);
    else
        Deficits(i,1) = 0;
    end
end
clear i;
for i = 21:23
    if Zscores(i,1) >= 2
        Deficits(i,1) = Zscores(i,1);
    else
        Deficits(i,1) = 0;
    end
end
clear i;

% ACC
for i = 17:20
    if Zscores(i,1) <= -2
        Deficits(i,1) = Zscores(i,1);
    else
        Deficits(i,1) = 0;
    end
end
clear i;

end
