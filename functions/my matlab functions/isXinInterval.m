function y = isXinInterval(X,A)
% check if the elements of x are in the interval A

lower = X>=A(1);
upper = X<=A(end);

y = lower.*upper;

end
