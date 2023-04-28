%% Can mixed effect models correct for bias? %%
% set number of samples:
N = 10000;
b0 = 1.2; % determines how much PA affects health
b1 = 0.65;

% simulate actual PA and health:
X0 = normrnd(0, 1.2, [N, 2]);
Y0 = normrnd(b0+b1*X0, 0.7);

% simulate bias for reporting PA and health:
B_x0 = normrnd(0, 0.9, [N, 1]);
B_y0 = normrnd(B_x0, 0.1); % assume that the bias in reporting Y corellates to the reporting bias of X

% simulate self reported values:
X = normrnd(B_x0+X0, 0.2, sz);
Y = normrnd(B_y0+Y0, 0.3, sz);


D = [X0, Y0, X, Y];
D = reshape(D, 2*N, []);
D(:, end+1) = repmat((1:N)', [2, 1]);
T = array2table(D, ...
    "VariableNames", ["PA", "health", "PA_sr", "health_sr", "id"]);
T = convertvars(T, "id", "categorical");

lme0 = fitglme(T, "health ~ PA + (1|id)");
lme_sr = fitglme(T, "health_sr ~ PA_sr + (1|id)");

lme0.Coefficients
lme_sr.Coefficients

% plot:
plotIt = true;
if plotIt
    close all
    subplot(211)
    scatter(X0(:), Y0(:))
    title("true values")
    xlabel("PA")
    ylabel("health")
    subplot(212)
    scatter(X(:), Y(:))
    title("reported values")
    xlabel("PA reported")
    ylabel("health reported")
end
