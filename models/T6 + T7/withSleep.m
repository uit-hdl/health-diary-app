%% Get data
if ~exist('TUdata', 'var')
    importLongData
end
theGreatVariableForge

% load train and test set:
load("mat_testAndTrainingSet.mat", "I_fit", "I_test")

% Main Model
modelData = data;

% ¤¤¤
fixedVars = {'age:age', 'education', ...
    'strokeOrHrtAtk', ...
    'sex', 'diabHba1c'};
decisionVars = {'PA', 'hii*hii', ...
    'bmi', 'hypert', 'smokeNow', ...
    'friendsSupp', 'hscl*hscl*hscl', 'insomnia'};
interactionPart = {'bmi:old', ...
    'old:insomnia23', 'old:PAf4i3', ...
    'insomnia23:PAf4i3', 'insomnia23:PAf23i23'};
% covariateNames = {fixedVars, decisionVars, interactionPart}
% whichVarsNotInDataset(modelData,covariateNames)

formula = getLinearModelFormula([fixedVars, decisionVars, interactionPart, ...
    {'(1|id)', '(1|t)'}], 'srh');

lme = fitglme(modelData(I_fit, :), formula);
T = compactLinModelPresentation(lme, {'Name', 'Estimate', 'pValue', 'sigLvl'}) %#ok<*NASGU>

% B = getModelDefaultCategories(lme, data)
close all
figure
plotCoeffLinearModel(lme, "rearrangeOrder", ...
    {["age^2", "hscl^2", "hii^2"], [1, 24, 20]}, ...
    "horizontalPlot", false)
title 'Main model T6-T7'

%% prediction on training set
D = modelData(I_fit, :);
y = D.srh;
D.id = zeros(height(D), 1);

y_hat = lme.predict(D);
I_nan = or(isnan(y_hat), isnan(y));
y = y(~I_nan);
y_hat = y_hat(~I_nan);

r = y_hat - y;
close all
subplot(121)
plot(normrnd(y, 0.01), y_hat, 'o', "color", color2triplet("grey"))
hold on
plotCIforEachCat(y, y_hat)
ylim([1, 4])

subplot(122)
plot(util_shakeCoordinates(y, 0.05), r, 'o', "color", color2triplet("grey"))
hold on
plotCIforEachCat(y, r)
ylim([-2, 2])
title("SRH vs residuals")
ylabel('residuals')
xlabel('SRH')
c_train = corr([y, y_hat])

n = numel(y);

% root mean square error:
R.metrics.withInsomnia = util_get_predictionMetrics(y, y_hat)

%% predict on test set:
y = modelData(I_test, :).SRH;
y_hat = lme.predict(modelData(I_test, :))
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
C = dataset2table(lme.Coefficients);
C.Properties.RowNames = C.Name;
C = C(:, "Estimate")

x = 0:0.1:4;
close all;
plot(x, C{"hscl", :}*x+C{"hscl^2", :}*x.^2+C{"hscl^3", :}*x.^3)

%%
C{"PA_f4i3", :} - C{"PA_f1", :}

%%
figure
plot(modelData.hscl, lme.residuals, 'o')
xlabel('hscl')
ylabel('residual')
yline(0)

%% Same model, but using PAfrq and PAint instead
% modelData = data(t>=6,:);
% fixedVars = {'ageG','liveWspouse','strokeOrHrtAtk','sex','diabHba1c'};
% decisionVars = {'bmi','hypert','smokeNow',...
%                 'friendsSupp','mentIll','insomnia'};
% interactionPart = {'PAfrq*PAint','bmi:old','smokeNow:old',...
%                    'PAf23i23:smokeNow','old:insomnia4','old:PA33',...
%                    'insomnia34:PA22','insomnia34:PA33','bmi34:PA22'};
%
% formula = getLinearModelFormula([fixedVars,decisionVars,interactionPart,...
%                                  {'(1|id)'}],'srh');
% close all
% lme2 = fitglme(modelData,formula);
% lme2.Coefficients
% T = compactLinModelPresentation(lme2,{'sigLvl'}) %#ok<*NASGU>
%
% B = getModelDefaultCategories(lme2,data)
% figure
% plotCoeffLinearModel(lme2)
% title 'Main model T6-T7'

%% Prediction
lme.predict

%% fit test model:
m67 = fitglme(data(t >= 6, :), 'srh ~  age + bmi + old:bmi + (1|id)');

%%

m67.Coefficients.Estimate
m67.CoefficientNames

k = k + 1;
T = data(k, :)
T.id = -1;
z = m67.predict(T)
X = getCovariateVector(m67.CoefficientNames, T);

X * m67.Coefficients.Estimate
