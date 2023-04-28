function wAvg = getWeightedMean(x,counts)
% computes a weighted mean of the values in x, where the weights are given
% by the number of positive cases in the corresponding CV-validation-sets.
% This funtion was used before I realized I should ensure even spread of
% positive cases across the validation sets.
wAvg = sum(x.*counts/sum(counts));
end