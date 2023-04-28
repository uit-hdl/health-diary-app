N = 1000;
b0 = 1.2; % determines how much PA affects health
b1 = 0.65;

% simulate actual PA and health:
X = normrnd(0, 1.2, [N, 1]);
Y = normrnd(b0+b1*X, 3, [N, 1]);

close all
plot(X, Y, '*')

lm = fitlm(X, Y);
res = lm.Residuals.Raw;
subplot(1, 2, 1)
plot(lm.Residuals.Raw, Y, 'o')
xlabel("residuals")
ylabel("Y")

subplot(1, 2, 2)
plot(lm.Fitted, Y, 'o')
hold on
L = [-2, 5];
plot(L, L)
xlabel("Y_{pred}")
ylabel("Y")

fitlm(table(res, Y), 'Y ~ res')