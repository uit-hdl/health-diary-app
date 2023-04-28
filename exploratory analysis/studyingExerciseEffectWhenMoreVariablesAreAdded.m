% Question: How is the apparent effect of exercise influence by the
% inclusion of other covariates?

theGreatVariableForge

%% train models
clear x
x{1} = {'age', 'PAleisure'};
x{2} = {'age', 'PAleisure', 'mentIll'};
x{3} = {'age', 'PAleisure', 'mentIll', 'bmi'};
x{4} = {'age', 'PAleisure', 'mentIll', 'bmi', 'diabHba1c'};
x{5} = {'age', 'PAleisure', 'mentIll', 'bmi', 'hba1c'};
x{6} = {'age', 'PAleisure', 'mentIll', 'bmi', 'hba1c', 'restHR'};
x{7} = {'age', 'PAleisure', 'mentIll', 'bmi', 'hba1c', 'restHR', 'insomnia'};
x{8} = {'age', 'PAleisure', 'mentIll', 'bmi', 'hba1c', 'restHR', 'insomnia', 'hypert'};
x{9} = {'age', 'PAleisure', 'mentIll', 'bmi', 'hba1c', 'restHR', 'insomnia', 'hypert', 'strokeOrHrtAtk'}
x{10} = [x{9}, 'lipid'];
x{10} = [x{9}, 'lipid'];
% formula1 = getLinearModelFormula(covariates, 'srh', true);
lme1 = fitglme(data(t >= 6, :), getLinearModelFormula(x{1}, 'srh', true));
lme2 = fitglme(data(t >= 6, :), getLinearModelFormula(x{2}, 'srh', true));
lme3 = fitglme(data(t >= 6, :), getLinearModelFormula(x{3}, 'srh', true));
lme4 = fitglme(data(t >= 6, :), getLinearModelFormula(x{4}, 'srh', true));
lme5 = fitglme(data(t >= 6, :), getLinearModelFormula(x{5}, 'srh', true));
lme6 = fitglme(data(t >= 6, :), getLinearModelFormula(x{6}, 'srh', true));
lme7 = fitglme(data(t >= 6, :), getLinearModelFormula(x{7}, 'srh', true));
lme8 = fitglme(data(t >= 6, :), getLinearModelFormula(x{8}, 'srh', true));
lme9 = fitglme(data(t >= 6, :), getLinearModelFormula(x{9}, 'srh', true));
lme10 = fitglme(data(t >= 6, :), getLinearModelFormula(x{10}, 'srh', true));

%%
close all
figure
subplot(221)
plotCoeffLinearModel(lme1, "coeff2disp", ["PAleisure_1" "PAleisure_3"])
ylim([-0.4, 0.3])
title 'Main model'
lmArray = {lme1, lme2, lme3, lme4, lme5, lme6, lme7, lme8, lme9, lme10};
coeffNames = {'PAleisure_1', 'PAleisure_3', 'mentIll', 'bmi_4', 'insomnia_4'};
T = coeffEstTableForMultipleModels(lmArray, coeffNames, x)


D = T{:, "PAleisure_3"} - T{:, "PAleisure_1"};
subplot(222)
plotCoeffLinearModel(lme10, "coeff2display", ["PAleisure_1" "PAleisure_3"])
ylim([-0.4, 0.3])

subplot(2,2,[3,4])
a = plot(D, '-bs', "MarkerFaceColor", "k")
ylim([0, 0.6])



