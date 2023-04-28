function plotBinnedEstimates(x,y,nodes)
% plots average value of y for each bin, with bin edges determined by the
% vector nodes.
%% example:
% nodes =  [-inf,-2, -1, -.5, .5, 1, 2,+inf];
% x = normrnd(0,1,1,100);
% y = normrnd(0,.1,1,100) + .8*x;
% LM = fitlm(x,y);
%%
% ** Compute midpoints of each Interval **
if nodes(1)==-inf
    nodes(1) = min(x);
end
if nodes(end)==+inf
    nodes(1) = min(x);
end
midPnts = mean([nodes(2:end);nodes(1:end-1)],'o');
Nbins = numel(nodes)-1;
y_binnedEsts = zeros(Nbins-1,3);
for i=1:Nbins
    Ix_bin_i = and( nodes(i)<=x, x<nodes(i+1) );
    y_i = y(Ix_bin_i);
    y_binnedEsts(i,:) = computeCImeanEst(y_i,"2");
end

for i=1:Nbins
    xpnt = midPnts(i);
    plot(midPnts(i),y_binnedEsts(i,:))
    line([xpnt,xpnt],[y_binnedEsts(i,1),y_binnedEsts(i,3)],...
        'LineWidt',2,'Color','k')
    hold on
    scatter(xpnt,y_binnedEsts(i,2),'MarkerFaceColor','k',...
                                   'MarkerEdgeColor','g',...
                                   'LineWidth',1)
end

end