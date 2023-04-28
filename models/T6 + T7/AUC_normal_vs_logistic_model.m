
load("modelJune30.mat")
load("mat_testAndTrainingSet.mat", "I_fit", "I_test")


thr_srh = 3;

I_subset = I_test;
D = modelData(I_subset, :);
y = D.srh;
D.id = zeros(height(D), 1);

y_predict = lme.predict(D);
y_predict_logistic = lme_logistic.predict(D);

y_good = D.srh >= thr_srh;

I_nan = or(isnan(y_predict), isnan(y));

y_predict(I_nan) = [];
y_predict_logistic(I_nan) = [];
y(I_nan) = [];
y_good(I_nan) = [];
%% 
close all
subplot(2,1,1)
utils_getAUCandPlotROC(y_predict, y_good, 'plotFigure', true)
subplot(2,1,2)
utils_getAUCandPlotROC(y_predict_logistic, y_good, 'plotFigure', true)
%%
util_correlation_with_ci(y_predict, y)
util_correlation_with_ci(y_predict_logistic, y)
