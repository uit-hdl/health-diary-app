clf
for i=1:4
    data = TUdata(TUdata.time==3+i,:);
    subplot(2,2,i)
    clf;histogram(data.srh,'Normalization','probability');hold on; plot(1:4,binopdf(1:4,4,.65),'o')
    title(sprintf('TU%g',3+i))
end
%%
data = TUdata(TUdata.time==7,:);
clf;histogram(data.srh,'Normalization','probability');hold on; plot(1:4,binopdf(1:4,4,.65),'o')
%%
data = TUdata(TUdata.time>=6,:);
data.physact = renameAndRelevel(data.physact,["0","1","2","3"],...
                                             ["1","0","2","3"]);
data.sex  = categorical(data.sex);
data.age = data.age/10;
data.depr = categorical(data.depr);
data.bmi = data.bmi/std(data.bmi,'o');
data.restHR = data.restHR/10;

modelFormula = getLinearModelFormula({'physact','sex','depr','diab','(1|id)'},'srh')
lmNorm = fitglme(data,modelFormula,'distribution','Normal');
lmPois = fitglme(data,modelFormula,'distribution','poisson');
lmBino = fitglme(data,modelFormula,'distribution','binomial','binomialSize',4);

% how much data in each dataset:
n_data = lmNorm.NumObservations

clf
subplot(1,3,1)
    plotCoeffLinearModel(lmPois)
    title(sprintf('Poisson. BIC=%g',lmPois.ModelCriterion.BIC))
subplot(1,3,2)
    plotCoeffLinearModel(lmBino)
    title(sprintf('Binomial. BIC=%g',lmBino.ModelCriterion.BIC))
subplot(1,3,3)
    plotCoeffLinearModel(lmNorm)
    title(sprintf('Normal. BIC=%g',lmNorm.ModelCriterion.BIC))
%%
lm2 = fitglme(data,'srh ~ bmi + fear + restHR + age + physact + sex + depr + lonely_t4t5','distribution','binomial','binomialSize',4);
clf
plotCoeffLinearModel(lm2)
%% comparing cross-sectional model to fixed effects model
data = TUdata;

data.physact = mycategorical(data.physact);
data.sex  = mycategorical(data.sex,'newNames',{'female','male'});
data.age = data.age/10;
data.depr = mycategorical(data.depr);
data.bmi = mycategorical(discretize(TUdata.bmi,[0,18.5,25,30,inf]),'newNames',{'under','norm','over','obese'});
data.restHR = data.restHR/10;


lm1 = fitglme(data(data.time==4,:),'srh ~ bmi + restHR + age + physact + sex + depr',...
    'distribution','normal');
lm2 = fitglme(data(data.time==5,:),'srh ~ bmi + restHR + age + physact + sex + depr',...
    'distribution','normal');
lm3 = fitglme(data(data.time==6,:),'srh ~ bmi + restHR + age + physact + sex + depr',...
    'distribution','normal');
lm4 = fitglme(data(data.time==7,:),'srh ~ bmi + restHR + age + physact + sex + depr',...
    'distribution','normal');
lm5 = fitglme(data,                'srh ~ bmi + restHR + age + physact + sex + depr',...
    'distribution','normal');
lm6 = fitglme(data,                'srh ~ bmi + restHR + age + physact + sex + depr + (1|id)',...
    'distribution','normal');
clf
subplot(161)
    plotCoeffLinearModel(lm1)
    title 'cross sectional (T4)'
subplot(162)
    plotCoeffLinearModel(lm2)
    title 'cross sectional (T5)'
subplot(163)
    plotCoeffLinearModel(lm3)
    title 'cross sectional (T6)'
subplot(164)
    plotCoeffLinearModel(lm4)
    title 'cross sectional (T7)'
subplot(165)
    plotCoeffLinearModel(lm5)
    title 'cross sectional (T6 and T7)'
subplot(166)
    plotCoeffLinearModel(lm6)
    title 'fixed effects (T6 and T7)'

