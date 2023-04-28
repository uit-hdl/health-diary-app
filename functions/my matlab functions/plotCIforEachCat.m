function plotCIforEachCat(x, y, color, hplot)
% plots confidence interval stored as column vectors in y for each
% category in x, where cat is an integer vector in which each integer
% represents a category, such as murmur-grade.

%% example:
% cat = [1,2];
% CI  = [[1;2],[3.5;4]];

%% preliminary
if isvector(y)
    [meanVals, Icat, yCat, y, x] = findMeanForEachCat(x, y);
end

n = length(x);
if nargin == 2
    color = strings([1, n]);
    color(:) = "k";
    hplot = false;

elseif nargin == 3
    hplot = false;
end

if isempty(color)
    color = strings([1, n]);
    color(:) = "k";
end

if height(y) == 3
    y = [y(1, :); y(3, :)];
end

%%
m = mean(y);
w = 0.1;

if hplot
    for j = 1:length(x)
        col = color2triplet(color(j));
        line([y(1, j), y(2, j)],[x(j), x(j)], 'LineWidth', 3, 'Color', 'k')

        hold on
        plot(mean(m(j)), x(j), 'o', 'MarkerFaceColor', col, 'MarkerEdgeColor', 'k')

        x1 = x(j) - w;
        x2 = x(j) + w;
        y1 = y(1, j);
        y2 = y(2, j);
        line([y1, y1], [x1, x2], 'LineWidth', 1, 'Color', 'k')
        line([y2, y2], [x1, x2], 'LineWidth', 1, 'Color', 'k')


    end

else

    for j = 1:length(x)
        col = color2triplet(color(j));
        line([x(j), x(j)], [y(1, j), y(2, j)], 'LineWidth', 3, 'Color', 'k')

        hold on
        plot(x(j), mean(m(j)), 'o', 'MarkerFaceColor', col, 'MarkerEdgeColor', 'k')

        x1 = x(j) - w;
        x2 = x(j) + w;
        y1 = y(1, j);
        y2 = y(2, j);
        line([x1, x2], [y1, y1], 'LineWidth', 1, 'Color', 'k')
        line([x1, x2], [y2, y2], 'LineWidth', 1, 'Color', 'k')


    end
end
end