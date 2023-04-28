function y = util_makeCol(x)
if isrow(x)
    y = x';
elseif iscolumn(x)
    y = x;
else
    error('x is not a vector')
end