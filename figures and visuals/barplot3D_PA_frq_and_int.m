
T_t6 = zeros(4, 3);
T_t7 = zeros(4, 3);
for i_frq = 1:4
    for i_int = 1:3
        var_name = sprintf('f%gi%g', i_frq, i_int);
        T_t6(i_frq, i_int) = mean(X(data.t == 6) == var_name);
        T_t7(i_frq, i_int) = mean(X(data.t == 7) == var_name);
    end
end

clear Y
for i=1:4
    Y{i} = [T_t6(i, :); T_t7(i, :)]';
end

close all

figure(1)
hold on

for xval = 1:4
    h = bar3(Y{xval}, 'grouped');

    Xdat = get(h, 'Xdata');
    for ii = 1:length(Xdat)
        Xdat{ii} = Xdat{ii} + (xval - 1) * ones(size(Xdat{ii}));
        set(h(ii), 'XData', Xdat{ii});
    end
end

xlim([0 5]);
view(3);
title('Grouped Style')
xticklabels(["", "<1 per week","1/week","2-3/week","approx. every day"])
yticklabels(["mild" "" "moderate" "" "hard"])
xlabel('PA frequency');
ylabel('y');
zlabel('z');
