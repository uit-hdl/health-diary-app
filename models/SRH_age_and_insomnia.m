
modelData = data(data.t>=6,:);
lme1 = fitglme(modelData,'srh ~ age*age + insomnia + age*insomnia + (1|id)');
lme2 = fitglme(modelData,'srh ~ age*age + insomnia + age:age*insomnia + (1|id)');
lme3 = fitglme(modelData,'srh ~ age*age + insomnia + old*insomnia + (1|id)');

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
%% Manual Investigation
if ~exist('TUwide','var')
    importWideData
end

srh6 = TUwide.srh6;
age6 = TUwide.AGE_T6;
insomn6 = TUwide.INSOMNIA_T6;


srh7 = TUwide.srh7;
age7 = TUwide.AGE_T7;
insomn7 = TUwide.INSOMNIA_T7;

close all
figure
subplot(121)
    I = and(data.t==7,data.age<6.5);
    findMeanForEachCat(data.insomnia(I),data.srh(I),true)       
    title 'age < 65'
    xlim([0,5])
    ylim([2,3])
    
subplot(122)
    I = and(data.t==7, data.age>=6.5);
    findMeanForEachCat(data.insomnia(I),data.srh(I),true)       
    title 'age >= 65'
    xlim([0,5])
    ylim([2,3])
%%
figure
subplot(121)
barh([mean(srh7(and(age6<=65, insomn6==1)),'o'),...
      mean(srh7(and(age6<=65, insomn6==2)),'o'),...
      mean(srh7(and(age6<=65, insomn6==3)),'o'),...
      mean(srh7(and(age6<=65, insomn6==4)),'o')])
  xlim([1,3])
subplot(122)
barh([mean(srh7(and(age7<=65, insomn7==1)),'o'),...
      mean(srh7(and(age7<=65, insomn7==2)),'o'),...
      mean(srh7(and(age7<=65, insomn7==3)),'o'),...
      mean(srh7(and(age7<=65, insomn7==4)),'o')])
  xlim([1,3])

