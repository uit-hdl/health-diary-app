theGreatVariableForge
%% data preparation
modelData = data(data.t>=6,:);
modelData.hscl = modelData.hscl;
p = 0.5;
modelData.hsclPow = modelData.hscl.^p;
modelData.logHSCL = log(modelData.hscl);
modelData.hsclG = mycategorical(discretize(modelData.hscl,0:0.5:3.0));
%% Model using discretized HSCL as input:
lmeG = fitglme(modelData,'srh ~ hsclG + (1|id)');
close all
plotCoeffLinearModel(lmeG)
%%
V = {'hscl','hscl:hscl'};
formula = getLinearModelFormula(V,'srh',true);
lmePol = fitglme(modelData,formula);
BIC = lmePow.ModelCriterion.BIC;
T = compactLinModelPresentation(lmePol,{'sigLvl'}) %#ok<*NASGU>

close all
xx = 0:.01:4;
figure
subplot(131)
    plotCoeffLinearModel(lmePol)
subplot(132)
    c = lmePol.Coefficients.Estimate;
    plot(xx, c(1) + c(2)*xx + c(3)*xx.*2)
    hold on
    plot(xx, c(1) + c(2)*xx)
subplot(133)
    plot(modelData.(V{1}),lmePol.residuals,'*')
    lm = fitlm([modelData.(V{1}), modelData.(V{1}).^2], lmePol.residuals);
    hold on
    plot(xx,lm.feval([xx;xx.^2]'))
    xlabel 'hscl'
    ylabel 'residuals'
    title(sprintf('BIC=%g, Rsqr=%g',BIC,round(lmePol.Rsquared.Ordinary,3)))

%%
V = {'hsclPow'};
formula = getLinearModelFormula(V,'srh',true);
lmePow = fitglme(modelData,formula);
BIC = lmePow.ModelCriterion.BIC;
T = compactLinModelPresentation(lmePow,{'sigLvl'}) %#ok<*NASGU>

close all
xx = 0:.01:5.^p;
figure
subplot(311)
    % plot model coefficients:
    plotCoeffLinearModel(lmePow)
subplot(312)
    % plot expected value model:
    c = lmePow.Coefficients.Estimate;
    plot(xx, c(1) + c(2)*xx)
subplot(313)
    % plot residuals against explanatory variable:
    plot(modelData.hscl, lmePow.residuals, '*')
    lm = fitlm(modelData.hscl, lmePow.residuals);
    hold on
    plot(xx,lm.feval([xx;xx.^2]'))
    
    xlabel 'hscl'
    ylabel 'residuals'
    title(sprintf('BIC=%g, Rsqr=%g', BIC, round(lmePow.Rsquared.Ordinary,3)))

%% Conclusions
% the second degree polynomial model provides the best fit

