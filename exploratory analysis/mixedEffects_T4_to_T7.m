% in this script I explore using data from participants who joined T4 to
% T7.
clear data

data.t = TUdata.t;
data.id   = TUdata.id;
data.age  = TUdata.age;
data.restHR = splitIntoCategories(TUdata.restHR,[50,65,80],'geq');
data.sex = mycategorical(TUdata.sex,'newName',{'female','male'});
data.physact1 = splitIntoCategories(TUdata.physact,1,"eq");
data.physact2 = splitIntoCategories(TUdata.physact,2,"eq");
data.physact3 = splitIntoCategories(TUdata.physact,3,"eq");
data.physact4 = splitIntoCategories(TUdata.physact,4,"eq");
data.physact34 = splitIntoCategories(TUdata.physact,3,"geq");

data.physact = mycategorical(TUdata.physact);
data.physact234 = mergecats(data.physact,["2","3","4"]);
data.useless4 =  splitIntoCategories(TUdata.useless,4,"eq");

data.PAlight = mycategorical(TUdata.PAlight_t4t5,'newNames',{'0','1','2','3'});
data.PAhard  = mycategorical(TUdata.PAhard_t4t5,'newNames',{'0','1','2','3'});
data.PAleisure = mycategorical(TUdata.PAleisure_t6t7,'newNames',{'0','1','2','3'})
data.PAlight34 = splitIntoCategories(TUdata.PAlight_t4t5,3,"geq");
data.PAlight4 = splitIntoCategories(TUdata.PAlight_t4t5,4,"geq");
data.PAhard34 = splitIntoCategories(TUdata.PAhard_t4t5,3,"geq");
data.PAhard4 = splitIntoCategories(TUdata.PAhard_t4t5,4,"geq");


data.insomnia1 = splitIntoCategories(TUdata.insomnia,1,"eq");
data.insomnia2 = splitIntoCategories(TUdata.insomnia,2,"eq");
data.insomnia3 = splitIntoCategories(TUdata.insomnia,3,"eq");

data.insomnia4 = splitIntoCategories(TUdata.insomnia,4,"eq");
data.insomnia = mycategorical(TUdata.insomnia);
data.insomniaCon = TUdata.insomnia;
data.diab = mycategorical(TUdata.diab);

data.heartAttack = splitIntoCategories(TUdata.heartAttack,1,"geq",{'0','1'});

data.useless = mycategorical(TUdata.useless,'mergeVar',{'3','4'});
data.depr4   = mycategorical(splitIntoCategories(TUdata.depr,4,"eq"));
data.depr    = mycategorical(TUdata.depr);
data.worried = mycategorical(TUdata.worried);
data.old = mycategorical(splitIntoCategories(TUdata.age,65,"geq"),...
                            'newNames',{'0','1'});
data.ageG = mycategorical(discretize(TUdata.age,[0,40,65,inf]));
data.age = TUdata.age/10;

data.smoke = splitIntoCategories(TUdata.smoke,1,"eq");
data.srh  = TUdata.srh;
data.fear = TUdata.fear;
data.fear34 = mycategorical(splitIntoCategories(TUdata.srh,3,"geq"))

data.bmi = splitIntoCategories(TUdata.bmi,[18.5,25,30],"geq",...
                                    {'under','norm','over','obese'})

% data.bmiUnder = splitIntoCategories(data.bmi,1,"eq");
% data.bmiNorm  = splitIntoCategories(data.insomnia,2,"eq");
% data.bmiOver  = splitIntoCategories(data.insomnia,3,"eq");
% data.bmiObese = splitIntoCategories(data.insomnia,3,"eq");

data.friendsSupp = mycategorical(TUdata.friendsSupp_t6t7);
data.angina = splitIntoCategories(TUdata.angina,1,"geq",{'0','1'});
data = struct2table(data);
%%
data = data(data.t<6,:);
%%
formula = getLinearModelFormula([fixedVars,decisionVars,interactionTerms,...
                                 {'(1|id)'}],'srh');
lme = fitglme(data,'srh~ PAlight34 + PAhard34 + PAlight34:PAhard34 + (1|id)','distribution','normal');
figure
plotCoeffLinearModel(lme)

%%
fixedVars = {'age','heartAttack','sex'};
decisionVars = {'PAlight','PAhard','bmi','depr'};
interactionTerms = {'PAlight:PAhard'};
formula = getLinearModelFormula([fixedVars,decisionVars,interactionTerms,...
                                 {'(1|id)'}],'srh');
lme = fitglme(data,formula,'distribution','normal');
figure
plotCoeffLinearModel(lme)
%% Do the differences in PA definitions matter?
lm45 = fitglme(data(data.t<6,:),'srh~physact+(1|id)');
lm67 = fitglme(data(data.t>5,:),'srh~physact+(1|id)');
figure
subplot(211)
    t = plotCoeffLinearModel(lm45)
    title(strcat('T4-T5; ',t));
subplot(212)
    t = plotCoeffLinearModel(lm67)
    title(strcat('T6-T7; ',t));
% yes, they do. In T6 and T7, PA level influences SRH more strongly than in
% T4-T5.
%% Investigate the differences when using original definitions:
lm45light = fitglme(data(data.t<=5,:),'srh~PAlight+(1|id)');
lm45hard = fitglme(data(data.t<=5,:),'srh~PAhard+(1|id)');
lm67 = fitglme(data(data.t>=6,:),'srh~PAleisure+(1|id)');
figure
subplot(131)
    t = plotCoeffLinearModel(lm45light)
    title(strcat('T4-T5 light PA; ',t));
subplot(132)
    t = plotCoeffLinearModel(lm45hard)
    title(strcat('T4-T5 hard PA; ',t));
subplot(133)
    t = plotCoeffLinearModel(lm67)
    title(strcat('T6-T7 leisure PA; ',t));
%% Fit model uin both hard and ligth PA as predictors:
lm = fitglme(data(data.t<=5,:),'srh ~ PAlight + PAhard + PAlight:PAhard + (1|id)');
close all
plotCoeffLinearModel(lm)

