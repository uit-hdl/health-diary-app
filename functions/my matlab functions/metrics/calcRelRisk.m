function [RR,ci] = calcRelRisk(lm,X,deltaX,n_vec)
% computes the estimated relative change in risk by changing X as indicated
% by the vector deltaX. Used in conjunciton with a linear model lm.

%% preliminary
if nargin==3
    n_vec = nan;
end
%% example:
% X = [1,0];
% deltaX = [0,1];
%%
p2 = 1/(1 + exp(-X*lm.Coefficients.Estimate) );
p1 = 1/(1 + exp(-(X + deltaX)*lm.Coefficients.Estimate) );
RR = p1/p2;

if isval(n_vec)
    Idiff = find(deltaX~=0);
    x2 = X(Idiff);
    x1 = x2 + deltaX(Idiff);
    n1 = n_vec(1);
    n2 = n_vec(2);
    cilog = log(RR)+[-1 1]*1.96*sqrt((n1-x1)/(x1*n1) + (n2-x2)/(x2*n2));
    ci = exp(cilog);
end

end

