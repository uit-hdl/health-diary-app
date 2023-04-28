function X = presentFraction(X,ndig)
if nargin==1
    ndig = 3;
    percentage = true;
end
if percentage
    X = 100*round(X,ndig);
else
    X = 100*round(X,ndig);
end
end