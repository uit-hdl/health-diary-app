theGreatVariableForge

%% Age and BMI
clear M
modelData = data(data.t >= 6, :);
M{1} = fitglme(modelData, 'srh ~ bmi + (1|id)');
M{2} = fitglme(modelData, 'srh ~ bmiCont^3 + (1|id)');
M{3} = fitglme(modelData, 'srh ~ age*age + bmiCont^3 + age*bmiCont + (1|id)');
M{4} = fitglme(modelData, 'srh ~ age*age + bmiCont^3 + age^2*bmiCont + (1|id)');
M{5} = fitglme(modelData, 'srh ~ age*age + bmiCont^3 + age^3*bmiCont + (1|id)');
M{6} = fitglme(modelData, 'srh ~ age*age + bmiCont^3 + age^2*bmiCont + PA +  (1|id)');

%% Present Models
compactLinModelPresentation(M{1}, {'Name', 'Estimate', 'sigLvl', 'pValue'})
compactLinModelPresentation(M{2}, {'Name', 'Estimate', 'sigLvl', 'pValue'})
compactLinModelPresentation(M{3}, {'Name', 'Estimate', 'sigLvl', 'pValue'})
compactLinModelPresentation(M{4}, {'Name', 'Estimate', 'sigLvl', 'pValue'})
compactLinModelPresentation(M{5}, {'Name', 'Estimate', 'sigLvl', 'pValue'})
compactLinModelPresentation(M{6}, {'Name', 'Estimate', 'sigLvl', 'pValue'})

close all
figure
plotLinearModels(M)

figure
subplot(3, 3, 1)
plotCoeffLinearModel(M{1})
title(sprintf('Rsqr = %g', M{1}.Rsquared.Ordinary))
subplot(3, 3, 2)
plotCoeffLinearModel(M{2})
title(sprintf('Rsqr = %g', M{2}.Rsquared.Ordinary))
subplot(3, 3, 3)
plotCoeffLinearModel(M{3})
title(sprintf('Rsqr = %g', M{3}.Rsquared.Ordinary))
subplot(3, 3, 4)
plotCoeffLinearModel(M{4})
title(sprintf('Rsqr = %g', M{4}.Rsquared.Ordinary))
subplot(3, 3, 5)
plotCoeffLinearModel(M{5})
title(sprintf('Rsqr = %g; BIC = %g', M{5}.Rsquared.Ordinary, M{5}.ModelCriterion.BIC))
subplot(3, 3, 6)
plotCoeffLinearModel(M{6})
title(sprintf('Rsqr = %g; BIC = %g', M{6}.Rsquared.Ordinary, M{6}.ModelCriterion.BIC))
subplot(3, 3, 7)
c = M{2}.Coefficients.Estimate;
xx = 15:0.1:40;
yy = [ones(1, numel(xx)); xx; xx.^2; xx.^3]' * c
plot(xx, yy)
hold on
plotBinnedEstimates(modelData.bmiCont, modelData.srh, [-inf, 18, 19, 20, 22, 26, 30, 34, 38, inf])
title 'theoretical E(SRH|BMI)'
