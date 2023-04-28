function [rr,ciRR] = relRisk(I1,I2,estCi,alfa)
% Computes relative risk p1/p2. Risks associated with subgroup 1 and
% subgroup 2 is calculated based prevalences as provided by logical index
% vectors I1 and I2.

if nargin==2
    estCi = false;
elseif nargin==3
    alfa = .05;
end

p1 = condProb(I1,I2);
p2 = condProb(I1,~I2);
% compute relative risk:
if p2==0
    rr = p1/p2;
    ciRR = [nan nan];
else
    rr = p1/p2;
end

if estCi && p2>0
    % group 1 is those with murmur, group 2 is those without
    n1 = sum(I2);  % how many have murmur
    n2 = sum(~I2); % how many do not have murmur
    x1 = countOverlap(I1,I2);  % how many with murmur have disease
    x2 = countOverlap(I1,~I2); % how many without murmur have disease
    z = norminv(1-alfa/2);
    ciOdds = log(rr) + [-1 1]*z*sqrt( (n1-x1)/x1/n1 + (n2-x2)/x2/n2 );
    ciRR = exp(ciOdds);
end
end