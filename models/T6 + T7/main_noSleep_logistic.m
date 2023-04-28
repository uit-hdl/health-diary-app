%% Get data
if ~exist('TUdata', 'var')
    importLongData
end
theGreatVariableForge

% load train and test set:
load("mat_testAndTrainingSet.mat", "I_fit", "I_test")

% Main Model
modelData = data;
modelData.srh_good = compare(modelData.srh, "geq", 4)
% Create model formula
fixedVars = {; ...
    'age:age', ...
    'education', ...
    'sex', ...
    'diabHba1c'};
decisionVars = {'PA', 'hii*hii', ...
    'bmi', 'smokeNow', ...
    'friendsSupp', 'hscl^3'};
interactionPart = {'bmi:old', 'old:PAf4i3'};
formula = getLinearModelFormula([fixedVars, decisionVars, interactionPart, ...
    {'(1|id)'}], 'srh_good');

% Fit model
lme_logistic = fitglme(modelData(I_fit, :), formula, "Distribution", "Binomial");

Coeff_compact1 = compactLinModelPresentation(lme_logistic, {'Name', 'Estimate', 'pValue', 'sigLvl'}) %#ok<*NASGU>
Coeff_compact2 = util_tabularModelPresentation( ...
    Coeff_compact1{:, 1}, ...
    Coeff_compact1{:, 2}, ...
    Coeff_compact1.Properties.RowNames)

if 1 == 0
    predictorNames = lme_logistic.PredictorNames
    save("model_jan_17.mat", "lme_logistic", "predictorNames")
end

get_plottable_parameter_table
Coeff_compact1(["hii", "hii^2"], "Estimate")
%% Hold exercise intensity fixed, increase frequency, and plot effect
delta_PAfrq_i1 = [; ...
    Coeff_compact1{"PA_f1i1", "Estimate"}; ...
    Coeff_compact1{"PA_f2i1", "Estimate"}; ...
    Coeff_compact1{"PA_f3i1", "Estimate"}; ...
    Coeff_compact1{"PA_f4i1", "Estimate"}];
CI_i1 = [; ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f1i1", "PA_f1i1", "include_estimate", "middle"); ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f2i1", "PA_f1i1", "include_estimate", "middle"); ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f3i1", "PA_f1i1", "include_estimate", "middle"); ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f4i1", "PA_f1i1", "include_estimate", "middle"); ...
    ];
delta_PAfrq_i2 = [; ...
    Coeff_compact1{"PA_f1i2", "Estimate"}; ...
    Coeff_compact1{"PA_f2i2", "Estimate"}; ...
    0; ...
    Coeff_compact1{"PA_f4i2", "Estimate"}];
CI_i2 = [; ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f1i2", "PA_f1i1", "include_estimate", "middle"); ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f2i2", "PA_f1i1", "include_estimate", "middle"); ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f3i2", "PA_f1i1", "include_estimate", "middle"); ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f4i2", "PA_f1i1", "include_estimate", "middle"); ...
    ];
delta_PAfrq_i3 = [; ...
    Coeff_compact1{"PA_f1i3", "Estimate"}; ...
    Coeff_compact1{"PA_f2i3", "Estimate"}; ...
    Coeff_compact1{"PA_f3i3", "Estimate"}; ...
    Coeff_compact1{"PA_f4i3", "Estimate"}];
CI_i3 = [; ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f1i3", "PA_f1i1", "include_estimate", "middle"); ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f2i3", "PA_f1i1", "include_estimate", "middle"); ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f3i3", "PA_f1i1", "include_estimate", "middle"); ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f4i3", "PA_f1i1", "include_estimate", "middle"); ...
    ]
delta_PAfrq_i1 = delta_PAfrq_i1 - Coeff_compact1{"PA_f1i1", "Estimate"};
delta_PAfrq_i2 = delta_PAfrq_i2 - Coeff_compact1{"PA_f1i1", "Estimate"};
delta_PAfrq_i3 = delta_PAfrq_i3 - Coeff_compact1{"PA_f1i1", "Estimate"};

close all
set(groot, 'defaultAxesTickLabelInterpreter', 'latex')
figure
subplot(121)
hold on
plot(CI_i1(:, 2), '-gs', "MarkerFaceColor", 'k');
plotCIforEachCat(1:4, CI_i1(:, [1, 3])')
a = scatter(1:4, CI_i1(:, 2), "MarkerEdgeColor", "k", "MarkerFaceColor", "g")

plot(CI_i2(:, 2), '-bs', "MarkerFaceColor", 'k');
plotCIforEachCat(1:4, CI_i2(:, [1, 3])')
b = scatter(1:4, CI_i2(:, 2), "MarkerEdgeColor", "k", "MarkerFaceColor", "b")

plot(CI_i3(:, 2), '-rs', "MarkerFaceColor", 'k');
plotCIforEachCat(1:4, CI_i3(:, [1, 3])')
c = scatter(1:4, CI_i3(:, 2), "MarkerEdgeColor", "k", "MarkerFaceColor", "r")

ylim([0, 0.9])
xlim([0.5, 4.5])
xticklabels(["$<$1", "1", "2-3", "$\geq$4"])
xlabel("N.o. exercise sessions per week", "Interpreter", "latex")
ylabel("SRH", "Interpreter", "latex")
legend([a, b, c], ["Mild intensity", "Moderate intensity", "High intensity"])
title(sprintf("(a) Effect relative to the most \n"+ ...
    "sedentary group"))
% ****** relative to sedentary group **************************************
delta_PAfrq_i1 = [; ...
    Coeff_compact1{"PA_f1i1", "Estimate"}; ...
    Coeff_compact1{"PA_f2i1", "Estimate"}; ...
    Coeff_compact1{"PA_f3i1", "Estimate"}; ...
    Coeff_compact1{"PA_f4i1", "Estimate"}];
CI_i1 = [; ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f1i1", "PA_f1i1", "include_estimate", "middle"); ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f2i1", "PA_f1i1", "include_estimate", "middle"); ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f3i1", "PA_f1i1", "include_estimate", "middle"); ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f4i1", "PA_f1i1", "include_estimate", "middle"); ...
    ];
delta_PAfrq_i2 = [; ...
    Coeff_compact1{"PA_f1i2", "Estimate"}; ...
    Coeff_compact1{"PA_f2i2", "Estimate"}; ...
    0; ...
    Coeff_compact1{"PA_f4i2", "Estimate"}];
CI_i2 = [; ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f1i2", "PA_f1i2", "include_estimate", "middle"); ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f2i2", "PA_f1i2", "include_estimate", "middle"); ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f3i2", "PA_f1i2", "include_estimate", "middle"); ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f4i2", "PA_f1i2", "include_estimate", "middle"); ...
    ];
delta_PAfrq_i3 = [; ...
    Coeff_compact1{"PA_f1i3", "Estimate"}; ...
    Coeff_compact1{"PA_f2i3", "Estimate"}; ...
    Coeff_compact1{"PA_f3i3", "Estimate"}; ...
    Coeff_compact1{"PA_f4i3", "Estimate"}];
CI_i3 = [; ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f1i3", "PA_f1i3", "include_estimate", "middle"); ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f2i3", "PA_f1i3", "include_estimate", "middle"); ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f3i3", "PA_f1i3", "include_estimate", "middle"); ...
    util_get_CI_for_paramDiff(lme_logistic, "PA_f4i3", "PA_f1i3", "include_estimate", "middle"); ...
    ]
delta_PAfrq_i1 = delta_PAfrq_i1 - Coeff_compact1{"PA_f1i1", "Estimate"};
delta_PAfrq_i2 = delta_PAfrq_i2 - Coeff_compact1{"PA_f1i2", "Estimate"};
delta_PAfrq_i3 = delta_PAfrq_i3 - Coeff_compact1{"PA_f1i3", "Estimate"};


set(groot, 'defaultAxesTickLabelInterpreter', 'latex')
subplot(122)
hold on
plot(CI_i1(:, 2), '-gs', "MarkerFaceColor", 'k');
plotCIforEachCat(1:4, CI_i1(:, [1, 3])')
a = scatter(1:4, CI_i1(:, 2), "MarkerEdgeColor", "k", "MarkerFaceColor", "g")

plot(CI_i2(:, 2), '-bs', "MarkerFaceColor", 'k');
plotCIforEachCat(1:4, CI_i2(:, [1, 3])')
b = scatter(1:4, CI_i2(:, 2), "MarkerEdgeColor", "k", "MarkerFaceColor", "b")

plot(CI_i3(:, 2), '-rs', "MarkerFaceColor", 'k');
plotCIforEachCat(1:4, CI_i3(:, [1, 3])')
c = scatter(1:4, CI_i3(:, 2), "MarkerEdgeColor", "k", "MarkerFaceColor", "r")

ylim([0, 0.9])
xlim([0.5, 4.5])
xticklabels(["$<$1", "1", "2-3", "$\geq$4"])
xlabel("N.o. exercise sessions per week", "Interpreter", "latex")
ylabel("SRH", "Interpreter", "latex")
title(sprintf("(b) Effect of increasing frequency\n"+ ...
    "within each intensity subgroup"))

%% ¤¤¤ Plot ¤¤¤¤
get_plottable_parameter_table

close all

figure
set(groot, 'defaultAxesTickLabelInterpreter', 'latex')
hold on

get_plottable_parameter_table
a = plotCoeffLinearModel_v2(param_table)
% Add dashed vertical lines
xlabels = a.XData;
for i = 1:numel(xlabels)
    line([i, i], [0, 1], "color", color2triplet("grey"), "LineStyle", ":")
end

ylabel("SRH", "Interpreter", "Latex")
title ''
set(gca, 'xaxisLocation', 'top')
pixelSize = 20; % for the article, use size=20.
fontsize(gca, pixelSize, "pixels")
ylimits = gca().YLim;
ylim([min(param_table.coef) - 0.4, ...
    max(param_table.coef) + 0.25])

a = plot(1, 3, 'o', 'MarkerFaceColor', color2triplet("darkred"), 'MarkerEdgeColor', "k")
b = plot(1, 3, 'o', 'MarkerFaceColor', color2triplet("orange"), 'MarkerEdgeColor', "k")
c = plot(1, 3, 'o', 'MarkerFaceColor', color2triplet("lime"), 'MarkerEdgeColor', "k")

legend([a, b, c], ["p<0.001", "p<0.05", "p<0.1"])

% save coefficients in table format
if 1 == 2
    writetable(T, "EstimatedCoeff_noInsomnia.csv", "WriteRowNames", true)
end

%% prediction on training set
D = modelData(I_fit, :);
y = D.SRH;
D.id = zeros(height(D), 1);

y_hat = lme_logistic.predict(D);
I_nan = or(isnan(y_hat), isnan(y));
y = y(~I_nan);
y_hat = y_hat(~I_nan);

r = y_hat - y;
R.metrics.noInsomnia = util_get_predictionMetrics(y, y_hat);
close all
plot(normrnd(y, 0.01), y_hat, 'o', "color", color2triplet("grey"))
hold on
plotCIforEachCat(y, y_hat)
ylim([1, 4])
title("SRH vs predicted SRH", "Interpreter", "latex")

R.metrics.noInsomnia = util_get_predictionMetrics(y, y_hat);
R.metrics.noInsomnia

%% predict on test set:
y = modelData(I_test, :).SRH;
y_hat = lme_logistic.predict(modelData(I_test, :))
I_nan = or(isnan(y_hat), isnan(y));
y = y(~I_nan);
y_hat = y_hat(~I_nan);

close all
subplot(1, 2, 1)
plot(util_shakeCoordinates(y, 0.05), y_hat, 'o', "color", color2triplet("grey"))
hold on
plotCIforEachCat(y, y_hat)
ylim([1, 4])
ylabel('predicted SRH')
xlabel('SRH')
title("predicted vs actual SRH")

RMSE = rmse(y, y_hat);
y_hat_good = y_hat >= 2.5;
c = corr([y, y_hat])

% plot residuals:
r = y_hat - y;
subplot(1, 2, 2)
plot(util_shakeCoordinates(y, 0.05), r, 'o', "color", color2triplet("grey"))
hold on
plotCIforEachCat(y, r)
title("SRH vs residuals")
ylabel('residuals')
xlabel('SRH')
% compute metrics:
c_test = corr([y, y_hat]);
RMSE = rmse(y, y_hat);
y_hat_discr = round(y_hat);
acc_goodBad = mean((y_hat_discr > 2) == (y > 2));
sn_good = mean(y_hat_discr(y > 2) > 2);
sn_bad = mean(y_hat_discr(y < 3) < 3);
modAccuracy = mean([sn_good, sn_bad]);

sprintf("(good or bad) Accuracy=%.3g \n"+ ...
    "SN=%.3g \n"+ ...
    "SP=%.3g \n"+ ...
    "MAcc=%.3g \n"+ ...
    "RMSE = %g \n"+ ...
    "correlation=%.3g", acc_goodBad, sn_good, sn_bad, modAccuracy, RMSE, c_test(1, 2))

%% plot SRH as a function of HSCL
C = dataset2table(lme_logistic.Coefficients);
C.Properties.RowNames = C.Name;
C = C(:, "Estimate")

x = 0:0.1:4;
close all;
plot(x, C{"hscl", :}*x+C{"hscl^2", :}*x.^2+C{"hscl^3", :}*x.^3)

%%
figure
plot(modelData.hscl, lme_logistic.residuals, 'o')
xlabel('hscl')
ylabel('residual')
yline(0)

%% Prediction
lme_logistic.predict

%% fit test model:
m67 = fitglme_logistic(data(t >= 6, :), 'srh ~  age + bmi + old:bmi + (1|id)');

%%

m67.Coefficients.Estimate
m67.CoefficientNames

k = k + 1;
T = data(k, :)
T.id = -1;
z = m67.predict(T)
X = getCovariateVector(m67.CoefficientNames, T);

X * m67.Coefficients.Estimate