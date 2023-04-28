function intervals = getIntervalEndpoints(x,fs)
% takes a vector of 0s and 1s, which indicates the positions of intervals,
% and returns the boundaries of the intervals. fs, the sampling frequency
% of x, is an optional argument.

%% ex:
% x = [0 0 1 1 1 1 0 0 0 1 1 1 1 0 0];
%          3     6       10    13 
% output:
% L = [3 10]
% U = [6 13]
% nodes = [0 3 7 10 14]
%%
if nargin==1
    fs = 1;
end
if iscolumn(x)
    x = x';
end
if not(islogical(x))
    warning('input should be logical index vector')
end
%%
% get upper endpoints, lower endpoints, and nodes:
delta = x(2:end)-x(1:end-1);
L = find([0,delta]==1);
U = find(   delta ==-1);

nodes = abs(x-[0,x(1:end-1)])>0;
nodes(1) = 1;
nodes(end) = 1;
nodes = find(nodes);

if x(end)==1
    % ends in an interval:
    U = [U,numel(x)];
end
if x(1)==1
    % begins in an interval:
    L = [0,L];
end

intervals.L = L/fs;
intervals.U = U/fs;
intervals.nodes = (nodes-1)/fs;
end