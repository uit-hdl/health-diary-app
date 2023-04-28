
clf
lm = lme;
sigColorCode = signifColorCode(lm.Coefficients.pValue(2:end),...
                    ["lime","yellow","orange","red"]);

CI = [lm.Coefficients.Lower(2:end),lm.Coefficients.Upper(2:end)];

barText = categorical(lm.CoefficientNames(2:end));
barText = reordercats(barText,lm.CoefficientNames(2:end));
barh(barText,lm.Coefficients.Estimate(2:end))
cat = 1:height(CI);
n = length(cat);
m = mean(CI'); %#ok<*UDIM>
color = sigColorCode;
for j=1:n
    col = color2triplet(color(j));
    line([CI(j,1),CI(j,2)],[cat(j),cat(j)],'LineWidth',2,'Color','k')
    hold on
    plot(mean(m(j)),cat(j),'o','MarkerFaceColor',col,'MarkerEdgeColor','k')
end
%%

n = length(cat);

m = mean(CI);
for j=1:length(cat)
    col = color2triplet(color(j));
    line([cat(j),cat(j)],[CI(1,j),CI(2,j)],'LineWidth',2,'Color','k')
    hold on
    plot(cat(j),mean(m(j)),'o','MarkerFaceColor',col,'MarkerEdgeColor','k')
end



% plotCIforEachCat(1:height(CI), CI', sigColorCode)
xticklabels(convert2LatexFormat(lm.CoefficientNames(2:end)))
titleStr = sprintf('n observations = %g',lm.NumObservations);
title(sprintf('n observations = %g',lm.NumObservations))