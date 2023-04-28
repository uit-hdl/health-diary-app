%% Main model number one. Separate mental health scores.
%'physact34:old', 'physact',
fixedVars = {'age','liveWspouse','education','strokeOrHrtAtk','sex','diabHba1c'};
decisionVars = {'PAhard','bmi','hypert','hdl','smokeNow',...  
                'lonely','mentHealthInd','insomniaFrq','drinkTimes'};
interactionPart = {'bmi:old','smokeNow:old',...
                   'PAhard4:smokeNow','old:insomniaFrq234','old:PAhard4'};
formula = getLinearModelFormula([fixedVars,decisionVars,interactionPart,...
                                 {'(1|id)'}],'srh');
findMissingVar = true;
if findMissingVar % use this code if error: unrecognized variables
	whichVarsInDataset(data,{fixedVars,decisionVars,interactionPart})
end

lme45 = fitglme(data(t<=5,:),formula);

T = compactLinModelPresentation(lme45,{'sigLvl'})
close all
figure
plotCoeffLinearModel(lme45)
title 'Main model T4-T5' 