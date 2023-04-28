function T = compactLinModelPresentation(lm, vars, nsigdig)
% takes a linear mode lm and returns a more print friendly table, showing
% only the parameter names, estimates, and the p-value levels as indicated
% by star notation. If a second argument "vars" is provided, then the
% returned table T contains the variables in vars.

% vars can contain (in any desired order) the following:
% vars = {'Name','Estimate','sigLvl','pValue','Lower','Upper','SE','tStat'};

%% example code:
% vars = {'Name','Estimate','sigLvl'};
if nargin == 1
    vars = {'Name', 'Estimate', 'sigLvl', 'pValue'};
    nsigdig = [];
elseif nargin == 2
    nsigdig = [];
end

if isempty(vars)
    vars = {'Name', 'Estimate', 'sigLvl', 'pValue'};
end

%%

sigLvl = getPvalStars(lm.Coefficients.pValue);
T = [dataset2table(lm.Coefficients), table(sigLvl)];
T = subtable(T, vars);

if ~isempty(nsigdig)
    % round all values to requested precision:
    T.Estimate = round(T.Estimate, nsigdig);
end

T.Properties.RowNames = T{:, 1};
T = removevars(T, "Name");
end