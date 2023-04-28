function X = drawFromDiscreteDist(p)
%% example input:
% p = [.2,.5,.3];
%%
x = unifrnd(0,1);
p_cum = [0,cumsum(p)];
X = find(x>p_cum,1,'last');

end