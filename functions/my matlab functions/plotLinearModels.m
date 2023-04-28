function plotLinearModels(lmeArray)

Nmodels = numel(lmeArray);
N = getSubplotSize(Nmodels);

for i=1:Nmodels
    subplot(N(1),N(2),i)
    lme = lmeArray{i};
    plotCoeffLinearModel(lme)
    title(sprintf('Rsqr = %g; BIC = %g',...
        round(lme.Rsquared.Ordinary,3), lme.ModelCriterion.BIC))
end

end