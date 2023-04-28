function [Tcorr, pVal] = correlationTable(T, varargin)
% Takes a table T and produces a table with correlations between each pair
% of variables in 'variables'.
% X = zeros(height(T), numel(variables));
P.variables = [];
P.round2 = [];
P.showPercentage = false;
P.calcPval = false;
P.displayPvalues = false;


p = inputParser;
addOptional(p, "variables", P.variables)
addOptional(p, "round2", P.round2)
addOptional(p, "showPercentage", P.showPercentage)
addOptional(p, "calcPval", P.calcPval)
addOptional(p, "displayPvalues", P.displayPvalues)
parse(p, varargin{:})
P = updateOptionalArgs(P, p);

if isempty(P.variables)
    P.variables = T.Properties.VariableNames;
end

if iscell(P.variables)
    P.variables = string(P.variables);
end

% extract subtable:
T = T(:, P.variables);
% convert to double:
T = util_convert_between_catAndString(T, ...
    ["string", "categorical"], ...
    "double");

if P.calcPval
    [X, pVal] = mycorr(table2array(T), [], true);
else
    X = mycorr(table2array(T));
    pVal = [];
end

if ~isempty(P.round2)
    if P.showPercentage
        X = round(X*100, P.round2);
    else
        X = round(X, P.round2);
    end
end

Tcorr = array2table(X, 'V', P.variables, 'R', P.variables);

if P.displayPvalues
    Nrows = height(Tcorr);
    Ncols = width(Tcorr);
    T = cell(Nrows, Ncols);

    for i = 1:Nrows
        for j = 1:Ncols
            stars = getPvalStars(pVal(i, j));
            if contains(stars, ' ')
                T{i, j} = sprintf('%g', Tcorr{i, j});
            else
                T{i, j} = sprintf('%g (%s)', Tcorr{i, j}, stars{:});
            end
        end
    end

    Tcorr = cell2table(T, 'Row', Tcorr.Properties.RowNames, ...
        'Var', Tcorr.Properties.VariableNames);
end

end