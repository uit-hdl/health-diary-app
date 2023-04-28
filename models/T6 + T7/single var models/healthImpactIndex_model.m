%% Get data
if ~exist('TUdata', 'var')
    importLongData
end
theGreatVariableForge

% Main Model
modelData = data(t >= 6, :);

lme = fitglme(modelData, 'srh ~ hii*hii + (1|id) + (1|t)');
T = compactLinModelPresentation(lme, {'Name', 'Estimate', 'pValue', 'sigLvl'}) %#ok<*NASGU>

% B = getModelDefaultCategories(lme, data)
% close all
% figure
% plotCoeffLinearModel(lme)
% title 'Main model T6-T7'

% findMissingVar = 1;
% if findMissingVar % use this code if error: unrecognized variables
%     whichVarsNotInDataset(data, {fixedVars, decisionVars, interactionPart})
% end

T

%%
figure
plot(modelData.hii, lme.residuals, 'o')
xlabel('hscl')
ylabel('residual')
yline(0)
%%
figure
x = util_shakeCoordinates(modelData.hii, 0.1);
y = util_shakeCoordinates(modelData.srh, 0.1);
plot(x, y, 'o')
xlabel('hscl')
ylabel('residual')
yline(0)


