function out = getSpan(x,type)
% get the range or span of x, including all intermediate integer values or
% only the extreme values of x.
if nargin==1
    type = 1;
end

if type==1
    out = [min(x),max(x)];
else
    out = min(x):max(x);
end
end