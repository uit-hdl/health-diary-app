function DiffArray = whichVarsNotInDataset(dataframe,nameArrays)
% takes a dataframe, and an array of character arrays, and returns an array
% contianing the names in arrays of nameArrays that are not in dataframe.
% Used primarily when fitting linear models to check if the requested
% variables are in the data frame containing the regression variables.

%% example input:                            xxx
% nameArrays = {{'Xvar1','Xvar2'},{'Zvar1','Zvar2','Zvar3'},{'Xvar1:Xvar2','Xvar2:Zvar3'}};
% dataframe = array2table([1.2,1.1,2.3,2.6],'v',{'Xvar1','Xvar2','Zvar1','Zvar3'})

%% code
if ischar(nameArrays{1}) 
    % in case one  array is given in the form {'name1'}.
    nameArrays = {nameArrays};
end

Narrays = numel(nameArrays);

% first, split up the interaction terms which have the form var1:var2
V = {};
for i=1:Narrays
    array_i = nameArrays{i};
    n_i = numel(array_i);
    J = [];
    vars = {};
    for j=1:n_i
        % find names in string:
        J = [J,strfind(array_i{j},':')];
        if numel(J)>0
            InteractionVars = split(array_i{j},':');
            vars = [vars,InteractionVars'];
        else
            vars = [vars,array_i{j}]; %#ok<*AGROW>
        end
        
    end
    V = [V,vars];
end
V = unique(V);

DiffArray = setdiff(V,dataframe.Properties.VariableNames);

end