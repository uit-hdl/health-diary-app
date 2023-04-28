% In this script I compare the impact on SRH of HII and HSCL by comparing
% their impact when evaluated at standardized points (2 std above mean) of
% their respective distributions.

close
histogram(data.hii(data.t == 7))
title("T7 distribution of HII")

%%
if ~exist('TUdata', 'var')
    importLongData
end
theGreatVariableForge
% load train and test set:
load("mat_testAndTrainingSet.mat", "I_fit", "I_test")
% Main Model
modelData = data;

% Create model formula
fixedVars = {; ...
    'age:age', ...
    'education', ...
    'sex', ...
    'diabHba1c'};
decisionVars_orgl = {'PA', 'hii*hii', 'bmi', 'smokeNow', 'friendsSupp', 'hscl^3'};
interactionPart = {'bmi:old', 'old:PAf4i3'};

decisionVars = {'PA', 'hii*hii', 'bmi', 'smokeNow', 'friendsSupp', 'hscl^3'};
formula = getLinearModelFormula([fixedVars, decisionVars, interactionPart, ...
    {'(1|id)'}], 'srh');
lme_full = fitglme(modelData(I_fit, :), formula);

decisionVars = {'PA', 'hii*hii', 'bmi', 'smokeNow', 'friendsSupp'};
formula = getLinearModelFormula([fixedVars, decisionVars, interactionPart, ...
    {'(1|id)'}], 'srh');
lme_no_hscl = fitglme(modelData(I_fit, :), formula);

decisionVars = {'PA', 'bmi', 'smokeNow', 'friendsSupp', 'hscl^3'};
formula = getLinearModelFormula([fixedVars, decisionVars, interactionPart, ...
    {'(1|id)'}], 'srh');
lme_no_hii = fitglme(modelData(I_fit, :), formula);

%%
sprintf( ...
    "R-squared, full mode: %.3g\n "+ ...
    "R-squared, no HSCL: %.3g\n"+ ...
    "R-squared, no HII: %.3g", ...
    lme_full.Rsquared.Ordinary, ...
    lme_no_hscl.Rsquared.Ordinary, ...
    lme_no_hii.Rsquared.Ordinary)

%% prediction on training set
D = modelData(I_fit, :);
y = D.srh;
D.id = zeros(height(D), 1);

% Predict
clear y_hat
y_hat.full = lme_full.predict(D);
y_hat.no_hii = lme_no_hii.predict(D);
y_hat.no_hscl = lme_no_hscl.predict(D);
% Remove nan values
I_nan = myor({ ...
    isnan(y_hat.full), ...
    isnan(y_hat.no_hii), ...
    isnan(y_hat.full), ...
    isnan(y_hat.full), ...
    isnan(y)})>0;
y = y(~I_nan);
y_hat.full = y_hat.full(~I_nan);
y_hat.no_hscl = y_hat.no_hscl(~I_nan);
y_hat.no_hii = y_hat.no_hii(~I_nan);

clear metrics
metrics.full = util_get_predictionMetrics(y, y_hat.full);
metrics.no_hscl = util_get_predictionMetrics(y, y_hat.no_hscl);
metrics.no_hii = util_get_predictionMetrics(y, y_hat.no_hii);

[metrics.full, array2table([lme_full.Rsquared.Ordinary;nan;nan], "Var", "R-squared full")]
[metrics.no_hscl, array2table([lme_no_hscl.Rsquared.Ordinary;nan;nan], "Var", "R-squared no HSCL")]
[metrics.no_hii, array2table([lme_no_hii.Rsquared.Ordinary;nan;nan], "Var", "R-squared no HII")]
%%
clear T

% *** HII ***
T.hii_mean_t6 = computeCImeanEst( ...
    data.hii(data.t == 6), "2")
T.hii_mean_t7 = computeCImeanEst( ...
    data.hii(data.t == 7), "2")


T.prob_hii_geq1_t6 = computeCImeanEst( ...
    data.hii(data.t == 6) >= 1, "2", "nSig", 3) * 100
T.prob_hii_geq1_t7 = computeCImeanEst( ...
    data.hii(data.t == 7) >= 1, "2", "nSig", 3) * 100

T.std_hii_t7 = std(data.hii(data.t == 7), 'o')
T.std_hii_t7 = std(data.hii(data.t == 7), 'o')
T.one_std_above_mean_hii_t7 = T.std_hii_t7 + T.hii_mean_t6(2)
T.two_std_above_mean_hii_t7 = T.std_hii_t7 * 2 + T.hii_mean_t6(2)


% *** HSCL ***
T.hscl_mean_t6 = computeCImeanEst( ...
    data.hscl(data.t == 6), "2")
T.hscl_mean_t7 = computeCImeanEst( ...
    data.hscl(data.t == 7), "2")

T.prob_hscl_geq2_t6 = computeCImeanEst( ...
    data.hscl(data.t == 6) >= 2, "2", "nSig", 3) * 100
T.prob_hscl_geq2_t7 = computeCImeanEst( ...
    data.hscl(data.t == 7) >= 2, "2", "nSig", 3) * 100

T.std_hscl_t6 = std(data.hscl(data.t == 6), 'o')
T.std_hscl_t7 = std(data.hscl(data.t == 7), 'o')
T.one_std_above_mean_hscl_t7 = T.std_hscl_t7 + T.hscl_mean_t6(2)
T.two_std_above_mean_hscl_t7 = T.std_hscl_t7 * 2 + T.hscl_mean_t6(2)
T.corr_hii_t7 = util_correlation_with_ci(data.hii(data.t == 7), data.srh(data.t == 7))

% *** SRH ***
T.srh_mean_t6 = computeCImeanEst( ...
    data.srh(data.t == 6), "2", "nSig", 2)
T.srh_mean_t7 = computeCImeanEst( ...
    data.srh(data.t == 7), "2", "nSig", 2)

T.prob_srh_geq2_t6 = computeCImeanEst( ...
    data.srh(data.t == 6) >= 2, "2", "nSig", 3) * 100
T.prob_srh_geq2_t7 = computeCImeanEst( ...
    data.srh(data.t == 7) >= 2, "2", "nSig", 3) * 100

T.std_srh_t7 = std(data.srh(data.t == 7), 'o')
T.std_srh_t7 = std(data.srh(data.t == 7), 'o')
T.one_std_above_mean_srh_t7 = T.std_srh_t7 + T.srh_mean_t6(2)
T.one_std_above_mean_srh_t7 = T.std_srh_t7 + T.srh_mean_t6(2)

T.corr_hscl_t7 = util_correlation_with_ci(data.hscl(data.t == 7), data.srh(data.t == 7))

%% HII versus HSCL -- 2 std's above the mean
param = array2table( ...
    lme.Coefficients.Estimate, ...
    "RowNames", ...
    lme.Coefficients.Name)


x_base = T.prob_hscl_mean_t7(2);
x_hscl = T.two_std_above_mean_hscl_t7;
[x_hscl - x_base, x_hscl^2 - x_base^2, x_hscl^3 - x_base^3] * param{["hscl", "hscl^2", "hscl^3"], :}

x_base = T.prob_hii_mean_t7(2);
x_hii = T.two_std_above_mean_hii_t7;
[x_hii - x_base, x_hii^2 - x_base^2] * param{["hii", "hii^2"], :}

%% Correlation
