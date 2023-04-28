function Table = util_convert_between_catAndString(Table, ...
    from_type, ...
    to_type)
% converts all variables of specified type to a new specified type.
%% example input
% from_type = ["categorical", "double"];
% t_type = "string";
% Table = T;
%%
names = Table.Properties.VariableNames;
N_var = numel(names);

if ismember("numeric", from_type) || to_type == "numeric"
    error("use keyword double instead of numeric")
end


for i = 1:N_var
    vartype = string(class(Table{:, i}));
    

    if ismember(vartype, from_type)

        if vartype == "categorical" && to_type == "double"
            Table = convertvars(Table, names{i}, "string");
            Table = convertvars(Table, names{i}, "double");
        else
            Table = convertvars(Table, names{i}, to_type);
        end

    end
Table

end
