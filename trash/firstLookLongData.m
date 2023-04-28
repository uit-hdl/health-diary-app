theGreatVariableForge

%% What is significance of underweight influenced by other covariates?
vars = ["bmi" "smoking" "useless" "fear" "PAfrq" "friendsSupp"]
sum(vars' == data.Properties.VariableNames,2)
formula = getLinearModelFormula([vars,...
                                 {'(1|id)'}],'srh');
lme = fitglme(data,formula);
clf
plotCoeffLinearModel(lme)
% correlationTable(data(data.t==6,:),{'bmi','smokeNow'})
% As I add more and more variables that reflect poor mental health or
% state, I see more and more drop in significance of the underweight
% variable. This suggests that underweight itself may not be as harmful to
% health as we thought, but rather is symptomatic of mental health
% symptoms. Adding smoking also lowers the significance of underweight.
% This makes some sense since underweight correlates with smoking.
%% How does PA frequency and intensity interact?
formula = strcat('srh ~ PAfrq + PAint + PAfrq:PAint + (1|id)')
lme = fitglme(data(t>=6,:),formula);
lme.Coefficients
B = getModelDefaultCategories(lme,data) %#ok<*NASGU>
clf
plotCoeffLinearModel(lme)
% Conclusion: The results are mixed. On one hand, if both intensity and
% frequency are low, then the interaction term slightly dampens the sum of
% the negative effects, which is likely due to the fact that these
% variables overlap somewhat, so without the interaction term we would be
% overcounting (same penalty twice). Low frequency combined with high
% intensity is associated with lower SRH than the baseline, suggesting that
% high intensity combined with low frequency is not idea for health
% outcomes. High intensity and frequency interacts positively, meaning that
% the combination is greater than the sum of the parts.
% Conclusion: for ideal health outcomes, the individual should get PA
% often, but should also work out rigerously as well.
%% How is BMI associated with physical activity?
lme = fitlme(data,'bmi_c ~ physact + (1|id)');
lme.Coefficients
% 
%% Main model number one. Separate mental health scores.
modelData = data(t>=6,:);
fixedVars = {'ageG','liveWspouse','strokeOrHrtAtk','sex','diabHba1c'};
decisionVars = {'PAnonsense','PA21','PA11','PA23','PA31','PA32','PA33',...
                'bmi','hypert','smokeNow',...  
                'friendsSupp','mentIll','insomnia'};
interactionPart = {'bmi:old','smokeNow:old',...
                   'PAf23i23:smokeNow','old:insomnia4','old:PA33',...
                   'insomnia34:PA22','insomnia34:PA33','bmi34:PA22'};
vars = [fixedVars,decisionVars,interactionPart]
formula = getLinearModelFormula([fixedVars,decisionVars,interactionPart,...
                                 {'(1|id)'}],'srh');
close all
lme = fitglme(modelData,formula);
lme.Coefficients

B = getModelDefaultCategories(lme,data)
figure
plotCoeffLinearModel(lme)
title 'Main model' 
clear modelData
%   ACCEPTED ¤¤ current and previous smokers are now treated as two
% categories. 
%   ACCEPTED ¤¤ Use Mental Health Index score as representation of
% mental health.
%   ACCEPTED ¤¤ Remove angina, as it becomes insignificant when
% mental health is included.
%	ACCEPTED ¤¤ Use mental health index to measure mental health.
%   ACCEPTED ¤¤ Remove Education. I've looked at the effect of
% removing this variable, and no variables of interest (exercise, mental
% health, insomnia etc.) are noticably affected in terms of their reported
% effect.
%   ACCEPTED ¤¤ Remove drink. The effect of the lifestyle variables
% (exercise, sleep, smoking etc...) were not affected that much. 
%   ACCEPTED ¤¤ Do not include anxiety; it does not improve model accuracy.

% hdl --> cholesterol. hypolipedemia (höy blodfett)
% kan slette LIPID_LOWERING_DRUGS_T6 ==1
% alcohol -- utdannelsenivå. Reverse causality alcohol consumption.
% funnet blodsukker. 6.5 cutoff. HBA1C_T7.
%% Why is Angina associated with better SRH in the above model?
fixedVars = {'age','liveWspouse','education','strokeOrHrtAtk','angina','sex','glucoseHemog'};
decisionVars = {'PAfrq','physact34','bmi','hypert','hdl','smokeNow'};
interactionPart = {'bmi:old','smokeNow:old',...
                   'physact34:smokeNow','old:insomnia4','old:physact34',...
                   'PAfrq3:physact34'};
formula = getLinearModelFormula([fixedVars,decisionVars,interactionPart,...
                                 {'(1|id)'}],'srh');
close all
lme = fitglme(data(t>=6,:),formula);
lme.Coefficients
B = getModelDefaultCategories(lme,data)
figure
plotCoeffLinearModel(lme)
title 'Main model' 
% Conclusion: The strong association of angina on poor SRH seems to be due
% to its strong correlation (0.39) with poor mental health index; before I
% add mental health index into the model, angina has a very strong negative
% association with SRH, but after I add mental health, its negative impact
% goes away, and even becomes slightly positive.
%% Why is age no longer significant?
fixedVars = {'age','education','sex','diabHba1c'};
decisionVars = {'PAfrq','physact34','bmi','hypert','hdl','smokeNow',...  
                'friendsSupp','mentIll','insomnia','drinkFrq'};
interactionPart = {'bmi:old','smokeNow:old',...
                   'physact34:smokeNow','old:insomnia4','old:physact34',...
                   'PAfrq3:physact34'};
formula = getLinearModelFormula([fixedVars,decisionVars,interactionPart,...
                                 {'(1|id)'}],'srh');
close all
lme = fitglme(data(t>=6,:),formula);
lme.Coefficients
B = getModelDefaultCategories(lme,data)
figure
plotCoeffLinearModel(lme)
title 'Main model' 
% removing education makes age highly significant again. It seems that
% education acts as a surrogate measure for age. Also, remving the variable
% 'strokeOrHrtAtck' makes age highly significant again. It seems that these
% kinds of age related variables account for the effect of aging.
%% replace phsyact23 with PAintHigh (EXERCISE_LEVEL vs PHYS_ACTIVITY_LEISURE)
fixedVars = {'age:age','strokeOrHrtAtk','sex','angina','diab'};
decisionVars = {'PAfrq','PAintHigh','bmi','hypert','smoking',...  
                'friendsSupp','mentIll','insomnia','drinkFrq'};
interactionPart = {'bmi:old','smokeNow:old',...
                   'PAintHigh:smokeNow','old:insomnia4','old:PAintHigh',...
                   'PAfrq3:PAintHigh'};
formula = getLinearModelFormula([fixedVars,decisionVars,interactionPart,...
                                 {'(1|id)'}],'srh');
lme = fitglme(data(t>=6,:),formula);
lme.Coefficients
close all;
figure
plotCoeffLinearModel(lme)
title 'using EXERCISE_LEVEL to measure intensity'
% I see same general trends as when I use PHYS_ACTIVITY_LEISURE>=3 to
% measure intensity. However, the significance of the interaction between
% old age and intense physical exercise is lower. I prefer to use physact34
% to measure high intensity exercise.
%% Main model. Mental health captured by MENTAL HEALTH INDEX
fixedVars = {'age:age','strokeOrHrtAtk','sex','angina','diab'};
decisionVars = {'PAfrq','physact34','bmi','hypert','hdl','smoking',...  
                'friendsSupp','mentIll','anxiety','insomnia','drinkFrq'};
interactionPart = {'bmi:old','smokeNow:old',...
                   'physact34:smokeNow','old:insomnia4','old:physact34',...
                   'PAfrq4:physact34','angina:strokeOrHrtAtk','bmi2:sex','friendsSupp:sex'};
formula = getLinearModelFormula([fixedVars,decisionVars,interactionPart,...
                                 {'(1|id)'}],'srh');
lme = fitglme(data(t>=6,:),formula);
lme.Coefficients
close all
figure
plotCoeffLinearModel(lme)
title 'using mental health index to represent mental health'
% The underweight category is now less significant. Perhaps this model
% better captures mental health issues, and since so many cases of
% underweight are explained by poor mental health, this can explain why the
% significance drops in this model.
%% Is intense PA a bad idea for those who have had a heart attack?
fixedVars = {'age','heartAttack','sex','angina'};
decisionVars = {'physact','PAfrq','bmi','bloodP','smoking',...
                'friendsSupp','depr','worried','insomnia','drinkFrq'};
interactionPart = {'bmi:old','smokeNow:old',...
                   'physact34:smokeNow','old:insomnia4','heartAttack:physact34'};
formula = getLinearModelFormula([fixedVars,decisionVars,interactionPart,...
                                 {'(1|id)'}],'srh');
lme = fitglme(data(t>=6,:),formula);
close all;
figure
plotCoeffLinearModel(lme)
% There is a negative interaction between heart attack and intense physical
% exercise, but it is not very significant (p<0.1). Might be due to small
% sample size. Interaction with old age way more significant, but, againg,
% that could be due to a larger sample size of old people than people
% who've had heart attack.

%% fit cross sectional model:
fitglm(data,'srh ~ drink')

%% analysis of Micheal
Ival = myand({isval(XX.physact), isval(XX.srh)});
age = 6; % age in decade
physact = categorical(1);
id = 0; % assign arbitrary id; does not matter.
srh = 3;
depr = categorical(2);
smoke = categorical(1);

micheal_0 = table(age,physact,smoke,depr,id);
micheal_1 = micheal_0;
micheal_2 = micheal_0;
micheal_3 = micheal_0;
micheal_4 = micheal_0;

micheal = table(age,physact,smoke,depr,id);

micheal_1.physact = categorical(min(double(micheal_0.physact) + 1,4));
micheal_2.physact = categorical(min(double(micheal_0.physact) + 2,4));
micheal_3.smoke = categorical( max(double(micheal_0.smoke) - 1,0) );
micheal_4.depr  = categorical( max(cat2double(micheal_0.depr) - 1,0) );

p(1) = dec2perc( 1-binocdf(3 -1,4,lme.predict(micheal_0)));
p(2) = dec2perc( 1-binocdf(3 -1,4,lme.predict(micheal_1)));
p(3) = dec2perc( 1-binocdf(3 -1,4,lme.predict(micheal_2)));
p(4) = dec2perc( 1-binocdf(3 -1,4,lme.predict(micheal_3)));
p(5) = dec2perc( 1-binocdf(3 -1,4,lme.predict(micheal_4)));

colNames = ["current condition","add 0-1 hrs ex./week","add 1-2 hrs ex./week",...
            "stop smoking", "Improve depression"];

T = array2table(p,'v',colNames);

T(2,:) = num2cell(p - p0_atleast3);
T{2,1} = nan
T.Properties.RowNames = ["prob. (%)" "prob. increase (%)"]
giveTitle2table(micheal,"Mikael")
T = giveTitle2table(T,"*** PROBABILITY SRH ATLEAST GOOD ***")

%% 
% lme = fitlme(data,'srh ~ physact + useless + useless:physact + age + bmi*bmi + angina + old + angina:physact + (1|id)');

lme = fitlme(data,'srh ~ physact + friendsSupp + useless + depr + bin_useless4:bin_physact4 + age:age + bmi*bmi + angina + bin_physact34:bin_angina + (1|id)');
lme.Coefficients
%% poisson regression
lmePoisson = fitglme(data,'srh ~ physact + age + useless + (1|id)','distribution','poisson')%,'CategoricalVars',["srh"]);
lmePoisson.Coefficients
%% binomial regression (srh = 0 or 1)
lmeBin = fitglme(data,'bin_srh ~ bin_fear + physact + physact:bin_fear + (1|id)','distribution','binomial');
lmeBin.Coefficients
%%
lme = fitlme(data,'srh ~ friendsSupp + (1|id)');
lme.Coefficients
%%
lme = fitlme(data,'srh ~ physact + (1|id)');
lme.Coefficients
% very significant interaction between useless==4 and physact==4,
% indicating that people who exercise might recieve extra benefit from high
% volume of exercise.
%%
lme = fitlme(data,'srh ~ physact + useless + useless:physact + age + (1|id)');
lme.Coefficients

%%
I_uselessT6 = and(data.useless=="4",data.time==6);
id_uselessT6 = data.id(I_uselessT6);
data.srh(I_uselessT6)
close
figure()
subplot(221)
histogram(data.srh(I_uselessT6))
title 'SRH of worthless T6'
subplot(222)
histogram(data.physact(I_uselessT6))
title 'PA of worthless T6'

I_uselessT6_T7 = findInd(data.id(data.time==7),id_uselessT6)
subplot(223)
histogram(data.srh(I_uselessT6_T7))
title 'T7-SRH of those worthless in T6'
subplot(224)
histogram(data.physact(I_uselessT6_T7))
title 'T7-physact of those worthless in T6'

% Those who reported feeling worthless in T6 are about average in terms of
% SRH T7. We see clearly that those who felt worthless during T6 exercised
% very little, whereas in T7 they have approximately normal exercise
% levels.
%% investigate subgroup who felt useless in T6
id_t6t7 = S.id.t6andt7;
I_t6t7 = findInd(data.id,id_t6t7);
I_uselessT6 = and(data.useless=="4",data.time==6);
id_uselessT6 = data.id(I_uselessT6)
id_uselessT6_presentT7 = intersect(id_uselessT6,S.id.t7);
I_uselessT6_presentT7 = findInd(data.id,id_uselessT6_presentT7);

I_T6rows_uselessT6_presentT7 = and(data.time==6, I_uselessT6_presentT7);
I_T7rows_uselessT6_presentT7 = and(data.time==7, I_uselessT6_presentT7);

SRHuselessT6 = sortrows([data.id(I_T6rows_uselessT6_presentT7),...
                        data.srh(I_T6rows_uselessT6_presentT7)],1) %#ok<*NOPTS>
PAuselessT6 = sortrows([data.id(I_T6rows_uselessT6_presentT7),...
            double(data.physact(I_T6rows_uselessT6_presentT7))],1)

SRHuselessT7 = sortrows([data.id(I_T7rows_uselessT6_presentT7),...
                        data.srh(I_T7rows_uselessT6_presentT7)])
PAuselessT7 = sortrows([data.id(I_T7rows_uselessT6_presentT7),...
                 double(data.physact(I_T7rows_uselessT6_presentT7))])

PAdiff = PAuselessT7(:,2)-PAuselessT6(:,2);
SRHdiff = SRHuselessT7(:,2)-SRHuselessT6(:,2);
% get p-value for correlation:
[c,pval] = corr(PAdiff,SRHdiff,'rows','complete')
% not significant correlation
array2table([SRHuselessT6,SRHuselessT7(:,2),PAuselessT6(:,2),PAuselessT7(:,2)...
    PAuselessT7(:,2)-PAuselessT6(:,2),SRHuselessT7(:,2)-SRHuselessT6(:,2)],...
    'v',{'id','SRH T6','SRH T7','PA T6','PA T7','PA diff','SRH diff'})
%% 
id_t6t7 = S.id.t6andt7;
I_t6t7 = findInd(data.id,id_t6t7);
I_uselessT7 = and(data.useless=="4",data.time==7);
id_uselessT7 = data.id(I_uselessT7)
id_uselessT7_presentT6 = intersect(id_uselessT7,S.id.t6);
I_uselessT7_presentT6 = findInd(data.id,id_uselessT7_presentT6);

I_T6rows_uselessT7_presentT6 = and(data.time==6, I_uselessT7_presentT6);
I_T7rows_uselessT7_presentT6 = and(data.time==7, I_uselessT7_presentT6);

SRHuselessT6 = sortrows([data.id(I_T6rows_uselessT7_presentT6),...
                        data.srh(I_T6rows_uselessT7_presentT6)],1) %#ok<*NOPTS>
PAuselessT6 = sortrows([data.id(I_T6rows_uselessT7_presentT6),...
            double(data.physact(I_T6rows_uselessT7_presentT6))],1)

SRHuselessT7 = sortrows([data.id(I_T7rows_uselessT7_presentT6),...
                        data.srh(I_T7rows_uselessT7_presentT6)])
PAuselessT7 = sortrows([data.id(I_T7rows_uselessT7_presentT6),...
                 double(data.physact(I_T7rows_uselessT7_presentT6))])

PAdiff = PAuselessT7(:,2)-PAuselessT6(:,2);
SRHdiff = SRHuselessT7(:,2)-SRHuselessT6(:,2);
% get p-value for correlation:
[c,pval] = corr(PAdiff,SRHdiff,'rows','complete')
% just barely significant corelation between change in PA-level and change
% in SRH.
array2table([SRHuselessT6,SRHuselessT7(:,2),PAuselessT6(:,2),PAuselessT7(:,2)...
    PAuselessT7(:,2)-PAuselessT6(:,2),SRHuselessT7(:,2)-SRHuselessT6(:,2)],...
    'v',{'id','SRH T6','SRH T7','PA T6','PA T7','PA diff','SRH diff'})



% I have so far not found strong evidence for the positive interaction
% between physical activity-level-4 and useless-level-4. Perhaps, the
% explanation is that people who execise hard and then stop exercising have
% a significantly greater chance of feeling useless? Maybe exercise
% protects against the effect of feeling useless?



