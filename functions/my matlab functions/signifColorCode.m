function colors = signifColorCode(p, sigColorCode)
% returns a string arrayp is a vector of p-values.
if nargin == 1
    sigColorCode = ["blue", "green", "yellow", "blue"];
end

n = numel(p);
colors = strings(n, 1);

sig(1, :) = p > 0.10;
sig(2, :) = and(p <= 0.10, p > 0.05);
sig(3, :) = and(p <= 0.05, p > 0.001);
sig(4, :) = p <= 0.001;

for i = 1:4
    colors(sig(i, :), :) = sigColorCode(i);
end

end