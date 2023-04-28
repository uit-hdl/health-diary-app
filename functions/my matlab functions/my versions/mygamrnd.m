function out = mygamrnd(meanx,sigmax,sz)
% same as gamrnd, but takes mean and standard deviation as parameters

if nargin==2
    sz = [1,sz];
end

% reparametrize
k = meanx.^2./sigmax.^2;
theta = sigmax.^2./meanx;

out = gamrnd(k,theta,sz);

end