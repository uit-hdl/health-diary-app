%% Get data
if ~exist('TUdata', 'var')
    importLongData
end
theGreatVariableForge

%% Main Model
modelData = data(t >= 6, :);

lme = fitglme(modelData, 'srh ~ PAfrq*PAint');
T = compactLinModelPresentation(lme, {'Name', 'Estimate', 'pValue', 'sigLvl'}) %#ok<*NASGU>

close all
B = getModelDefaultCategories(lme, data)
figure
subplot(1, 2, 1)
plotCoeffLinearModel(lme)
title 'Main model T6-T7'

lme = fitglme(modelData(modelData.PAfrq == "3", :), 'srh ~ PAint');
T = compactLinModelPresentation(lme, {'Name', 'Estimate', 'pValue', 'sigLvl'}) %#ok<*NASGU>

B = getModelDefaultCategories(lme, data)
subplot(1, 2, 2)
plotCoeffLinearModel(lme)
title 'Main model T6-T7'

%% create model of SRH ~ PAint for each PAfrequency subgroup
close all
category_names = ["PA 1 time/week", "PA 2-3 times/week", "PA approx. each day"]
for k = 2:4
    frqlvl = string(k);
    lme = fitglme(modelData(modelData.PAfrq == frqlvl, :), ...
        'srh ~ age:age + sex + PAint + (1|id) + (1|t)');
    T = compactLinModelPresentation(lme, ...
        {'Name', 'Estimate', 'pValue', 'sigLvl'}) %#ok<*NASGU>

    B = getModelDefaultCategories(lme, data)
    subplot(1, 3, k-1)
    plotCoeffLinearModel(lme, "coeff2plot", ["PAint_1", "PAint_3"])
    ylim([-0.45, 0.4])
    title(sprintf("PA frequency lvl %g", k))
end

%% create model of SRH ~ PAint for each PAfrequency subgroup, full model 

close all
for k = 2:4
    frqlvl = string(k);
    fixedVars = {'age:age', 'education', ...
        'strokeOrHrtAtk', 'sex', 'diabHba1c'};
    decisionVars = {'PAint', ...
        'bmi', 'hypert', 'smokeNow', ...
        'friendsSupp', 'hscl^3', 'hii^2', 'insomnia'};
    formula = getLinearModelFormula([fixedVars, decisionVars, ...
        "PAint", "(1|id)", "(1|t)"], "srh");
    lme = fitglme(modelData(modelData.PAfrq == frqlvl, :), formula);
    T = compactLinModelPresentation(lme, {'Name', 'Estimate', 'pValue', 'sigLvl'}) %#ok<*NASGU>

    B = getModelDefaultCategories(lme, data)
    subplot(1, 3, k-1)
    plotCoeffLinearModel(lme, "coeff2display", ["PAint_1", "PAint_3"])
    if k == 2
        ylabel("SRH")
    end
    ylim([-0.45, 0.4])
    if k == 2
        str = "1/week";
    elseif k == 3
        str = "2-3/week";
    else
        str = "approx. every day";
    end

    title(str)
end

hold on
a = plot(nan, nan, 'o', 'MarkerFaceColor', color2triplet('lime'), 'MarkerEdgeColor', 'k')
b = plot(nan, nan, 'o', 'MarkerFaceColor', color2triplet('yellow'), 'MarkerEdgeColor', 'k')
c = plot(nan, nan, 'o', 'MarkerFaceColor', color2triplet('orange'), 'MarkerEdgeColor', 'k')
d = plot(nan, nan, 'o', 'MarkerFaceColor', color2triplet('red'), 'MarkerEdgeColor', 'k')
legend([a; b; c; d], "p>=0.1", "p<0.1", "p<0.05", "p<0.001")
