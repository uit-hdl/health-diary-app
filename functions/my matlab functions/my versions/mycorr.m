function [c,pvals] = mycorr(x,y,calcpVal)
% my version of corr. Computes correlation between x and y, or the
% correlation matrix of the matrix x (vectors stored as columns)
if nargin==1
    y = [];
    calcpVal = false;
elseif nargin==2
    calcpVal = false;
end

if isempty(y)
    if calcpVal
        [c,pvals] = corr(x,'rows','complete');
    else
        c = corr(x,'rows','complete');
    end
else
    
    if isrow(x)
        x = x';
    end

    if isrow(y)
        y = y';
    end
    if calcpVal
        [c,pvals] = corr(x,y,'rows','complete');
    else
        c = corr(x,y,'rows','complete');
        pvals = [];
    end

end