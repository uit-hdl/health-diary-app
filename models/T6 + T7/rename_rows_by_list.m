function param_table = rename_rows_by_list(param_table, names_ordering_array)
% Remanes the row names of param_table according to a renaming array
% names_ordering_array which acts as a map between the old names and the
% new names.
x_names = names_ordering_array(:, 1);
y_names = names_ordering_array(:, 2);

n_rows_table = height(param_table);
new_names = strings(1, n_rows_table);
for i=1:n_rows_table
    new_names(i) = y_names(x_names==param_table.Properties.RowNames{i});
end

param_table.Properties.RowNames = new_names;

end