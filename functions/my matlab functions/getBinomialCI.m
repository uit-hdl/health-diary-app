function [phat,phatCi] = getBinomialCI(Isuccess)
% estimates p_success, and confidence interval if required. Isuccess is a
% logical index vector with ones indicating correct predicions.

NcorrPred = sum(Isuccess);
Ntrials   = numel(Isuccess);

[phat,phatCi] = binofit(NcorrPred,Ntrials);

end