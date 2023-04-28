% £££ *** ¤¤¤ THE GREAT VARIABLE FORGE ¤¤¤ *** £££
if not(exist('TUdata','var'))
    importLongData
end

clear data S

% time and id:
t = TUdata.t;
data.t = t;
data.id   = TUdata.id;

% ¤¤ BASIC INFORMATION ¤¤
data.age  = TUdata.age;
data.ageG = mycategorical(discretize(TUdata.age,[0,40,65,inf]));
data.ageG3 = splitIntoCategories(data.ageG,3,"eq");
data.age = TUdata.age/10;
data.old = mycategorical(splitIntoCategories(TUdata.age,65,"geq"),...
                            'newNames',{'0','1'}); 
data.sex = mycategorical(TUdata.sex,'newName',{'0','1'});
% ¤¤ SOCIAL STATUS ¤¤
data.liveWspouse = mycategorical(TUdata.liveWspouse,'newName',{'0','1'});
data.education = mycategorical(TUdata.educ);
data.friendsSupp = mycategorical(TUdata.friendsSupp_t6t7);
data.lonely = mycategorical(TUdata.lonely_t4t5);
data.lonely = mergecats(data.lonely,["3","4"]);
S.lonely = '45';
S.friendsSupp = '67';

% ¤¤ EXERCISE ¤¤
% *** exercise, T4-7 ***
data.physact1 = splitIntoCategories(TUdata.physact,1,"eq");
data.physact2 = splitIntoCategories(TUdata.physact,2,"eq");
data.physact3 = splitIntoCategories(TUdata.physact,3,"eq");
data.physact4 = splitIntoCategories(TUdata.physact,4,"eq");
data.physact23 = splitIntoCategories(TUdata.physact,[2,3],"eq");
data.physact34 = splitIntoCategories(TUdata.physact,[3,4],"eq");
data.PAleisure = splitIntoCategories(TUdata.physact,[1,2,3],"geq",{'1','2','3'});
S.physact = '45(hard)|67(leisure)';
% *** Exercise, T4-T5 ***
data.PAlight = mycategorical(TUdata.PAlight_t4t5);
data.PAhard  = mycategorical(TUdata.PAhard_t4t5);
data.PAhard4 = splitIntoCategories(TUdata.PAhard_t4t5,4,"eq")
S.PAlight = '45';
S.PAhard = '45';
% *** exercise, T6-T7 ***
data.PAfrqHigh = splitIntoCategories(TUdata.PAfrq_t6t7,4,'geq');
S.PAfrq = '67';
S.PAint = '67';
% combine level 1 and 2, and 3 and 4:
% C1: hrs/week < 1  ;  C2: 1 < times/week <=3  ;  C3: aprox. every day
data.PAfrq = mycategorical(discretize(TUdata.PAfrq_t6t7,[1,3,5,inf]));
data.PAfrqOrgl = mycategorical(TUdata.PAfrq_t6t7);
data.PAfrq1 = splitIntoCategories(data.PAfrq,1,'eq',{'0','1'});
data.PAfrq2 = splitIntoCategories(data.PAfrq,2,'eq',{'0','1'});
data.PAfrq3 = splitIntoCategories(data.PAfrq,3,'eq',{'0','1'});
data.PAint = mycategorical(TUdata.PAint);
data.PAint3 = splitIntoCategories(data.PAint,3,'eq',{'0','1'});
data.PAintHigh = splitIntoCategories(TUdata.PAint,2,'geq',{'0','1'});

data.PAf1i1 = myand(util_compare(data.PAfrq,'==','1'),util_compare(data.PAint,'==','1'));
data.PAf1i1 = mycategorical(data.PAf1i1);
data.PAf1i2 = myand(util_compare(data.PAfrq,'==','1'),util_compare(data.PAint,'==','2'));
data.PAf1i3 = myand(util_compare(data.PAfrq,'==','1'),util_compare(data.PAint,'==','3'));
% data.PAnonsense = mycategorical(myor(data.PAf1i2,data.PAf1i3));
data.PAf2i1 = myand(util_compare(data.PAfrq,'==','2'),util_compare(data.PAint,'==','1'));
data.PAf2i2 = myand(util_compare(data.PAfrq,'==','2'),util_compare(data.PAint,'==','2'));
data.PAf2i3 = myand(util_compare(data.PAfrq,'==','2'),util_compare(data.PAint,'==','3'));
data.PAf2i1 = mycategorical(data.PAf2i1);
data.PAf2i2 = mycategorical(data.PAf2i2);
data.PAf2i3 = mycategorical(data.PAf2i3);
data.PAf3i1 = myand(util_compare(data.PAfrq,'==','3'),util_compare(data.PAint,'==','1'));
data.PAf3i2 = myand(util_compare(data.PAfrq,'==','3'),util_compare(data.PAint,'==','2'));
data.PAf3i3 = myand(util_compare(data.PAfrq,'==','3'),util_compare(data.PAint,'==','3'));
data.PAf3i1 = mycategorical(data.PAf3i1);
data.PAf3i2 = mycategorical(data.PAf3i2);
data.PAf3i3 = mycategorical(data.PAf3i3);

X = categorical(nan(height(TUdata),1)); % they need to answer both questions to qualify
X(and(data.PAfrq=="1",data.PAint=="1")) = 'f1i1';
X(and(data.PAfrq=="1",data.PAint=="2")) = 'f1i2';
X(and(data.PAfrq=="1",data.PAint=="3")) = 'f1i3';
X(and(data.PAfrq=="2",data.PAint=="1")) = 'f2i1';
X(and(data.PAfrq=="2",data.PAint=="2")) = 'f2i2';
X(and(data.PAfrq=="2",data.PAint=="3")) = 'f2i3';
X(and(data.PAfrq=="3",data.PAint=="1")) = 'f3i1';
X(and(data.PAfrq=="3",data.PAint=="2")) = 'f3i2';
X(and(data.PAfrq=="3",data.PAint=="3")) = 'f3i3';
X = mergecats(X,{'f1i2','f1i3'});
X = renamecats(X,{'f1i2'},{'nonsense'});
X = mycategorical(X);
data.PA = X;

data.PAf23i23 = mycategorical(myor({X=='f2i2',X=='f2i3',X=='f3i2',X=='f3i3'}),'newNames',{'0','1'});
data.PAf23i2  = mycategorical(myor({X=='f2i2',X=='f3i2'}),'newNames',{'0','1'});
data.PAf2i12  = mycategorical(myor({X=='f2i1',X=='f2i2'}),'newNames',{'0','1'});
data.PAf23i3  = mycategorical(myor({X=='f2i3',X=='f3i3'}),'newNames',{'0','1'});
clear X

% ¤¤ CVD BIOMARKERS AND RISKFACTORS ¤¤
% *** BMI ***
data.bmi = splitIntoCategories(TUdata.bmi,[18.5,25,30],"geq");
data.bmi4 = splitIntoCategories(data.bmi,4,"eq");
data.bmi34 = splitIntoCategories(data.bmi,3,"geq");
data.hdl = TUdata.hdlChol;
data.bloodP = mycategorical(TUdata.highBP);
data.restHR = splitIntoCategories(TUdata.restHR,[50,65,80],'geq');
data.diab = mycategorical(TUdata.diab);
data.lipid = mycategorical(TUdata.lipid);
data.hypert = categorical(TUdata.hypertension);
data.hba1cCon = TUdata.glucoseHemoglob;
data.hba1c = splitIntoCategories(TUdata.glucoseHemoglob,[6.0,6.4],'geq');
data.glucoseHemog34 = splitIntoCategories(data.hba1c,3,'geq');
data.hba1c1 = splitIntoCategories(data.hba1c,1,'eq');
data.hba1c2 = splitIntoCategories(data.hba1c,2,'eq');
data.hba1c3 = splitIntoCategories(data.hba1c,3,'eq');
data.hba1c4 = splitIntoCategories(data.hba1c,4,'eq');
data.diabHba1c = splitIntoCategories(TUdata.glucoseHemoglob,6.4,'geq',{'0','1'});
% American Diabetes Association:
% elevated risk of pre-diabetes = 6-6.4
% elevated risk of pre-diabetes = 6.5--

% ¤¤ CARDIOVASCULAR EVENTS ¤¤
data.heartAttack = mycategorical(TUdata.heartAttack);
data.heartAttackRecent = mycategorical(TUdata.heartAttackRecent);
data.angina = splitIntoCategories(TUdata.angina,1,"geq",{'0','1'});
data.stroke = mycategorical(TUdata.stroke);
data.strokeOrHrtAtk = mycategorical(myor(cat2num(data.stroke),cat2num(data.heartAttack)));
data.strokOrHrtAtkOrOld = mycategorical(...
                    myor(cat2num(data.strokeOrHrtAtk),cat2num(data.old)));
% ¤¤ SMOKING AND ALCOHOL ¤¤
data.smokeNow = splitIntoCategories(TUdata.smoke,1,"eq",{'0','1'});
data.smokePrevious = splitIntoCategories(TUdata.smoke,2,"eq",{'0','1'});
data.smokeNever = splitIntoCategories(TUdata.smoke,3,"eq",{'0','1'});
data.smoking = mycategorical(TUdata.smoke);
S.smoking = '567';
S.smokePrevious = '567';
S.smokeNever = '567';
data.drinkFrq = categorical(TUdata.alcFreq_t6t7);
S.drinkFrq = '67';
data.drinkTimes = splitIntoCategories(TUdata.alcFreq_t4t5,[3,4,8],"geq");
S.drinkTimes = '45';

    
% ¤¤ MENTAL HEALTH ¤¤
data.useless4 =  splitIntoCategories(TUdata.useless,4,"eq");
data.useless = mycategorical(TUdata.useless,'mergeVar',{'3','4'});
S.useless = '567';
data.mentIll = mycategorical(TUdata.mentIllnesScore);
data.mentIll34 = mycategorical(splitIntoCategories(TUdata.mentIllnesScore,3,"geq",{'0','1'}));
data.depr4   = mycategorical(splitIntoCategories(TUdata.depr,4,"eq"));
data.depr34  = mycategorical(splitIntoCategories(TUdata.depr,3,"geq",{'0','1'}));
data.depr  = mycategorical(TUdata.depr);
data.anxiety = mycategorical(TUdata.worried);
S.anxiety = '567';
data.fear   = mycategorical(TUdata.fear);
data.fear34 = mycategorical(splitIntoCategories(TUdata.fear,3,"geq"))

% ¤¤ SLEEP ¤¤
data.insomnia1 = splitIntoCategories(TUdata.insomnia_t5t6t7,1,"eq");
data.insomnia2 = splitIntoCategories(TUdata.insomnia_t5t6t7,2,"eq");
data.insomnia3 = splitIntoCategories(TUdata.insomnia_t5t6t7,3,"eq");
data.insomnia4 = splitIntoCategories(TUdata.insomnia_t5t6t7,4,"eq");
data.insomnia234 = splitIntoCategories(TUdata.insomnia_t5t6t7,2,"geq",{'0','1'});
data.insomnia34 = splitIntoCategories(TUdata.insomnia_t5t6t7,3,"geq",{'0','1'});
data.insomniaCon = TUdata.insomnia_t5t6t7;
data.insomnia = mycategorical(TUdata.insomnia_t5t6t7);
S.insomnia = '567';
data.insomniaFrq = mycategorical(TUdata.insomnia_t4t5t6);
data.insomniaFrq234 = splitIntoCategories(data.insomniaFrq,2,"geq");
S.insomniaFrq = '456';

% ¤¤ TARGET VARIABLE ¤¤
data.srh  = TUdata.srh;


data = struct2table(data);
S = struct2table(S)

