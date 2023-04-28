function y = pseudoLog(x,a,b,plotIt,plotRange)
% behaves similarly to the log function and square root function by
% magnifying small values and supresing small values, but can be tailored
% to accomodate need for degree of suppression and empowerment of large and
% small values respectively. a is the power parameter, and b is the power
% modification parameter. setting a=0.5 and b=inf gives the square root
% function. The power modification factor has the effect of suppressing the
% power as the value of x gets larger, thus suppressing larger values more
% strongly than a regular power function would. The function was designed
% to have the advantages of both the power function and the log function,
% namely it is non-negative and defined at zero (power function) and it can
% strongly suppress large values (log).

% example: https://www.desmos.com/calculator/zjb4tjzjao

%% preliminary
if nargin==1
    a = 1;
    b = inf;
    plotIt = false;
    plotRange = 10;
elseif nargin==2
    b = inf;
    plotIt = false;
    plotRange = 10;
elseif nargin==3
    plotIt = false;
    plotRange = 10;
elseif nargin==4
    plotRange = 10;
end
if isempty(a)
    a = 1;
end
if isempty(b)
    b = inf;
end
%%
    
y = x.^(a*exp(-x/b));

if plotIt
    xx = 0:0.001:plotRange;
    plot(xx,xx.^(a*exp(-x/b)));
end
end