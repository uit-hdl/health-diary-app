function [meanVals,Icat,yCat,CI,cat] = findMeanForEachCat(x,y,plotFig,catColors)
% ** description **
% x is an integer valued vector representing categories, and y is numerical
% vector with values corresponding to the categories in x. Returns mean
% values for each category, ordered from smallest to largest element in x.
% Also returns a cell array with index vectors for each integer category;
% ;a cell array with the y-values for each category; and a cell array
% containing confidence intervals for each category. Takes mean of the
% Ignores nan-values.

% ** used for **
% example input:
%  x = [1,1,1,          2,2,2,           3,3,3]
%  y = [1.1, 0.9, .7,   2.3, 1.9, 2.2,   3.1, 2.5, 3.2]
%% Preliminary
if nargin==2
    plotFig = false;
elseif nargin==3
    catColors = [];
end

%% Code
Imissing = or(ismissing(x),ismissing(y));
x = x(~Imissing);
y = y(~Imissing);

% find integers in x
cat = unique(x);
nCat = length(cat);
Icat = cell(1,nCat);
yCat = cell(1,nCat);
CI   = zeros(2,nCat);
meanVals = zeros(1,nCat);


for i=1:nCat
    Icat{i} = (x==cat(i));
    yCat{i} = y(Icat{i});
    meanVals(i) = mean(yCat{i});
    CI(:,i) = computeCImeanEst(yCat{i});
    
    if plotFig
        if isempty(catColors)
            col = "k";
        else
            col = color2triplet(catColors(i));
        end
        
        if iscategorical(cat)
            xpos = i;
        else
            xpos = cat(i);
        end
        
        line([xpos,xpos], [CI(1,i),CI(2,i)], 'LineWidth', 2, 'Color', 'k')
        hold on
        plot(xpos,meanVals(i),'o','MarkerFaceColor',col,...
                        'MarkerEdgeColor','k','MarkerSize',5)
    end
end

if plotFig
    if iscategorical(cat)
        xticklabels(cat)
        xticks(1:nCat)
        xlim([0,nCat+1])
    else
        xlim([cat(1)-1,cat(end)+1])
    end
    
end
end