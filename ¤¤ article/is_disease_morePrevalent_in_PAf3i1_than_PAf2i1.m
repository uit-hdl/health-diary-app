% This script intends to investigate the following observation: The group
% who engages in mild PA once per week had higher SRH average than those
% who engages in mild PA 2-3 times per week.

theGreatVariableForge
%%
D = data(data.t == 7, :);

X = myor({D.stroke == "1", ...
    D.heartAttack == "1", ...
    D.angina == "1", ...
    D.hii >= 2})

util_sumAndMean(X(D.PA == "f3i1"), "format", "ci")
util_sumAndMean(X(D.PA == "f2i1"), "format", "ci")

%% compute confidence interval for difference in means
I1 = D.PA == "f2i1";
I2 = D.PA == "f3i1"
x1 = X(I1);
x2 = X(I2);

n1 = sum(I1);
n2 = sum(I2);
s1 = std(x1)
s2 = std(x2)

df = n1 + n2 - 2;
S = sqrt(1/n1*s1^2 + 1/n2*s2^2);

ci = mean(x2) - mean(x1) + [-1, 1]*tinv(0.975, df)*S

ci = ci*100

T = (mean(x2) - mean(x1))/S
tcdf(-abs(T), df)*2
%% high health impact index
util_sumAndMean(D.cancer(D.PA == "f3i1")=="1", "format", "ci")
util_sumAndMean(D.cancer(D.PA == "f2i1")=="1", "format", "ci")

%% mean health impact index
computeCImeanEst(D.hii(D.PA=="f3i1"), "2")
computeCImeanEst(D.hii(D.PA=="f2i1"), "2")
%%
computeCImeanEst(D.srh(D.PA=="f3i1")==1, "2")
computeCImeanEst(D.srh(D.PA=="f2i1")==1, "2")



