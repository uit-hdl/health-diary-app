function [ci, std_of_diff] = util_get_CI_for_paramDiff(lme, name_lvl1, name_lvl2, varargin)
% Calculate confidence interval for the difference beta_1 - beta_2
% (difference between averages of two groups) using the coefficient
% covariance matrix Cov_mat (table with named rows and columns) of the
% fitted linear model (obtain withg lme.CoefficinetCovariance).
P.include_estimate = "include_est_in_left";

p = inputParser;
addOptional(p, "include_estimate", P.include_estimate)
parse(p, varargin{:});
P = updateOptionalArgs(P, p);

%%
Cov_mat = array2table(lme.CoefficientCovariance, ...
    "RowNames", lme.CoefficientNames, ...
    "VariableNames", lme.CoefficientNames);
coeff_names = lme.Coefficients.Name;

names = Cov_mat.Properties.RowNames;
if ~ismember(name_lvl2, names)
    % The comparison group cannot be found; assume name_lvl2 is the default
    % category:
    warning("One or more coefficient names were not recognized; assumes comparison is to baseline category")
    if ismember(name_lvl1, names)
        std_of_diff = sqrt(Cov_mat{name_lvl1, name_lvl1});
        Estimate = lme.Coefficients.Estimate(coeff_names == name_lvl1);
    else
        % Assume default is being compared to default
        std_of_diff = 0;
        Estimate = 0;
    end


elseif ~ismember(name_lvl1, names)
        % name_lvl1 is the baseline category and is compared against
        % another category
        std_of_diff = sqrt(Cov_mat{name_lvl2, name_lvl2});
        % reverse sign
        Estimate = -lme.Coefficients.Estimate(coeff_names == name_lvl2);

    else
            std_of_diff = sqrt(Cov_mat{name_lvl1, name_lvl1} ...
                -2*Cov_mat{name_lvl1, name_lvl2}+ ...
                Cov_mat{name_lvl2, name_lvl2});
        Estimate = ...
            lme.Coefficients.Estimate(coeff_names == name_lvl1) - ...
            lme.Coefficients.Estimate(coeff_names == name_lvl2);
end

ci = Estimate + [-1, 1] * std_of_diff * 1.96;
if P.include_estimate == "middle"
    ci = [ci(1), Estimate, ci(2)];
elseif P.include_estimate == "include_est_in_left"
    ci = [Estimate, ci(1), ci(2)];
end

end