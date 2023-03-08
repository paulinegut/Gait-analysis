function xvals = plotJitter(data,spread)

if nargin < 2
    spread = 5;
end

xvals = (rand(length(data),1)-0.5)/spread;

end