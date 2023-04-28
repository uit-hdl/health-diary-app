function modelFormula = getLinearModelFormula(inputNames,outputName,groupIntercept)
%% example
% inputNames = {'AGE_T7', 'SEX_T7', 'predMaxMurGrade'}
% outputName = 'AS'
%%
if nargin==2
    groupIntercept = false;
end
%%
n = numel(inputNames);
modelFormula = outputName;
for i=1:n
    if i==1
        relation = '~';
    else
        relation = '+';
    end
    modelFormula = sprintf('%s %s %s',modelFormula,relation,inputNames{i});
end

if groupIntercept
    modelFormula = strcat(modelFormula,'+ (1|id)');
end