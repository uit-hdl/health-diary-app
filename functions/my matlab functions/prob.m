function p = prob(I, repr, n_sigDig, computeCI)
if nargin==1
    repr = "decimal";
    n_sigDig = [];
elseif nargin==2
    n_sigDig = [];
end
p = sum(I)/length(I);



% *** display style ***
if not(repr=="decimal")
    p = 100*p;
end

if ~isempty(n_sigDig)
    p = round(p,n_sigDig);
end

end