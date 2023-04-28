function x = renameAndRelevel(x,newNames,newNameOrder)
% takes a categorical vector x and renames and reorders variables. If x is
% numeric, then it gets converted to categorical. If only renaming and 
if nargin==1
    newNames     = [];
    newNameOrder = [];
elseif nargin==2
    newNameOrder = newNames;
end

% if numeric, then convert to type categorical:
if isnumeric(x)
    x = categorical(x);
end

if isempty(newNames)
    newNames = categories(x);
end

if isempty(newNameOrder)
    newNameOrder = newNames;
end

x = renamecats(x,newNames);
if ~isequal(newNames,newNameOrder)
    x = categorical(x,newNameOrder,'Ordinal',true);
end

end