theGreatVariableForge
%%

% Do those who exercise more have better mental health?
data7 = data(data.t==7,:);
close all
subplot(131)
myhist(data7.mentIll(data7.PAfrq=="1"))
ylim([0,0.8])
subplot(132)
myhist(data7.mentIll(data7.PAfrq=="2"))
ylim([0,0.8])
subplot(133)
myhist(data7.mentIll(data7.PAfrq=="3"))
ylim([0,0.8])


computeCImeanEst(data7.mentIll(data7.physact34=="0")>=1,"2")
computeCImeanEst(data7.mentIll(data7.physact34=="1")>=1,"2")

computeCImeanEst(data7.mentIll(data7.physact34=="0")>=2,"2")
computeCImeanEst(data7.mentIll(data7.physact34=="1")>=2,"2")

computeCImeanEst(data7.mentIll(data7.physact34=="0")>=3,"2")
computeCImeanEst(data7.mentIll(data7.physact34=="1")>=3,"2")

%%
clear data7
%%
x{1} = {'mentIll'};
x{2} = {'mentIll','anxiety'};
x{3} = {'mentIll','anxiety','depr'};
lmArray{1} = fitglme(data(t>=6,:),getLinearModelFormula(x{1},'srh',true))
lmArray{2} = fitglme(data(t>=6,:),getLinearModelFormula(x{2},'srh',true))
lmArray{3} = fitglme(data(t>=6,:),getLinearModelFormula(x{3},'srh',true))
%%
close all
figure
subplot(131)
plotCoeffLinearModel(lmArray{1})
ylim([-1.2,.5])
subplot(132)
plotCoeffLinearModel(lmArray{2})
ylim([-1.2,.5])
subplot(133)
plotCoeffLinearModel(lmArray{3})
ylim([-1.2,.5])
%%
coeffNames = {'mentIll','anxiety_2','anxiety_3','anxiety_4','depr_2','depr_3','depr_4'};
T = coeffEstTableForMultipleModels(lmArray,coeffNames,x)


