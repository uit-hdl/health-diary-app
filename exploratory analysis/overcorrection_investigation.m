%% Get data
if ~exist('TUdata', 'var')
    importLongData
end
theGreatVariableForge

% Main Model
modelData = data(t >= 6, :);
% modelData = modelData(~modelData.PA_nonsense, :)

vars = {'age*age', 'education', 'sex', 'PA', "smokeNow"};

formula = getLinearModelFormula([vars, {'(1|id)', '(1|t)'}], 'srh');

lme_reduced = fitglme(modelData, formula);
T = compactLinModelPresentation(lme_reduced, ...
    {'Name', 'Estimate', 'pValue', 'sigLvl'}) %#ok<*NASGU>
T{"PA_f4i3", "Estimate"} - T{"PA_f1i1", "Estimate"}
set(groot, 'defaultAxesTickLabelInterpreter', 'none');
close all
figure
a = plotCoeffLinearModel(lme_reduced)
title 'Main model T6-T7'

%% PA fit a range of models, successively adding one variable at a time.
vars_base = {'age*age', 'education', 'sex', 'PA', "smokeNow"};

vars_mediators = {"bmi", "hii^2", ...
    "hscl^3"}; %#ok<*CLARRSTR>
clear PA_diff

N_models = numel(vars_mediators) + 1;
PA_diff = zeros(N_models, 3);
for i = 1:N_models
    formula = getLinearModelFormula([vars_base, vars_mediators(1:i-1), ...
        {'(1|id)', '(1|t)'}], 'srh');
    lme_reduced = fitglme(modelData, formula);
    T = compactLinModelPresentation(lme_reduced, ...
        {'Name', 'Estimate', 'pValue', 'sigLvl'}) %#ok<*NASGU>
    PA_diff(i, 2) = T{"PA_f4i3", "Estimate"} - T{"PA_f1i1", "Estimate"};

    % calculate confidence intervals
    k1 = find(T.Properties.RowNames == "PA_f4i3");
    k2 = find(T.Properties.RowNames == "PA_f1i1");
    V = lme_reduced.CoefficientCovariance;
    covariance = V(k1, k2);
    V1 = V(k1, k1);
    V2 = V(k2, k2);
    var_level_diff = V1 - 2 * covariance + V2;
    PA_diff(i, [1, 3]) = PA_diff(i, 2) + [-1, 1] * 1.96 * sqrt(var_level_diff)

end

%% bar plot
close all
subplot(1, 2, 1)
bar(PA_diff(:, 2), "BarWidth", 0.9, "FaceColor", color2triplet("grey"), ...
    "EdgeColor", color2triplet("black"), "LineWidth", 2)
xticklabels(["base model", "+ BMI", "+ HII", "+ HSCL"])
ylim([0, 0.9])
ylabel("effect of vigerous PA on SRH")
title("Model impact of vigerous PA")

hold on
plotCIforEachCat(1:height(PA_diff), PA_diff(:, [1, 3])')

%% BMI fit a range of models, successively adding one variable at a time.
vars_base = {'age*age', 'education', 'sex', 'bmi', "smokeNow"};
vars_mediators = {"bloodP", "diabHba1c", "hii^2"};

clear BMI_diff
N_models = numel(vars_mediators) + 1;
PA_diff = zeros(N_models, 3);
for i = 1:N_models
    formula = getLinearModelFormula([vars_base, vars_mediators(1:i-1), ...
        {'(1|id)', '(1|t)'}], 'srh');
    lme_reduced = fitglme(modelData, formula);
    T = compactLinModelPresentation(lme_reduced, ...
        {'Name', 'Estimate', 'pValue', 'sigLvl'}) %#ok<*NASGU>
    ideal_lvl = "bmi_2";
    worst_lvl = "bmi_4";
    BMI_diff(i, 2) = T{ideal_lvl, "Estimate"} - T{worst_lvl, "Estimate"};

    % calculate confidence intervals
    k1 = find(T.Properties.RowNames == ideal_lvl);
    k2 = find(T.Properties.RowNames == worst_lvl);
    V = lme_reduced.CoefficientCovariance;
    covariance = V(k1, k2);
    V1 = V(k1, k1);
    V2 = V(k2, k2);
    var_level_diff = V1 - 2 * covariance + V2;
    BMI_diff(i, [1, 3]) = BMI_diff(i, 2) + [-1, 1] * 1.96 * sqrt(var_level_diff)

end

%% bar plot BMI overcorrection
subplot(1, 2, 2)
bar(BMI_diff(:, 2), "BarWidth", 0.9, "FaceColor", color2triplet("grey"), ...
    "EdgeColor", color2triplet("black"), "LineWidth", 2)
xticklabels(["base model", ...
    "+ high BP", ...
    "+ diabetes", ...
    "+ HII"])

ylim([0, 0.5])
ylabel("effect of obesity on SRH")
title("Model impact of obesity")

hold on
plotCIforEachCat(1:height(BMI_diff), BMI_diff(:, [1, 3])')
