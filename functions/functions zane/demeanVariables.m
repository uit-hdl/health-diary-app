function Xdemeaned = demeanVariables(T,groupingVar)
% subtracts group-means for variables in table T, where the groups are
% given by the variable groupingVar. Assumes that elements of T are
% numerical. If X is array, then the first column is assumed to contain
% group identifiers.
%%
if istable(T)
    Xdemeaned = table2array(removevars(T,groupingVar));
    G = myunique(T.(groupingVar));
else
    Xdemeaned = T(:,2:end);
    G = myunique(T(:,1));
end

for i=1:length(G)
    if istable(T)
        I = T.(groupingVar)==G(i);
    else
        I = T(:,1)==G(i);
    end
    Xdemeaned(I,:) = Xdemeaned(I,:) - mean(Xdemeaned(I,:));
end

end