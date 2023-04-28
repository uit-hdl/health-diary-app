% Used in conjunction with plotting function. Takes linear-model parameter
% table param_table and returns a table with confidence intervals,
% p-values, and effect estimates according to a specified order. Presents
% effects of HII and HSCL at sample values relative to a baseline of 0.

% Put relevant param_table info into a table
clear param_table
names = string(lme.Coefficients.Name(2:end, :));
param_table.coef = lme.Coefficients.Estimate(2:end, :);
param_table.ci_lower = lme.Coefficients.Upper(2:end, :);
param_table.ci_upper = lme.Coefficients.Lower(2:end, :);
param_table.p_values = lme.Coefficients.pValue(2:end, :);
param_table = struct2table(param_table, "RowNames", names);

% Get covariance matrix for parameter estimates
V = array2table( ...
    lme.CoefficientCovariance(2:end, 2:end), ...
    "RowNames", names, ...
    "VariableNames", names ...
    );
% Define power difference function
power_diff = @(x_sample, x_base, p) x_sample^p - x_base^p;


% *** Age ***
% Base age is 30 years
x_age_base = 3;
x_age_sample = [5, 7];
n_age_lvls = numel(x_age_sample);
clear effect_age
effect_age.coef = zeros(n_age_lvls, 1);
effect_age.ci_lower = zeros(n_age_lvls, 1);
effect_age.ci_upper = zeros(n_age_lvls, 1);
effect_age.p_values = zeros(n_age_lvls, 1);
% Get subset of covariance matrix
V_sub = V{"age^2", "age^2"};
for i = 1:n_age_lvls
    % Compute power differences
    power_diffs = [; ...
        power_diff(x_age_sample(i), x_age_base, 2); ...
        ];
    % Compute standard deviation of estimator
    SD_effect = sqrt(power_diffs'*V_sub*power_diffs);
    % Estimate effect of changing x from x1 to x2
    effect = param_table{"age^2", "coef"} * power_diffs(1);
    % Compute confidence interval of effect
    effect_age.coef(i, :) = effect;
    effect_age.ci_lower(i, :) = effect_age.coef(i, :) - SD_effect * 1.96;
    effect_age.ci_upper(i, :) = effect_age.coef(i, :) + SD_effect * 1.96;
    effect_age.p_values(i, :) = 2 * (1 - normcdf(abs(effect)/SD_effect));
end

effect_age = struct2table( ...
    effect_age, ...
    "RowNames", ["age=50", "age=70"]);

% *** Exercise ***
clear effect_pa
effect_pa = get_PA_effects_relative_to_ref_group(lme, "PA_f1i2", "PA_f1i1")
effect_pa = [; ...
    effect_pa; ...
    get_PA_effects_relative_to_ref_group(lme, "PA_f1i3", "PA_f1i1"); ...
    ]
for frq = 2:4
    for int = 1:3
        PA_group = sprintf("PA_f%gi%g", frq, int);
        effect_pa = [; ...
            effect_pa; ...
            get_PA_effects_relative_to_ref_group(lme, PA_group, "PA_f1i1"); ...
            ];
    end
end

% *** HSCL ***
x_hscl_base = 1;
x_hscl_sample = [2, 3, 4];
n_hscl_lvls = numel(x_hscl_sample);
clear effect_hscl
effect_hscl.coef = zeros(n_hscl_lvls, 1);
effect_hscl.ci_lower = zeros(n_hscl_lvls, 1);
effect_hscl.ci_upper = zeros(n_hscl_lvls, 1);
effect_hscl.p_values = zeros(n_hscl_lvls, 1);
% Get subset of covariance matrix
V_sub = V{["hscl", "hscl^2", "hscl^3"], ["hscl", "hscl^2", "hscl^3"]}; %#ok<*USENS>
for i = 1:n_hscl_lvls
    % Compute power differences
    power_diffs = [; ...
        power_diff(x_hscl_sample(i), x_hscl_base, 1); ...
        power_diff(x_hscl_sample(i), x_hscl_base, 2); ...
        power_diff(x_hscl_sample(i), x_hscl_base, 3); ...
        ];
    % Compute standard deviation of estimator
    SD_effect = sqrt(power_diffs'*V_sub*power_diffs);
    % Estimate effect of changing x from x1 to x2
    effect = ...
        param_table{"hscl", "coef"} * power_diffs(1) + ...
        param_table{"hscl^2", "coef"} * power_diffs(2) + ...
        param_table{"hscl^3", "coef"} * power_diffs(3);
    % Compute confidence interval of effect
    effect_hscl.coef(i, :) = effect;
    effect_hscl.ci_lower(i, :) = effect_hscl.coef(i, :) - SD_effect * 1.96;
    effect_hscl.ci_upper(i, :) = effect_hscl.coef(i, :) + SD_effect * 1.96;
    effect_hscl.p_values(i, :) = 2 * (1 - normcdf(abs(effect)/SD_effect));
end
% Convert to table
effect_hscl = struct2table( ...
    effect_hscl, ...
    "RowNames", ["HSCL=2", "HSCL=3", "HSCL=4"]);


% *** HII ***
x_hii_base = 0;
x_hii_sample = [2, 4, 6];
n_hii_lvls = numel(x_hii_sample);
clear effect_hii
effect_hii.coef = zeros(n_hii_lvls, 1);
effect_hii.ci_lower = zeros(n_hii_lvls, 1);
effect_hii.ci_upper = zeros(n_hii_lvls, 1);
effect_hii.p_values = zeros(n_hii_lvls, 1);
% Get subset of covariance matrix
V_sub = V{["hii", "hii^2"], ["hii", "hii^2"]};
for i = 1:n_hii_lvls
    % Compute power differences
    power_diffs = [; ...
        power_diff(x_hii_sample(i), x_hii_base, 1); ...
        power_diff(x_hii_sample(i), x_hii_base, 2); ...
        ];
    % Compute standard deviation of estimator
    SD_effect = sqrt(power_diffs'*V_sub*power_diffs);
    % Estimate effect of changing x from x1 to x2
    effect = ...
        param_table{"hii", "coef"} * power_diffs(1) + ...
        param_table{"hii^2", "coef"} * power_diffs(2);
    % Compute confidence interval of effect
    effect_hii.coef(i, :) = effect;
    effect_hii.ci_lower(i, :) = effect_hii.coef(i, :) - SD_effect * 1.96;
    effect_hii.ci_upper(i, :) = effect_hii.coef(i, :) + SD_effect * 1.96;
    effect_hii.p_values(i, :) = 2 * (1 - normcdf(abs(effect)/SD_effect));
end

effect_hii = struct2table( ...
    effect_hii, ...
    "RowNames", ["HII=2", "HII=4", "HII=6"]);


% *** Insert new effects and reorder table ***
% Delete rows
param_table([ ...
    "age^2", ...
    "bmi_1", ...
    "hscl", "hscl^2", "hscl^3", ...
    "hii", "hii^2", ...
    "PA_f1i1", "PA_f1i2","PA_f1i3", ...
    "PA_f2i1","PA_f2i2","PA_f2i3", ...
    "PA_f3i1","PA_f3i3", ...
    "PA_f4i1","PA_f4i2","PA_f4i3", ...
    "old_1:bmi_1"], :) = [];
% Add rows
param_table = [param_table; effect_hscl; effect_hii; effect_pa; effect_age];

names = string(param_table.Properties.RowNames);
n_names = numel(names);
% Get array that contains naming settings
names_ordering_array = get_array_for_renaming_and_reordering_variables();
idx_reorder = reorder_according_to_list(names, names_ordering_array(:, 1))
% *** Script output ***
param_table = param_table(idx_reorder, :);
param_table = rename_rows_by_list(param_table, names_ordering_array)
