% Script for displaying the model parameters in a Latex formatted table.
% Expects fitted model 'lme' to be a workspace variable. Produces a table
% 'T' with the parameters in a in latex code.

show_sig_stars = false;

names_ordering_array = get_array_for_renaming_and_reordering_variables()
coeff_table = compactLinModelPresentation( ...
    lme, ...
    {'Name', 'Estimate', 'Lower', 'Upper', 'sigLvl'});
coeff_table(1, :) = [];

ix_reorder = reorder_according_to_list( ...
    coeff_table.Properties.RowNames, ...
    names_ordering_array(:, 1));

coeff_table = coeff_table(ix_reorder, :);

coefficient_names_Latex = rename_rows_by_list( ...
    coeff_table, ...
    names_ordering_array);

n_table = height(coefficient_names_Latex);
T = cell(n_table, 1);
for i=1:n_table
    if show_sig_stars
        sig_stars = coefficient_names_Latex.sigLvl(i);
            if contains(sig_stars{:}, ' ')
                 sig_stars{:} = '';
            else
                sig_stars = sprintf("(%s)", sig_stars{:});
            end
    else
        sig_stars = {''};
    end

    T{i} = sprintf('%.2g%s (%.2g, %.2g)', ...
        coefficient_names_Latex.Estimate(i), ...
        sig_stars{:}, ...
        coefficient_names_Latex.Lower(i), ...
        coefficient_names_Latex.Upper(i));
end

T = array2table(T, ...
    "RowNames", coefficient_names_Latex.Properties.RowNames, ...
    "VariableNames", "Coefficient estimates (95\% CI)")

% Print Latex formatted table to console
table2latex(T, 'latex_formatted_parameter_table')

