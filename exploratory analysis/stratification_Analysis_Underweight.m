% Here I explore how models look for different subgroups.

% underweight
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
data.physact12 = splitIntoCategories(TUdata.physact,[1,2],"eq");
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
%%
clf
histogram(data.bmi)
% get id of those who were underweight during T4:
Dt4 = data(data.time==4,:);
id_under_T4 = and(data.bmi=="under",data.time==4);
time = 4;
Irows = id2index_TUdata(data,id_under_T4,time)

subplot(211)
time = 4;
histogram(data.srh(id2index_TUdata(data,id_under_T4,time)))
subplot(212)
time = 7;
histogram(data.srh(id2index_TUdata(data,id_under_T4,time)))

modelData = data(findInd(data.bmi=="under"),:);

lm = fitglme(modelData,'srh ~ physact')





