function ci = util_calc_ci_diff_2_means(x, y)

n_x = sum(~isnan(x));
n_y = sum(~isnan(y));
x_mean = mean(x, 'omitnan');
y_mean = mean(y, 'omitnan');

delta = x_mean - y_mean;

std_diff = sqrt(1/n_x * var(x, 'omitnan') + 1/n_y * var(y, 'omitnan'));

ci = delta + [-1, 1]*1.96*std_diff;
ci = [ci(1), delta, ci(2)];

end