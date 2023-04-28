close all
s = {'$\it{Label\ 1}$', ...
    '$\pi r^2 + x_y$ x$_y$', ...
    '$\textbf{Label\ 3}$', ...
    '$\frac{foo}{bar}dy \geq$'};
x = [1, 21, 3, 15];
bar(x)
set(gca, ...
    'xtick', 1:numel(s), ...
    'XTickLabel', s, ...
    'TickLabelInterpreter', 'latex');
%%
close all
s = param_table.Properties.RowNames;
B = bar( ...
    param_table.coef, ...
    "BarWidth", 0.05, ...
    "FaceColor", color2triplet("grey"), ...
    "EdgeColor", "none");
set(gca, ...
    'xtick', 1:numel(s), ...
    'XTickLabel', s, ...
    'TickLabelInterpreter', 'latex')