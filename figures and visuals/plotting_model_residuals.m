%% Get data
if ~exist('TUdata', 'var')
    importLongData
end
theGreatVariableForge


load("survey_id_overlap.mat", "ID_overlap")
% extract a test set from T7 consisting of participants who only
% participated in T7:
N_test = 200;
id_T7_only = setdiff(ID_overlap.id{4, 4}, ID_overlap.id{3, 3});
id_T7_test = randsample(id_T7_only, N_test);
I_test = and(findInd(data.id, id_T7_test), data.t == 7);
I_fit = and(~I_test, data.t >= 6);
% Main Model
modelData = data(I_fit, :);
modelData = modelData(~modelData.PA_nonsense, :)

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

lme = fitglme(modelData, formula);
T = compactLinModelPresentation(lme, {'Name', 'Estimate', 'pValue', 'sigLvl'}) %#ok<*NASGU>

% B = getModelDefaultCategories(lme, data)
close all
figure
plotCoeffLinearModel(lme, "rearrangeOrder", ...
    {["age^2", "hscl^2", "hii^2"], [1, 24, 20]}, ...
    "horizontalPlot", false)
title 'Main model T6-T7'

%% investigate residuals
r = lme.residuals;
X = lme.designMatrix;
x_names = lme.CoefficientNames';
i_x = x_names == "PA_f3i3";
X(:, i_x);

close all
plot(normrnd(X(:, i_x), 0.05), r, 'o')


