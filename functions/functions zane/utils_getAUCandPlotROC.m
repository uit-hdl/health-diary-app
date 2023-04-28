function [AUC,X,Y,T] = utils_getAUCandPlotROC(YmurPred,Ytarget,varargin)
% Get AUC and plot sensitivity and specificity tradeoff curve (ROC-curve).
%% optional arguments
plotFigure = false;

p = inputParser;
addOptional(p,'plotFigure',plotFigure)
parse(p,varargin{:})

plotFigure = p.Results.plotFigure;

%% body
pos_class_label = true;
[X, Y, T, AUC] = perfcurve(Ytarget, double(YmurPred), pos_class_label);

if sum(YmurPred)==0
    X = nan;
    Y = nan;
    T = nan;
    AUC = nan;
end

if plotFigure && sum(YmurPred)>0
    % Y is the sensitivity, and 1-X is the specificity:
    plot(X,Y)
    title(sprintf('AUC = %g',round(AUC,3)) )
    xlabel '1 - specificity'
    ylabel 'sensitivity'
end

end