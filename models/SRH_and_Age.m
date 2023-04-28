

%% Fit categorical, linear, and polynomial models
modelData = data(data.t>=6,:);
modelData.ageG = mycategorical(discretize(modelData.age, [3,4,5,6,7,8,9,10]));
Mgroup = fitglme(modelData,'srh ~ ageG + (1|id)');
Mlinear = fitglme(modelData,'srh ~ age + (1|id)');
Mpoly   = fitglme(modelData,'srh ~ age*age + (1|id)');

%% plot Categorical Model
close all
plotCoeffLinearModel(Mgroup)
% for sure there is a trend of accelarating decline with age
%%
clear T
Nplot = 50;
T = table(linspace(3, 9.5, Nplot)',zeros(Nplot,1),'v',{'age','id'} );

close all
subplot(131)
    plot(T.age, Mlinear.predict(T))
    hold on
    plot(T.age, Mpoly.predict(T))
    title(sprintf('linear vs polynomial model. \nRsqr=%g and %g',...
               round(Mlinear.Rsquared.Ordinary,4), round(Mpoly.Rsquared.Ordinary,4)))
subplot(132)
    lmResLin = fitlm(modelData.age, Mlinear.residuals);
%     lmResPoly = fitlm(modelData.age, Mpoly.residuals);
    plot(modelData.age, lmResLin.Fitted, '*')
%     hold on
%     plot(modelData.age, lmResPoly.Fitted, '*')


%% PLot residuals against explanatory variable 
close all
lmRes = fitlm(modelData.age, Mlinear.residuals)
plot(modelData.age, Mlinear.residuals,'*')


