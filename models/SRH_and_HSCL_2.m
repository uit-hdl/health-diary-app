modelData = data(data.t>=6,:);
lme1 = fitglme(modelData,'srh ~ age*age + hscl + age*hscl + (1|id)');
lme2 = fitglme(modelData,'srh ~ age*age + hscl + age:age*hscl + (1|id)');
lme3 = fitglme(modelData,'srh ~ age*age + hscl + old*hscl + (1|id)');

compactLinModelPresentation(lme1,{'Name','Estimate','sigLvl','pValue'})
compactLinModelPresentation(lme2,{'Name','Estimate','sigLvl','pValue'})
close all

figure
subplot(131)
    plotCoeffLinearModel(lme1)
    title(sprintf('Rsqr = %g',lme1.Rsquared.Ordinary))
subplot(132)
    plotCoeffLinearModel(lme2)
    title(sprintf('Rsqr = %g',lme2.Rsquared.Ordinary))
subplot(133)
    plotCoeffLinearModel(lme3)
    title(sprintf('Rsqr = %g',lme3.Rsquared.Ordinary))