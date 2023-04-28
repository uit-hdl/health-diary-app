%% Get data
if ~exist('TUdata', 'var')
    importLongData
end
theGreatVariableForge


load("survey_id_overlap.mat", "ID_overlap")
% extract a test set from T7 consisting of participants who only
% participated in T7:
N_test = 200;
id_T7_only = setdiff(ID_overlap.id{4, 4}, ID_overlap.id{3, 3});
id_T7_test = randsample(id_T7_only, N_test);
I_test = and(findInd(data.id, id_T7_test), data.t == 7);
I_fit = and(~I_test, data.t >= 6);
% Main Model
modelData = data(I_fit, :);
modelData = modelData(~modelData.PA_nonsense, :)

lme = fitglme(modelData, 'srh ~ hscl^2 + PA + (1|id)');
T = compactLinModelPresentation(lme, {'Name', 'Estimate', 'pValue', 'sigLvl'}) %#ok<*NASGU>

close all
figure
plotCoeffLinearModel(lme)
title 'Main model T6-T7'

%% prediction on training set
y = modelData.srh;
y_hat = lme.predict
r = lme.residuals
close all
subplot(121)
plot(normrnd(y, 0.01), y_hat, 'o', "color", color2triplet("grey"))
hold on
plotCIforEachCat(y, y_hat)
ylim([1, 4])

subplot(122)
plot(util_shakeCoordinates(y, 0.05), r, 'o', "color", color2triplet("grey"))
hold on
plotCIforEachCat(y, r)
ylim([-2, 2])
title("SRH vs residuals")
ylabel('residuals')
xlabel('SRH')

%% compare empirical distribution against theoretical distributins
close all
pd = makedist("InverseGaussian")
for k = 1:2
    t = 5 + k;
    I = modelData.t == t;
    y = modelData.srh(I);
    subplot(2, 2, 2*k-1)
    % plot empirical distribution
    H = mean([y == 1, y == 2, y == 3, y == 4])
%     a = histogram(y, "Normalization", "probability", "FaceColor", "k")
    % fit normal distribution to SRH:
    pd = fitdist(y, "Normal")
    pmf = @(x) pd.cdf(x + 0.5) - pd.cdf(x - 0.5)
    bar([H; pmf([1, 2, 3, 4])]')
    % plot fitted normal distribution:
    hold on
    x = 0:0.05:6;
    plot(x, pd.pdf(x), 'Color', "k")
    xlabel("SRH")
    title(sprintf("theor. vs empir. distribution T%g", t))
    legend("empir.", "theor.")  

    for u = 1:4
        P_thr_srh_leq(u) = pd.cdf(u + 0.5);
        P_emp_srh_leq(u) = mean(modelData.srh(I) <= u);
    end

    subplot(2, 2, 2*k)
    plot(P_emp_srh_leq, P_thr_srh_leq, '-ok')
    hold on
    plot([0, 1], [0, 1], '--')
    xlabel("empirical")
    ylabel("theoretical")

    title(sprintf("pp-plot T%g", t))

end


array2table([[pmf(1), pmf(1)+pmf(2), pmf(3)+pmf(4), pmf(4)]; ...
    [mean(y == 1), mean(y <= 2), mean(y >= 3), mean(y == 4)]]*100, ...
    "RowNames", ["empirical", "theoretical"], ...
    "VariableNames", ["P(x == 1)", "P(x <= 2)", "P(x == 3 or 4)", "P(x == 4)"])

%% compare empirical distribution against binomial distribution:
close all

for k = 1:2
    t = 5 + k;
    I = modelData.t == t;
    y = modelData.srh(I);
    subplot(2, 2, 2*k-1)
    % plot empirical distribution
    H = mean([y == 1, y == 2, y == 3, y == 4])
    % fit normal distribution to SRH:
    pd = fitdist(y, "Binomial", "NTrials", 4)
    pmf = @(x) pd.cdf(x) - pd.cdf(x-1);
    bar([H; pmf([1, 2, 3, 4])]')
    legend("emp", "thr")
    title(sprintf("thr. vs emp. distribution T%g", t))

    for u = 1:4
        P_thr_srh_leq(u) = pd.cdf(u);
        P_emp_srh_leq(u) = mean(modelData.srh(I) <= u);
    end

    subplot(2, 2, 2*k)
    plot(P_emp_srh_leq, P_thr_srh_leq, '-ok')
    hold on
    plot([0, 1], [0, 1], '--')
    xlabel("empirical")
    ylabel("theoretical")

    title(sprintf("PP-plot T%g", t))

end


array2table([[pmf(1), pd.cdf(2), 1 - pd.cdf(2), pmf(4)]; ...
    [mean(y == 1), mean(y <= 2), mean(y >= 3), mean(y == 4)]]*100, ...
    "RowNames", ["empirical", "theoretical"], ...
    "VariableNames", ["P(x == 1)", "P(x <= 2)", "P(x == 3 or 4)", "P(x == 4)"])


