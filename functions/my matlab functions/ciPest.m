function ci = ciPest(arg1,arg2,alfa)
% computes 95% confidence intervals for a probability estimate based on the
% normality assumption. Accepts two types of arguments: either the
% estimated probability pEst along with the of number of
% samples/possibilities n. The other is logical index vectors I1 and I2 for
% the two populations, so that you are estimating the quantity P(I1|I2) =
% sum(and(I1,I2))/sum(I2).

% arg1,arg2 = pEst,n   OR   arg1,arg2 = I1,I2
if nargin==2
    alfa = 0.05;
end

if isa(arg1,'double')
    pEst = arg1;
    n = arg2;
    ci = pEst + [-1,1]*norminv(1-alfa/2)*sqrt(pEst*(1-pEst)/n);
else
    I1 = arg1;
    I2 = arg2;
    pEst = sum(and(I1,I2))/sum(I2);
    n = sum(I2);
    ci = pEst + [-1,1]*norminv(1-alfa/2)*sqrt(pEst*(1-pEst)/n);
end
end