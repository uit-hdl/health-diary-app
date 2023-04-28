function T = renameVars(T,vars2rename,newNames)
% takes a table T, and renames variables in vars2rename to names in
% newNames

for i=1:length(vars2rename)
    if iscell(vars2rename)
        oldName = vars2rename{i};
        newName = newNames{i};
    else
        oldName = vars2rename;
        newName = newNames;
    end
    
    Ivar = T.Properties.VariableNames==oldName;
    
    if isstring(newName)
        newName = convertStringsToChars(newName);
    end
    
    T.Properties.VariableNames{Ivar} = newName;
end

end