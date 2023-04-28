function AUC = getAUC(Ytrue,Ypred)
% computes the AUC. Assumes Ytrue is logical, and Ypred numerical.
[~,~,~,AUC] = perfcurve(Ytrue, Ypred, true);
end