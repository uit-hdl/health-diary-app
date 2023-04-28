function subT = subtable(motherTable,namesSubtable,rows)
% Allows you to form a subtable of a larger table, consisting
% of the names in the string array namesSubtable.
if nargin==2
    rows = [];
end

subT = table;
for i=1:length(namesSubtable)
    subT = [subT, table(motherTable.(namesSubtable{i}),'v',namesSubtable(i))]; %#ok<*AGROW>
end

if not(isempty(rows))
    subT = subT(rows,:);
end

end