% Script for generating new column variables and collecting relevant
% variables in a new datastructure called 'data'

if ~exist('TUdata', 'var')
    importLongData
end
renameVariablesOfInterest
%#ok<*NBRAK2>
clear data S
% choose which variable version to use:
settings.insomnia = "v2";

% time and id:
t = TUdata.t;
data.t = t;
data.id = TUdata.id;

% ¤¤ GENRAL INFORMATION ¤¤
data.age = TUdata.age;
data.ageG = mycategorical(discretize(TUdata.age, [0, 40, 65, inf]));
data.ageG3 = splitIntoCategories(data.ageG, 3, "eq");
data.age = TUdata.age / 10;
data.old = mycategorical(splitIntoCategories(TUdata.age, 65, "geq"), ...
    'newNames', {'0', '1'});
data.sex = mycategorical(TUdata.sex, 'newName', {'0', '1'});

% ¤¤ SOCIAL STATUS ¤¤
data.liveWspouse = mycategorical(TUdata.liveWspouse, 'newName', {'0', '1'});
data.education = mycategorical(TUdata.educ);
data.friendsSupp = mycategorical(TUdata.friendsSupp_t6t7);
data.lonely = mycategorical(TUdata.lonely_t4t5);
data.lonely = mergecats(data.lonely, ["3", "4"]);

% ¤¤ PHYSICAL EXERCISE ¤¤
% exercise, T4-7 ***
data.physact1 = splitIntoCategories(TUdata.physact, 1, "eq");
data.physact2 = splitIntoCategories(TUdata.physact, 2, "eq");
data.physact3 = splitIntoCategories(TUdata.physact, 3, "eq");
data.physact4 = splitIntoCategories(TUdata.physact, 4, "eq");
data.physact23 = splitIntoCategories(TUdata.physact, [2, 3], "eq");
data.physact34 = splitIntoCategories(TUdata.physact, [3, 4], "eq");
data.PAleisure = splitIntoCategories(TUdata.physact, [1, 2, 3], "geq", {'1', '2', '3'});
% *** Exercise, T4-T5 ***
data.PAlight = mycategorical(TUdata.PAlight_t4t5);
data.PAhard = mycategorical(TUdata.PAhard_t4t5);
data.PAhard4 = splitIntoCategories(TUdata.PAhard_t4t5, 4, "eq")
% *** exercise, T6-T7 ***
data.PAfrqHigh = splitIntoCategories(TUdata.PAfrq_t6t7, 4, 'geq');
% combine level 1 and 2, and 3 and 4:
% C1: hrs/week < 1  ;  C2: 1 < times/week <=3  ;  C3: aprox. every day
data.PAfrq = mycategorical(TUdata.PAfrq_t6t7);
data.PAfrq = mergecats(data.PAfrq, ["1", "2"])
data.PAfrq = renamecats(data.PAfrq, ["1", "3", "4", "5"], ["1", "2", "3", "4"])
data.PAfrq1 = splitIntoCategories(data.PAfrq, 1, 'eq', {'0', '1'});
data.PAfrq2 = splitIntoCategories(data.PAfrq, 2, 'eq', {'0', '1'});
data.PAfrq3 = splitIntoCategories(data.PAfrq, 3, 'eq', {'0', '1'});
data.PAfrq4 = splitIntoCategories(data.PAfrq, 4, 'eq', {'0', '1'});
data.PAint = mycategorical(TUdata.PAint_t6t7);
data.PAint1 = splitIntoCategories(data.PAint, 1, 'eq', {'0', '1'});
data.PAint2 = splitIntoCategories(data.PAint, 2, 'eq', {'0', '1'});
data.PAint3 = splitIntoCategories(data.PAint, 3, 'eq', {'0', '1'});
data.PAintHigh = splitIntoCategories(TUdata.PAint_t6t7, 2, 'geq', {'0', '1'});

X = categorical(nan(height(TUdata), 1)); % they need to answer both questions to qualify
for i_frq = 1:4
    for i_int = 1:3
        var_name = sprintf('f%gi%g', i_frq, i_int);
        X(and(data.PAfrq == string(i_frq), data.PAint == string(i_int))) = var_name;
    end
end
data.PA_nonsense = or(X == "f1i2", X == "f1i3")
% X = mergecats(X, {'f1i1', 'f1i2', 'f1i3'});
% X = renamecats(X, {'f1i1'}, {'f1'});
X = mycategorical(X);
data.PA = X;

% moderation group:
data = create_tailorMade_PAcategories(X, data, [2, 3], [2])
data = create_tailorMade_PAcategories(X, data, [2, 3], [2, 3])
% any exercise at all group:
data = create_tailorMade_PAcategories(X, data, [2, 3, 4], [1, 2, 3])
% regular exercisers:
data = create_tailorMade_PAcategories(X, data, [2, 3, 4], [1, 2, 3])
data = create_tailorMade_PAcategories(X, data, [2, 3, 4], [2, 3])
% high frequency and intensity groups
data = create_tailorMade_PAcategories(X, data, [4], [3])
data = create_tailorMade_PAcategories(X, data, [4], [2, 3])
data = create_tailorMade_PAcategories(X, data, [3, 4], [3])
data = create_tailorMade_PAcategories(X, data, [3, 4], [2, 3])
% high frequency groups
data = create_tailorMade_PAcategories(X, data, [4], [1, 2, 3])
data = create_tailorMade_PAcategories(X, data, [3, 4], [1, 2, 3])
% high intensity group
data = create_tailorMade_PAcategories(X, data, [2, 3, 4], [3])
data = create_tailorMade_PAcategories(X, data, [3, 4], [3])
data = create_tailorMade_PAcategories(X, data, [3], [3])

clear X

% ¤¤ BIOMARKERS AND CARDIOVASCULAR RISKFACTORS ¤¤
% *** BMI ***
data.bmiCont = TUdata.bmi;
data.bmi = splitIntoCategories(TUdata.bmi, [18.5, 25, 30], "geq");
data.bmi1 = splitIntoCategories(data.bmi, 1, "eq");
data.bmi2 = splitIntoCategories(data.bmi, 2, "eq");
data.bmi3 = splitIntoCategories(data.bmi, 3, "eq");
data.bmi4 = splitIntoCategories(data.bmi, 4, "eq");
data.bmi34 = splitIntoCategories(data.bmi, 3, "geq", {'0', '1'});
% *** Risk factors ***
data.hdl = TUdata.hdlChol;
data.highBP = mycategorical(TUdata.highBP);
data.restHR = splitIntoCategories(TUdata.restHR, [50, 65, 80], 'geq');
data.diab = mycategorical(TUdata.diab);
data.lipid = mycategorical(TUdata.lipid);
data.hypert = categorical(TUdata.hypertension);
data.hba1cCon = TUdata.glucoseHemoglob;
data.hba1c = splitIntoCategories(TUdata.glucoseHemoglob, [6.0, 6.4], 'geq');
data.glucoseHemog34 = splitIntoCategories(data.hba1c, 3, 'geq');
% *** Blood sugar levels and Diabetes ***
data.hba1c1 = splitIntoCategories(data.hba1c, 1, 'eq');
data.hba1c2 = splitIntoCategories(data.hba1c, 2, 'eq');
data.hba1c3 = splitIntoCategories(data.hba1c, 3, 'eq');
data.hba1c4 = splitIntoCategories(data.hba1c, 4, 'eq');
data.diabHba1c = splitIntoCategories(TUdata.glucoseHemoglob, 6.4, 'geq', {'0', '1'});
% American Diabetes Association:
% elevated risk of pre-diabetes = 6-6.4
% elevated risk of pre-diabetes = 6.5--

% ¤¤ COMORBID DISEASES ¤¤
data.hii = TUdata.hii;
data.cancer = splitIntoCategories(TUdata.cancer, 1, "geq", {'0', '1'});
data.heartAttack = mycategorical(TUdata.heartAttack);
data.heartAttackRecent = mycategorical(TUdata.heartAttackRecent);
data.angina = splitIntoCategories(TUdata.angina, 1, "geq", {'0', '1'});
data.stroke = mycategorical(TUdata.stroke);
data.strokeOrHrtAtk = mycategorical(myor(cat2num(data.stroke), cat2num(data.heartAttack)));
data.strokOrHrtAtkOrOld = mycategorical( ...
    myor(cat2num(data.strokeOrHrtAtk), cat2num(data.old)));

% ¤¤ SMOKING AND ALCOHOL ¤¤
data.smokeNow = splitIntoCategories(TUdata.smoke, 1, "eq", {'0', '1'});
data.smokePrevious = splitIntoCategories(TUdata.smoke, 2, "eq", {'0', '1'});
data.smokeNever = splitIntoCategories(TUdata.smoke, 3, "eq", {'0', '1'});
data.smoking = mycategorical(TUdata.smoke);
data.drinkFrq = categorical(TUdata.alcFreq_t6t7);
data.drinkTimes = splitIntoCategories(TUdata.alcFreq_t4t5, [3, 4, 8], "geq");

% ¤¤ MENTAL HEALTH ¤¤
data.useless4 = splitIntoCategories(TUdata.useless_t5t6t7, 4, "eq");
data.useless = mycategorical(TUdata.useless_t5t6t7, 'mergeVar', {'3', '4'});
data.hscl = TUdata.HSCLcalc; % my calculated variable
data.mentIll = mycategorical(TUdata.HSCL_GROUP);
data.mentIll34 = mycategorical(splitIntoCategories(TUdata.HSCL_GROUP, 3, "geq", {'0', '1'}));
data.depr4 = mycategorical(splitIntoCategories(TUdata.depr, 4, "eq"));
data.depr34 = mycategorical(splitIntoCategories(TUdata.depr, 3, "geq", {'0', '1'}));
data.depr = mycategorical(TUdata.depr);
data.future = mycategorical(TUdata.futureView_t5t6t7);
data.blameSelf = mycategorical(TUdata.blameSelf);
data.worried = mycategorical(TUdata.worried_t5t6t7);
data.dizzy = mycategorical(TUdata.dizzy);
data.tense = mycategorical(TUdata.tense_t5t6t7);
data.struggle = mycategorical(TUdata.struggle_t5t6t7);
data.fear = mycategorical(TUdata.fear_t5t6t7);
data.fear34 = mycategorical(splitIntoCategories(TUdata.fear_t5t6t7, 3, "geq"))

% ¤¤ SLEEP ¤¤
data.insomniaCon = TUdata.insomnia_t5t6t7;
if settings.insomnia == "v1"
    data.insomnia = mycategorical(TUdata.insomnia_t5t6t7);
    data.insomnia1 = splitIntoCategories(TUdata.insomnia_t5t6t7, 1, "eq");
    data.insomnia2 = splitIntoCategories(TUdata.insomnia_t5t6t7, 2, "eq");
    data.insomnia3 = splitIntoCategories(TUdata.insomnia_t5t6t7, 3, "eq");
    data.insomnia4 = splitIntoCategories(TUdata.insomnia_t5t6t7, 4, "eq");
    data.insomnia234 = splitIntoCategories(TUdata.insomnia_t5t6t7, 2, "geq", {'0', '1'});
    data.insomnia34 = splitIntoCategories(TUdata.insomnia_t5t6t7, 3, "geq", {'0', '1'});
elseif settings.insomnia == "v2"
    data.insomnia = mycategorical(TUdata.insomnia_t5t6t7, 'mergeVar', {'1', '2'});
    data.insomnia = renamecats(data.insomnia, ["1", "3", "4"], ["1", "2", "3"])
    data.insomnia2 = splitIntoCategories(data.insomnia, 2, "eq", {'0', '1'});
    data.insomnia3 = splitIntoCategories(data.insomnia, 3, "geq", {'0', '1'});
    data.insomnia23 = splitIntoCategories(data.insomnia, 2, "geq", {'0', '1'});
else
    data.insomnia = TUdata.insomnia_t5t6t7;
end
data.insomniaFrq = mycategorical(TUdata.insomnia_t4t5t6);
data.insomniaFrq234 = splitIntoCategories(data.insomniaFrq, 2, "geq");
% ¤¤ TARGET VARIABLE ¤¤
data.srh = TUdata.srh;
data.srh_compared = TUdata.srh_compared_t6t7;
data.srh_orig = TUdata.srh_orig;

data = struct2table(data);
