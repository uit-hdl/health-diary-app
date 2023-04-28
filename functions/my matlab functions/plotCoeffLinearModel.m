function B = plotCoeffLinearModel(lm, varargin)
% takes a fitted linear model lm and displays the coefficients as a bar
% chart, along with confidence intervals and color coding for p-values. The
% order of the color code is in order of increasing significance.

%% preliminary

P.pValColors = ["lime", "yellow", "orange", "red"];
P.coeff2display = lm.CoefficientNames(2:numel(lm.CoefficientNames));
P.rearrangeOrder = {[], []};
P.coeff2plot = [];
P.horizontalPlot = false;

p = inputParser;
addOptional(p, "sigColorCode", P.pValColors)
addOptional(p, "coeff2display", P.coeff2display)
addOptional(p, "rearrangeOrder", P.rearrangeOrder)
addOptional(p, "coeff2plot", P.coeff2plot)
addOptional(p, "horizontalPlot", P.horizontalPlot)
parse(p, varargin{:});

P = updateOptionalArgs(P, p);

%% code
% get colors based on significance level
sigColorCode = signifColorCode(lm.Coefficients.pValue, P.pValColors);

% extract relevant information from dataframe ¤¤¤
LM = array2table([lm.Coefficients.Lower, lm.Coefficients.Upper, ...
    lm.Coefficients.Estimate, sigColorCode], ...
    "VariableNames", ["lower", "upper", "estimates", "sigColorCode"]);
names = lm.CoefficientNames';
LM = convertvars(LM, ["estimates", "lower", "upper"], "double");
LM = addvars(LM, names);

LM = LM(findInd(LM{:, "names"}, P.coeff2display), :);

J_permute = util_repositionArgs(LM{:, "names"}, ...
    P.rearrangeOrder{1}, P.rearrangeOrder{2});
LM = LM(J_permute, :);

% extract parameters to plot
CI = LM{:, ["lower", "upper"]};
N_par = height(LM);
N_obs = lm.NumObservations;

% plotting ¤¤¤
barText = categorical(LM{:, "names"});
barText = reordercats(barText, LM{:, "names"});
if P.horizontalPlot
    B = barh(barText, LM{:, "estimates"}, "BarWidth", 0.05, "FaceColor", ...
        color2triplet("grey"), "EdgeColor", "none");

    plotCIforEachCat(1:N_par, CI', LM{:, "sigColorCode"}, true)

    yticklabels(convert2LatexFormat(LM{:, "names"}))

else
    B = bar(barText, LM{:, "estimates"}, "BarWidth", 0.05, "FaceColor", ...
        color2triplet("grey"), "EdgeColor", "none");

    plotCIforEachCat(1:N_par, CI', LM{:, "sigColorCode"})

    xticklabels(convert2LatexFormat(LM{:, "names"}))
end

title(sprintf('n observations = %g', N_obs))

end
