function bootCI = getBootStrappedAUCci(Ytarget,activ,nIterations)
% Bootstrap AUC-ci. Requires binary target vector Ytarget, activation
% vector activ, and optionally number of bootstrap activations.
%% preliminary
if nargin==2
    nIterations = 100;
end
%%
myFunc = @(x1,x2) getAUC(x1,x2);

bootCI = bootci(nIterations,...
    {myFunc, Ytarget, activ});
end