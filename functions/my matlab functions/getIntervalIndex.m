function k_interval = getIntervalIndex(x,IntervalNodes)
% find out which interval x lies in.

%% Ex:
% x = 1.2;
% IntervalNodes = [0, .5, .7, 1.3, 1.5];
% --> IntervIndex = 3

%% Code
Nnodes = numel(IntervalNodes);
k_interval = [];
for i=1:Nnodes-1
    if IntervalNodes(i)<=x && x<IntervalNodes(i+1)
        k_interval = i;
    end
end

end