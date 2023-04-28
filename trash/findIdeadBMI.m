C = [3.0633, 0.15571, -0.0058342, 5.8823e-05]
compactLinModelPresentation(lme)
roots(C)

xx = 15:0.1:35;
nx = numel(xx);
close all
plot(xx,[ones(1,nx);xx;xx.^2;xx.^3]'*C')