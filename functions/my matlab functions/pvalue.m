function pval = pvalue(x,sides,type)
% gives p-value corresponding to the hypothesis that the elements of x
% comes from a distribution with mean value significantly larger than 0.
if nargin==1
    sides = "oneSided";
    type  = "pairwise"; 
elseif nargin==2
    type  = "pairwise"; 
end

if isempty(sides)
    sides = "oneSided";
end

if type=="pairwise"
    
    if isrow(x)
        x = x';
    end
    t = mean(x);
    n = height(x);
    sigma = std(x);
    
    if sides=="oneSided"
        pval = 1 - tcdf(sqrt(n)*t./sigma, n-1);
    else
        pval = 2*min([tcdf(sqrt(n)*t./sigma, n-1),1 - tcdf(sqrt(n)*t./sigma, n-1)]);
    end
    
elseif type=="compareMeans"
    x1 = x{1}(isval(x{1}));
    x2 = x{2}(isval(x{2}));
    
    m1 = mean(x1);
    m2 = mean(x2);
    s1 = std(x1);
    s2 = std(x2);
    n1 = numel(x1);
    n2 = numel(x2);
    
    t = (m1-m2)/sqrt(s1^2/n1 + s2^2/n2);
    df_conservative = min(n1-1, n2-1);
   
    if sides=="oneSided"
        pval = 1 - tcdf(t, df_conservative);
    else
        t = abs(t);
        
        p0_upper = 1 - tcdf(t, df_conservative);
        p0_lower = tcdf(-t, df_conservative);
        pval = p0_upper + p0_lower;
        
    end
end

end