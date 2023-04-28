function modelFormula = getLinearModelFormula(inputNames,outputName,groupIntercepts)
%% example
% inputNames = {'AGE_T7', 'SEX_T7', 'predMaxMurGrade'}
% outputName = 'AS'
%%
if nargin==2
    groupIntercepts = false;
end

n = numel(inputNames);

if iscell(outputName)
    modelFormula = outputName{1};
else
    modelFormula = outputName;
end

for i=1:n
    if i==1
        relation = '~';
    else
        relation = '+';
    end
    modelFormula = sprintf('%s %s %s',modelFormula,relation,inputNames{i});
end
if groupIntercepts
    modelFormula = strcat(modelFormula,'+ (1|id)');
end