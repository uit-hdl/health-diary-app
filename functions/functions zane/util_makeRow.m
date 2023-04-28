function y = util_makeRow(x)
if isrow(x)
    y = x;
elseif iscolumn(x)
    y = x';
else
    error('x is not a vector')
end