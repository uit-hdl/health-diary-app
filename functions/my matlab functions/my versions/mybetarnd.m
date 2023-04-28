function out = mybetarnd(meanx,sigmax,n_rnd)
% same as betarnd, but takes mean and standard deviation as parameters
% reparametrize
mu = (meanx.*(1 - meanx)./sigmax.^2 - 1);
a = meanx.*mu;
b = (1 - meanx).*mu;

if nargin == 2
    n_rnd = 1;
end
%     
% [a,b] = betapar(meanx,sigmax);
out = betarnd(a,b,1,n_rnd);

end