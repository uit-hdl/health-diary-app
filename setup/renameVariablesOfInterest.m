% Script for renaming table variables for convenience

clear TUdata

if isfield(TUdata0, 'GLUCOSE_T42')
    TUdata0 = renamevars(TUdata0, 'GLUCOSE_T42', 'GLUCOSE_T4');
end

TUdata.t = TUdata0.time;
t = TUdata.t;
S = {};

TUdata.age = TUdata0.AGE_T; %#ok<*STRSCALR>
TUdata.angina = TUdata0.ANGINA_T;
TUdata.antiDep = TUdata0.antidepressants;
TUdata.alcFreq_t6t7 = tu_renameVars(TUdata0, "ALCOHOL_FREQUENCY", [6, 7]);
TUdata.alcFreq_t4t5 = tu_renameVars(TUdata0, "ALCOHOL_TIMES", [4, 5]);
TUdata.anx_t4t5 = tu_renameVars(TUdata0, "ANXIOUS", [4, 5]);
TUdata.arthrosis_t5t6t7 = tu_renameVars(TUdata0, "ARTHROSIS", [5, 6, 7]);
TUdata.asthma = tu_renameVars(TUdata0, "ASTHMA", 4:7);
TUdata.atrialFib_t6t7 = tu_renameVars(TUdata0, "ATRIAL_FIBRILLATION", [6, 7]);

TUdata.blameSelf = TUdata0.BLAME_YOURSELF_T;
TUdata.bmi = TUdata0.BMI_T;

TUdata.cancer = TUdata0.CANCER_T;
TUdata.cholest = TUdata0.CHOLESTEROL_T;
TUdata.chronPain_t6t7 = tu_renameVars(TUdata0, "CHRONIC_PAIN", [6, 7]);
TUdata.cancer = TUdata0.Cancer;

TUdata.depr = TUdata0.DEPRESSED_T;
TUdata.diab = TUdata0.diabetes;
TUdata.dizzy = TUdata0.DIZZY_T;
TUdata.dyspCalmFlat_t6t7 = tu_renameVars(TUdata0, "DYSPNEA_CALMLY_FLAT", [6, 7]);
TUdata.dyspFastUp_t6t7 = tu_renameVars(TUdata0, "DYSPNEA_FAST_UPHILL", [6, 7]);

TUdata.educ = TUdata0.EDUCATION_T;
TUdata.PAfrq_t6t7 = tu_renameVars(TUdata0, "EXERCISE", [6, 7]);
TUdata.PAint_t6t7 = tu_renameVars(TUdata0, "EXERCISE_LEVEL", [6, 7]);

% clean up PA frequency:
x = TUdata.PAfrq_t6t7;
TUdata.PAfrq_t6t7(x == 0) = 1;
TUdata.PAfrq_t6t7(x == 0.5) = 2;
TUdata.PAfrq_t6t7(x == 1) = 3;
TUdata.PAfrq_t6t7(x == 2.5) = 4;
TUdata.PAfrq_t6t7(x == 6) = 5;

TUdata.poor = TUdata0.fattig;
TUdata.fear_t5t6t7 = TUdata0.FEAR_T;
TUdata.fear_t5t6t7(info.T4.I) = nan;

TUdata.fibroMy_t4t5 = tu_renameVars(TUdata0, "FIBROMYALGIA", [4, 5]);
TUdata.futureView_t5t6t7 = tu_renameVars(TUdata0, "FUTURE_T", [5, 6, 7]);

I = find(TUdata0.Properties.VariableNames == "GLUCOSE_T42");
if ~isempty(I)
    TUdata0.Properties.VariableNames("GLUCOSE_T42") = "GLUCOSE_T4";
end
TUdata.glucose_t4t5t6 = tu_renameVars(TUdata0, "GLUCOSE", [4, 5]);

TUdata.glucoseHemoglob = TUdata0.HBA1C_T;
TUdata.hdlChol = tu_renameVars(TUdata0, "HDL", 4:7);

% merge those who have has had a heart attack:
TUdata.heartAttack = util_compare(TUdata0.HEART_ATTACK_T, ">", 0);
TUdata.heartAttackAge = tu_renameVars(TUdata0, "HEART_ATTACK_AGE", 4:7);
% find those who had a heart attack less than 4 years ago:
TUdata.heartAttackRecent = (TUdata.age - TUdata.heartAttackAge) <= 4;

TUdata.hypertension = TUdata0.hypertension; % hypertension og lipid viktigst
TUdata.highBP_t6t7 = nan(height(TUdata0), 1);
TUdata.highBP_t6t7(info.T6.I) = TUdata0.highBP(info.T6.I);
TUdata.highBP_t6t7(info.T7.I) = TUdata0.highBP(info.T7.I);
TUdata.highBP = gen_highBP(TUdata0);

TUdata.highChol = TUdata0.highCHOL;
TUdata.highLipid = TUdata0.lipid; % warning: not complete lipid data
TUdata.HSCL_GROUP = TUdata0.HSCL_GROUP_T;
TUdata.hscl = TUdata0.hscl;
TUdata.hii = TUdata0.HII_T;
TUdata.houseHoldIncome = TUdata0.HOUSEHOLD_INCOME_T;
% CALCULATE HSCL
full_hscl = true;
if full_hscl
    HSCLvars = {'FUTURE_T', 'BLAME_YOURSELF_T', 'WORRIED_T', 'DEPRESSED_T', 'FEAR_T', ...
        'DIZZY_T', 'TENSE_T', 'USELESS_T', 'STRUGGLE_T', 'INSOMNIA_T'};
else
    HSCLvars = {'FUTURE_T', 'BLAME_YOURSELF_T', 'WORRIED_T', 'DEPRESSED_T', 'FEAR_T', ...
        'DIZZY_T', 'TENSE_T', 'USELESS_T', 'STRUGGLE_T'};
end
T = table2array(subtable(TUdata0, HSCLvars));
% Defined as missing if more than 3 questions are not answered
Imissing = sum(ismissing(T), 2) > 3;
TUdata.HSCLcalc = mean(T, 2, 'omitnan');
HCL(Imissing) = nan;

TUdata.id = TUdata0.id;
TUdata.insomnia_t4t5t6 = tu_renameVars(TUdata0, "INSOMNIA_FREQ", [4, 5, 6]);
TUdata.insomnia_t5t6t7 = tu_renameVars(TUdata0, "INSOMNIA_T", [5, 6, 7]);

TUdata.lipid = TUdata0.lipid;
TUdata.lonely_t4t5 = tu_renameVars(TUdata0, "LONELY", [4, 5]);
TUdata.liveWspouse = tu_renameVars(TUdata0, "LIVE_WITH_SPOUSE", [4, 5, 6, 7]);

TUdata.memory_t6t7 = TUdata0.MEMORY_DECLINED_T6;
TUdata.memory_t6t7 = tu_renameVars(TUdata0, "MEMORY_DECLINED", [6, 7]);

TUdata.migraine = TUdata0.MIGRAINE_T4;
TUdata.migraine = tu_renameVars(TUdata0, "MIGRAINE", 4:7);

TUdata.nervous_t4t5 = TUdata0.NERVOUS_T4;
TUdata.nervous_t4t5 = tu_renameVars(TUdata0, "NERVOUS", [4, 5]);

TUdata.PAlight_t4t5 = tu_renameVars(TUdata0, "PHYS_ACTIVITY_LEISURE_LIGHT", [4, 5]);
TUdata.PAhard_t4t5 = tu_renameVars(TUdata0, "PHYS_ACTIVITY_LEISURE_HARD", [4, 5]);

TUdata.PAleisure_t6t7 = tu_renameVars(TUdata0, "PHYS_ACTIVITY_LEISURE", [6, 7]);
TUdata.physact = TUdata0.physact;

TUdata.restHR = TUdata0.RHR;

TUdata.sex = TUdata0.SEX_T;
TUdata.smoke = TUdata0.SMOKE_T;
TUdata.srh = TUdata0.srh;
TUdata.srh_orig = tu_renameVars(TUdata0, "HEALTH", [4, 5, 6, 7]);
TUdata.srh_compared_t6t7 = tu_renameVars(TUdata0, "HEALTH_COMPARED", [6, 7]);
TUdata.stroke = util_compare(TUdata0.STROKE_T, ">", 0);
TUdata.friendsSupp_t6t7 = tu_renameVars(TUdata0, "SUPPORT_FRIENDS", [6, 7]);


TUdata.suffFriends2talk2_t6t7 = tu_renameVars(TUdata0, "TALK_FRIENDS", [6, 7]);
TUdata.struggle_t5t6t7 = tu_renameVars(TUdata0, "STRUGGLE_T", [5, 6, 7]);

TUdata.tense_t5t6t7 = tu_renameVars(TUdata0, "TENSE_T", [5, 6, 7]);
TUdata.triglyc_t4t5t6 = tu_renameVars(TUdata0, "TRIGLYCERIDES", [4, 5, 6]);

TUdata.useless_t5t6t7 = tu_renameVars(TUdata0, "USELESS_T", [5, 6, 7]);
TUdata.worried_t5t6t7 = tu_renameVars(TUdata0, "WORRIED_T", [5, 6, 7]);

TUdata = struct2table(TUdata);
TUdata.Properties.Description = sprintf("use full hscl:%g", full_hscl)
clear T Imissing