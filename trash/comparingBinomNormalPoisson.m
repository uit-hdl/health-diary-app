% In this model, I compare 3 models: Normal, poisson, bin(4,p_theta). I
% compare in barplot format their estimated coefficients. The main result
% is that their outputs are very similar. CIs vary in width, but the
% significance they produce are for practical purposes close enough. The
% Poisson model had considerably wider CIs than the other two.

%% data preparation
clear data

data.time = TUdata.time;
data.id   = TUdata.id;
data.age  = TUdata.age;
data.restHR = splitIntoCategories(TUdata.restHR,[50,65,80],'geq');
data.sex = mycategorical(TUdata.sex,'newName',{'female','male'});
data.physact1 = splitIntoCategories(TUdata.physact,1,"eq");
data.physact2 = splitIntoCategories(TUdata.physact,2,"eq");
data.physact3 = splitIntoCategories(TUdata.physact,3,"eq");
data.physact4 = splitIntoCategories(TUdata.physact,4,"eq");
data.physact23 = splitIntoCategories(TUdata.physact,[2,3],"eq");
data.physact34 = splitIntoCategories(TUdata.physact,[3,4],"eq");
data.physact = mycategorical(TUdata.physact);
data.physact234 = mergecats(data.physact,["2","3","4"]);
data.useless4 =  splitIntoCategories(TUdata.useless,4,"eq");
data.insomnia1 = splitIntoCategories(TUdata.insomnia,1,"eq");
data.insomnia2 = splitIntoCategories(TUdata.insomnia,2,"eq");
data.insomnia3 = splitIntoCategories(TUdata.insomnia,3,"eq");
data.insomnia4 = splitIntoCategories(TUdata.insomnia,4,"eq");
data.insomnia = mycategorical(TUdata.insomnia);
data.insomniaCon = TUdata.insomnia;
data.insomnia = mycategorical(TUdata.insomnia);

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
data.drinkFrq = categorical(TUdata.drinkFrq_t6t7);
data.srh  = TUdata.srh;
data.fear = TUdata.fear;
data.fear34 = mycategorical(splitIntoCategories(TUdata.srh,3,"geq"))

data.bmi = splitIntoCategories(TUdata.bmi,[18.5,25,30],"geq",{'under','norm','over','obese'})

data.friendsSupp = mycategorical(TUdata.friendsSupp_t6t7);
data.angina = splitIntoCategories(TUdata.angina,1,"geq",{'0','1'});
data = struct2table(data);
data = data(TUdata.time>=6,:);
%% First fit linear model
fixedVars = {'age','heartAttack','sex'};
decisionVars1 = {'physact','restHR','bmi','smoke','friendsSupp','depr','fear','useless',...
                'insomniaCon','drinkFrq'};
decisionVars2 = {'physact'};
interactionPart = {};
formula = getLinearModelFormula([fixedVars,decisionVars2,interactionPart,...
                                 {'(1|id)'}],'srh');
model = "normal";
if model=="binomial"
    lme = fitglme(data,formula,'distribution','binomial','binomialSize',4);
elseif model=="poisson"
    lme = fitglme(data,formula,'distribution','poisson');
elseif model=="normal"
    lme = fitglme(data,formula,'distribution','normal');
end
    
clf
plotCoeffLinearModel(lme)

