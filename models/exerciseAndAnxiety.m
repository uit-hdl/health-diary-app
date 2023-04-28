modelData = data(t>=6,:);
modelData.anxiety = double(modelData.anxiety)>=2;
close all
lme = fitglme(modelData,'anxiety ~ PAleisure + (1|id)');
lme.Coefficients

B = getModelDefaultCategories(lme,data)
figure
plotCoeffLinearModel(lme)
title 'Main model' 
clear modelData