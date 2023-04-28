function [p,ci] = condProb(I1,I2,computeCi,alfa,ciType,dispPercent)
% function that computes the conditional probability
% P(condition1|condition2), using the logical index vectors I1 and I2 that
% corresponds to the two populations that match the two conditions. If I2
% is empty, then it computes the unconditional probability. optionally it
% computes confidence interval of the estimate.
if nargin==2
    computeCi = false;
    alfa = 0.05;
    ciType = "normal";
    dispPercent = false;
elseif nargin==3
    alfa = 0.05;
    ciType = "normal";
    dispPercent = false;
elseif nargin==4
    dispPercent = false;
elseif nargin==5
    dispPercent = false;
end

if isempty(I2)
    I2 = ones(numel(I1),1);
end
if isempty(alfa)
    alfa = 0.05;
end
if isempty(ciType)
    ciType = "normal";
end

% *** convert to logical ***
if iscategorical(I1)
    % assumes that I1 contains categorical ones and zeros
    I1 = (I1=='1');
end
if iscategorical(I2)
    % assumes that I2 contains categorical ones and zeros
    I2 = (I2=='1');
end

% *** compute conditional probability ***
if iscell(I2)
    p = sum( myand([{I1}, I2]) )/sum(myand(I2));
else
    if sum(I2)==0
        p = nan;
    else
        p = sum(and(I1,I2))/sum(I2);
    end
end


% *** compute confidence interval if requested ***
if computeCi
    if ciType=="binomial"
        [~,ci] = getBinomialCI(I1(I2));
    else
        ci = ciPest(p,sum(I2),alfa);
    end
    if dispPercent
        ci = dec2perc(ci,1);
    end
end

if dispPercent
    p = dec2perc(p,1);
end


end