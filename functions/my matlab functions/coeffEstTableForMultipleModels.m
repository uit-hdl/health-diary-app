function T = coeffEstTableForMultipleModels(lmArray, coeffNames, modelSpecif)
% takes an array of linear model lmArray and an array of coefficient names (ex.
% {'physact_1','physact_3'}) and returns a table T which shows the
% parameter estimates for the variables in coeffNames. modelSpecif is an
% optional argument that specifies which covariates where included in each
% model, and has the form of a cell array of string arrays.

%% useful to...
% get an overwiev over a number of linear models, and compare the variable
% coefficients between the models.

%% code
if nargin == 2
    modelSpecif = [];
end

Ncoeff = numel(coeffNames);
Nmodels = numel(lmArray);

if ~isempty(modelSpecif)
    T = array2table(nan(Nmodels, Ncoeff+1), 'v', [coeffNames, 'modelSpecif']);
    T = convertvars(T, {'modelSpecif'}, 'string');
else
    T = array2table(nan(Nmodels, Ncoeff), 'v', coeffNames);
end

modelNames = cell(Nmodels, 1);
for i = 1:Nmodels
    lm = lmArray{i};
    namesModel_i = string(lm.CoefficientNames);

    for j = 1:Ncoeff
        I = namesModel_i == string(coeffNames{j});
        val = lm.Coefficients.Estimate(I);
        if ~isempty(val)
            T{i, j} = val;
        end
    end
    modelNames{i} = sprintf('model %g', i);

    if ~isempty(modelSpecif)
        S = modelSpecif{i}{1};
        for k = 1:numel(modelSpecif{i}) - 1
            S = sprintf('%s %s', S, modelSpecif{i}{k + 1});
        end
        T.modelSpecif(i) = string(S);
    end
end

T.Properties.RowNames = modelNames;

end
