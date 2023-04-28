function fleissKappa =  getfleissKappa(ann1,ann2,classThr)
% computes fleiss kapps for two annotators assigning subjects to one of two
% classes. ann1 and ann2 are vectors containing either numerical data or
% logical data. classThr separates the two classes, and if not provided,
% ann1 and ann2 are assumed to be class predictions in the form of a
% logical index vector.
%% ex:
% classThr = 2;
% ann1 = HSdata0.MURMUR_1GRADENRAD_T72>=classThr;
% ann2 = HSdata0.MURMUR_1GRADENRSA_T72>=classThr;
% % nij = number of annotators that assigned subject i to category j:
% nijTable = [~ann1 + ~ann2, ann1 + ann2];
%% preliminary
if nargin==2
    classThr = 1;
end
ann1 = ann1>=classThr;
ann2 = ann2>=classThr;
%% code 
% number of subjects:
N = numel(ann1);
% number of annotators/raters:
n = 2;
% number of classes to assign subjects to:
k = 2;

nijTable = [~ann1 + ~ann2, ann1 + ann2];

p1 = 1/(n*N)*(sum(nijTable(:,1)));
p2 = 1/(n*N)*(sum(nijTable(:,2)));

P = sum(nijTable(:,:).*(nijTable(:,:) - 1),2)/(n*(n-1));
Pbar = mean(P);

PeBar = p1.^2 + p2.^2;
fleissKappa = (Pbar - PeBar)/(1-PeBar);

end