% model: y = beta + x1 + x2 + e. assume that x1 causes x2 to improve.

N = 1000;
x1 = normrnd(0,1,[N,1]);
x2 = 0.7*x1 + normrnd(0,1,[N,1]);
e = normrnd(0,0.2,[N,1]);

y = 1.2 + 3.5*x2 + e;

fitlm([x1,x2],y)

% in this simulation, x1 causes x2 to increase. However, when we fit a
% linear model using x1 and x2 as predictors, the coefficient of x2 is
% estimated to zero, implying (naively) that x2 has no impact on y. This,
% however, is because we are not allowing x2 to move in the model as we
% vary x1, and thereby we are cutting of the means by which x1 exerts
% influence on x2. To get a better idea of the influence of x1 on y, it
% would be more appropriate to exclude to model y as a function of x1 only.


