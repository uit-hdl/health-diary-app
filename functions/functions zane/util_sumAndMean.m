function str = util_sumAndMean(x, varargin)
% compute both the sum and mean of the elements in x (a binary vector) and
% present as a formatted string.

% formats:
% style 1: sum (%)            ex: 12 (51)
% style 2: sum (%%)           ex: 12 (51%)
%% optional arguments
P.formatingStyle = "sum (%)";
P.percentageDisplay = true;

p = inputParser;
addOptional(p, "formatingStyle", P.formatingStyle)
addOptional(p, "percentageDisplay", P.percentageDisplay)
parse(p, varargin{:});

P = updateOptionalArgs(P, p);

%% main
s = sum(x);
m = mean(x);
if P.percentageDisplay
    k = 100;
end

if P.formatingStyle == "sum (%)"
    % ex: 21.2 + (0.56)
    str = sprintf('%g (%.2g)', s, m*k);
elseif P.formatingStyle == "sum (%%)"
    % ex: 21.2 + (13.2%)
    str = sprintf('%g (%.2g%%)', s, m*100);
else
%     ex: 21.2 + (13.2: 10.1-14.5)
    ci = computeCImeanEst(x);
    str = sprintf('%g (%.3g%%: %.3g-%.3g)', s, m*k, ci(1)*k, ci(2)*k);
end


end