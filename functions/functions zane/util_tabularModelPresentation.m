function T = util_tabularModelPresentation(Coeff, Pvals, CoeffNames)
% take estimated coefficients with associated p-values and names, and
% return a nicely formatted table
%%
Coeff = double(Coeff);
Pvals = double(Pvals);
N = numel(Coeff);
T = strings(N, 1);
p_stars = getPvalStars(Pvals);

for i = 1:N
    stars = p_stars{i};
    p = Pvals(i);
    if contains(stars, ' ')
        T(i, 1) = sprintf('%.3g', Coeff(i));
        T(i, 2) = sprintf('%.3g', p);
    else
        if p < 0.0001
            T(i, 1) = sprintf('%.3g (%s)', Coeff(i), stars);
            T(i, 2) = "<0.0001";
        else
            T(i, 1) = sprintf('%.3g (%s)', Coeff(i), stars);
            T(i, 2) = sprintf('%.3g', p);
        end
    end
end

T = array2table(T, "RowNames", CoeffNames);


end