function T = getModelDefaultCategories(lm,Tfit)
% Takes a model lm and the table Tfit (used to fit the model) and returns
% the default categories of lm.
%%
Xnames = lm.PredictorNames;
n_pred = numel(Xnames);
baseLvls = cell(n_pred,2);
for i=1:n_pred
    X = Tfit.(Xnames{i});
    if iscategorical(X) || islogical(X)
        possibleLvls = categorical(myunique(X));
    else
        possibleLvls = categorical(nan);
    end
    baseLvls{i,1} = Xnames{i};
    baseLvls{i,2} = possibleLvls(1);
end

T = cell2table(baseLvls(:,2),'RowNames',baseLvls(:,1),'Var',{'BaseLine'});

end