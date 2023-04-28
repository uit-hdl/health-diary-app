function varNames = getVarNames(myTable)
% get names of the variables in a table
varNames = fieldnames(myTable);
varNames = varNames(1:end-3);
end