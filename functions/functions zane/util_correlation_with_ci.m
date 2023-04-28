function ci = util_correlation_with_ci(x1, x2)
[corr_mat, ~, lower, upper] = corrcoef(x1, x2, "Rows", "complete");
ci = [lower(2, 1), corr_mat(2, 1), upper(2, 1)];
end