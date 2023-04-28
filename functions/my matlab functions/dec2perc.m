function out = dec2perc(x,Nround)
if nargin==1
    Nround = 1;
end
out = round(100*x,Nround);
end