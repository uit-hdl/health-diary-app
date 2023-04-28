function T = util_get_predictionMetrics(y, y_hat)
% get metrics from model prediction in a table format.

%%
n = numel(y);
r = y - y_hat;

y_hat_discr = round(y_hat);
y_hat_good = y_hat_discr > 2;
y_good = y > 2;

% root mean square error:
N_bs = 200;
rng(1)
bs_sample = bootstrp(N_bs, @(x) sqrt(mse(x)), r);
RMSEest = rmse(y, y_hat) * 100;
RMSE = round(RMSEest+[-1, 1]*1.96*std(bs_sample), 2);
RMSE = [RMSE(1), RMSEest, RMSE(2)]';

% accuracy all levels:
acc_4lvl = computeCImeanEst(y_hat_discr == y, "3", [], 3)' * 100;

% accuracy binary classification (good/bad):
acc_2lvl = computeCImeanEst(y_hat_good == y_good, "3", [], 3)' * 100;

% sensitivity and specificity (good/bad):
sn_good = computeCImeanEst(y_hat_good(y_good), "3", [], 3)' * 100;
sn_bad = computeCImeanEst(~y_hat_good(~y_good), "3", [], 3)' * 100;

% average modified accuracy (good/bad):
AccModEst = mean([sn_good(2), sn_bad(2)]);
SE_AccMod = 1 / 2 * sqrt(var(y_hat_good(y_good))+ ...
    var(~y_hat_good(~y_good))) / sqrt(n);
AccMod = AccModEst + [-1, 1] * 1.96 * SE_AccMod;
AccMod = [AccMod(1), AccModEst, AccMod(2)]';

% Correlation
correlation = util_correlation_with_ci(y_hat, y)';

T = array2table( ...
    [acc_4lvl, acc_2lvl, sn_bad, sn_good, RMSE, AccMod, correlation], ...
    "RowNames", ["estimate", "ci lower", "ci upper"], ...
    "VariableNames", ["acc. 1/2/3/4", "acc. good/bad", "sn bad", "sn good", "RMSE", "1/2(sn+sp)", "correlation"]);
end