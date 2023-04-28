function y = sqrtAbsVal(x,p)
% returns the square root of the modulus of x, with the sign maintianed.
% Used to better see the values when plotting.
if nargin==1
    p = 0.5;
end

y = sign(x).*(abs(x)).^p;

end