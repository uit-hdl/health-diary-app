function P = updateOptionalArgs(P,p)
% used to manage optional arguments more easily. P is a structure that
% contains the default parameter values, whith format P.(argName). p is
% an input parser object corresponding to the variables in P.
argNames = fieldnames(p.Results);
for i=1:numel(argNames)
    name = argNames{i};
    P.(name) = p.Results.(name);
end

end
