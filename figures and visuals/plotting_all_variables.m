%% if nessecary; import wide data
if not(exist('TUwide','var'))
    importWideData
end
if not(exist('TUwide','var'))
    importLongData
end
t = TUdata0.time;
%% Age and Sex
close all
figure
sgtitle('Age and Sex')
subplot(241)
    myhist(TUwide.AGE_T4)
    title 'T5'
subplot(242)
    myhist(TUwide.AGE_T5)
    title 'T6'
subplot(243)
    myhist(TUwide.AGE_T6)
    title 'T7'
subplot(244)
    myhist(TUwide.AGE_T7)
    title 'T4'
subplot(245)
    myhist(TUwide.SEX_T4)
    title 'T4'
subplot(246)
    myhist(TUwide.SEX_T5)
    title 'T5'
subplot(247)
    myhist(TUwide.SEX_T6)
    title 'T6'
subplot(248)
    myhist(TUwide.SEX_T7)
    title 'T7'

%% INSOMNIA
close all
figure
subplot(2,4,2)
    myhist(TUwide.INSOMNIA_T5)
    title 'insomnia T5'
subplot(2,4,3)
    myhist(TUwide.INSOMNIA_T6)
    title 'insomnia T6'
subplot(2,4,4)
    myhist(TUwide.INSOMNIA_T7)
    title 'insomnia T7'

subplot(245)
    myhist(TUwide.INSOMNIA_FREQ_T4)
    title 'insomnia frq T4'
subplot(246)
    myhist(TUwide.INSOMNIA_FREQ_T5)
    title 'insomnia frq T5'
subplot(247)
    myhist(TUwide.INSOMNIA_FREQ_T6)
    title 'insomnia frq T6'
%% ¤¤¤¤¤   Hopkins Symptom Cheklist Variables   ¤¤¤¤¤
%% INSMONIA (Hopkins Checklist)
close all
figure
subplot(1,4,2)
    myhist(TUdata.insomnia_t5t6t7(t==5))
    title 'insomnia Long T5'
subplot(1,4,3)
    myhist(TUdata.insomnia_t5t6t7(t==6))
    title 'insomnia Long T6'
subplot(1,4,4)
    myhist(TUdata.insomnia_t5t6t7(t==7))
    title 'insomnia Long T7'
%% DEPRESSION
close all
figure
subplot(141)
    myhist(TUwide.DEPRESSED_T4)
    title 'DEPRESSION T4'
subplot(142)
    myhist(TUwide.DEPRESSED_T5)
    title 'DEPRESSION T5'
subplot(143)
    myhist(TUwide.DEPRESSED_T6)
    title 'DEPRESSION T6'
subplot(144)
    myhist(TUwide.DEPRESSED_T7)
    title 'DEPRESSION T7'
%% USELESS
close all
figure
subplot(142)
    myhist(TUwide.USELESS_T5)
    title 'USELESS T5'
subplot(143)
    myhist(TUwide.USELESS_T6)
    title 'USELESS T6'
subplot(144)
    myhist(TUwide.USELESS_T7)
    title 'USELESS T7'
%% ANXIETY/WORRY (anxious or afraid)
close all
figure
subplot(131)
    myhist(TUwide.WORRIED_T5)
    title 'T5'
subplot(132)
    myhist(TUwide.WORRIED_T6)
    title 'T6'
subplot(133)
    myhist(TUwide.WORRIED_T7)
    title 'T7'
sgtitle('Anxious or worried last 2 weeks?') 
%% FEAR (Suddenly feel afraid for no apparent reason?
close all
figure
subplot(142)
    myhist(TUwide.FEAR_T5)
    title 'T5'
subplot(143)
    myhist(TUwide.FEAR_T6)
    title 'T6'
subplot(144)
    myhist(TUwide.FEAR_T7)
    title 'T7'
sgtitle('FEAR?') 
%% HEALTH IMPACT INDEX
close all
figure
sgtitle('Mental Health Index')
subplot(141)
    myhist(TUwide.HSCL_GROUP_T4)
    title 'T4'
subplot(142)
    myhist(TUwide.HSCL_GROUP_T5)
    title 'T5'
subplot(143)
    myhist(TUwide.HSCL_GROUP_T6)
    title 'T6'
subplot(144)
    myhist(TUwide.HSCL_GROUP_T7)
    title 'T7'
    
%% LONELY
close all
figure
subplot(121)
histogram(TUwide.LONELY_T4,'no','pr')
title 'T4'
subplot(122)
histogram(TUwide.LONELY_T5,'no','pr')
title 'T5'
sgtitle('felt lonely last 2 weeks?')

%% SUPPORT FROM FRIENDS
close all
figure
subplot(121)
    myhist(TUwide.SUPPORT_FRIENDS_T6)
    title 'T6'
subplot(122)
    myhist(TUwide.SUPPORT_FRIENDS_T7)
    title 'T7'
sgtitle('Do you have support from friends?')
%% PHYSICAL EXERCISE (GEIRS VARIABLE)
close all
figure
subplot(141)
myhist(TUwide.physact4,'no','pr')
title 'T4'
subplot(142)
histogram(TUwide.physact5,'no','pr')
title 'T5'
sgtitle('felt lonely last 2 weeks?')
subplot(143)
histogram(TUwide.physact6,'no','pr')
title 'T6'
subplot(144)
histogram(TUwide.physact7,'no','pr')
title 'T7'
sgtitle('PA level, Geirs variable')
%% EXERCISE ALL
close all
figure
subplot(121)
    histogram(TUwide.PHYS_ACTIVITY_LEISURE_HARD_T4,'no','pr')
    title 'T4'
subplot(122)
    histogram(TUwide.PHYS_ACTIVITY_LEISURE_HARD_T5,'no','pr')
    title 'T5'
sgtitle('Hard PA (sweating/outOfBreath):0 (0<x<1) (1<x<2) (x>3)')

figure
subplot(121)
    histogram(TUwide.PHYS_ACTIVITY_LEISURE_T6,'no','pr')
    title 'T6'
subplot(122)
    histogram(TUwide.PHYS_ACTIVITY_LEISURE_T7,'no','pr')
    title 'T7'
sgtitle('PA leisure: (>4hrs, mild); (>4hrs, intense); (>4hrs, athletes)')

%% EXERCISE FREQUENCY
close all
figure
subplot(121)
histogram(categorical(TUwide.EXERCISE_T6),'no','pr')
title 'T6'
subplot(122)
histogram(TUwide.EXERCISE_T7,'no','pr')
title 'T7'
sgtitle('exercise frequency')

%% EXERCISE INTENSITY/LEVEL
close all
figure
subplot(121)
histogram(categorical(TUwide.EXERCISE_LEVEL_T6),'no','pr')
title 'T6'
subplot(122)
histogram(TUwide.EXERCISE_LEVEL_T6,'no','pr')
title 'T7'
sgtitle('exercise inensity')


%% EXERCISE LEVEL (intensity)
close all
figure
title 'T5'
sgtitle('If exercise - how hard?')
subplot(121)
    myhist(TUwide.EXERCISE_LEVEL_T6)
    title 'T6'
subplot(122)
    myhist(TUwide.EXERCISE_LEVEL_T6)
    title 'T7'
sgtitle('exercise intensity')
%% CANCER
close all
figure
sgtitle('Cancer')
subplot(131)
    histogram(TUwide.CANCER_T4,'no','pr')
    title 'T4'
subplot(132)
    histogram(TUwide.CANCER_T5,'no','pr')
    title 'T5'
subplot(133)
histogram(TUwide.CANCER_T7,'no','pr')
title 'T7'

%% SMOKING
close all
figure
sgtitle('Smoking')
subplot(141)
    myhist(TUwide.SMOKE_T4,[],"prob")
    title 'T4'
subplot(142)
    myhist(TUwide.SMOKE_T5,[],"prob")
%     histogram(TUdata0.SMOKE_T(t==5),'no','pr')
    title 'T5'
subplot(143)
    myhist(TUwide.SMOKE_T6,[],"prob")
    title 'T6'
subplot(144)
    myhist(TUwide.SMOKE_T7,[],"prob")
    title 'T7'
    
%% STROKE
close all
figure
sgtitle('Stroke')
subplot(141)
    histogram(TUwide.STROKE_T4(~isnan(TUwide.STROKE_T4)),'no','pr')
    title 'T4'
subplot(142)
    histogram(TUwide.STROKE_T5(~isnan(TUwide.STROKE_T5)),'no','pr')
    title 'T5'
subplot(143)
    histogram(TUwide.STROKE_T6(~isnan(TUwide.STROKE_T6)),'no','pr')
    title 'T6'
subplot(144)
    histogram(TUwide.STROKE_T7(~isnan(TUwide.STROKE_T7)),'no','pr')
    title 'T7'
    
%% HEART ATTACK
close all
figure
sgtitle('heart attack')
subplot(141)
    myhist(TUwide.HEART_ATTACK_T4)
    title 'T4'
subplot(142)
    myhist(TUwide.HEART_ATTACK_T5)
    title 'T5'
subplot(143)
    myhist(TUwide.HEART_ATTACK_T6)
    title 'T6'
subplot(144)
    myhist(TUwide.HEART_ATTACK_T7)
    title 'T7'
 %% Resting Heart Rate
 close all
figure
sgtitle('Resting heart rate')
subplot(141)
    myhist(TUwide.RHR4)
    title 'T4'
subplot(142)
    myhist(TUwide.RHR5)
    title 'T5'
subplot(143)
    myhist(TUwide.RHR6)
    title 'T6'
subplot(144)
    myhist(TUwide.RHR7)
    title 'T7'
%% ANGINA
 close all
figure
sgtitle('Resting heart rate')
subplot(141)
    myhist(TUwide.ANGINA_T4,[],"prob")
    title 'T4'
subplot(142)
    myhist(TUwide.ANGINA_T5,[],"prob")
    title 'T5'
subplot(143)
    myhist(TUwide.ANGINA_T6,[],"prob")
    title 'T6'
subplot(144)
    myhist(TUwide.ANGINA_T7,[],"prob")
    title 'T7'
%% ASTHMA
 close all
figure
sgtitle('Asthma')
subplot(141)
    myhist(TUwide.ASTHMA_T4,[],"prob")
    title 'T4'
subplot(142)
    myhist(TUwide.ASTHMA_T5,[],"prob")
    title 'T5'
subplot(143)
    myhist(TUwide.ASTHMA_T6,[],"prob")
    title 'T6'
subplot(144)
    myhist(TUwide.ASTHMA_T7,[],"prob")
    title 'T7'
%% MIGRAINE
 close all
figure
sgtitle('MIGRAINE')
subplot(141)
    myhist(TUwide.MIGRAINE_T4)
    title 'T4'
subplot(142)
    myhist(TUwide.MIGRAINE_T5)
    title 'T5'
subplot(143)
    myhist(TUwide.MIGRAINE_T6)
    title 'T6'
subplot(144)
    myhist(TUwide.MIGRAINE_T7)
    title 'T7'
%% Hemoglobin Glucose
close all
figure
sgtitle('MIGRAINE')
subplot(141)
    myhist(TUwide.HBA1C_T)
    title 'T4'
subplot(142)
    myhist(TUwide.HBA1C_T5)
    title 'T5'
subplot(143)
    myhist(TUwide.HBA1C_T6)
    title 'T6'
subplot(144)
    myhist(TUwide.HBA1C_T7)
    title 'T7'

%% HYPERTENSION
close all
figure
subplot(241)
    myhist(TUwide.hypertension4)
    title 'hypertension T4'
subplot(242)
    myhist(TUwide.hypertension5)
    title 'hypertension T5'
subplot(243)
    myhist(TUwide.hypertension6)
    title 'hypertension T6'
subplot(244)
    myhist(TUwide.hypertension7)
    title 'hypertension T7'

subplot(245)
    myhist(TUdata.hypertension(t==4))
%     myhist(TUdata.hypertension(t==4),[],"prob")
    title 'high BP T4'
subplot(246)
    myhist(TUdata.hypertension(t==5))
    title 'high BP T5'
subplot(247)
    myhist(TUdata.hypertension(t==6))
    title 'high BP T6'
subplot(248)
    myhist(TUdata.hypertension(t==7))
    title 'high BP T7'
%% MEAN BLOOD PRESSURE
close all
figure
sgtitle('Mean Systolic Blood pressure')
subplot(241)
    myhist(TUwide.MEAN_SYSBP_T4,[],"prob")
    title 'systolic T4'
subplot(242)
    myhist(TUwide.MEAN_SYSBP_T5,[],"prob")
    title 'systolic T5'
subplot(243)
    myhist(TUwide.MEAN_SYSBP_T6,[],"prob")
    title 'systolic T6'
subplot(244)
    myhist(TUwide.MEAN_SYSBP_T7,[],"prob")
    title 'systolic T7'

 subplot(245)
    myhist(TUwide.MEAN_DIABP_T4,[],"prob")
    title 'diastolic T4'
subplot(247)
    myhist(TUwide.MEAN_DIABP_T6,[],"prob")
    title 'diastolic T6'
subplot(248)
    myhist(TUwide.MEAN_DIABP_T7,[],"prob")
    title 'diastolic T7'
    
%% LIVE WITH SPOUSE
close all
figure
sgtitle('Do you live with spouse/partner?')
subplot(141)
    myhist(TUwide.LIVE_WITH_SPOUSE_T4)
%     myhist(TUdata.hypertension(t==4),[],"prob")
    title 'T4'
subplot(142)
    myhist(TUwide.LIVE_WITH_SPOUSE_T5)
    title 'T5'
subplot(143)
    myhist(TUwide.LIVE_WITH_SPOUSE_T6)
    title 'T6'
subplot(144)
    myhist(TUwide.LIVE_WITH_SPOUSE_T7)
    title 'T7'
%% ALCOHOL
close all
figure
subplot(221)
    myhist(TUwide.ALCOHOL_TIMES_T4)
%     myhist(TUdata.hypertension(t==4),[],"prob")
    title 'N drink alc/month T4'
subplot(222)
    myhist(TUwide.ALCOHOL_TIMES_T5)
    title 'N drink alc/month T5'
    
subplot(223)
    myhist(TUwide.ALCOHOL_FREQUENCY_T6)
    title 'drink frequency T6'
subplot(224)
    myhist(TUwide.ALCOHOL_FREQUENCY_T7)
    title 'drink frequency T7'
%% EDUCATIONAL STATUS
close all
figure
sgtitle('What is your level of education?')
subplot(141)
    myhist(TUwide.EDUCATION_T4)
    title 'T4'
subplot(142)
    myhist(TUwide.EDUCATION_T5)
    title 'T5'
subplot(143)
    myhist(TUwide.EDUCATION_T6)
    title 'T6'
subplot(144)
    myhist(TUwide.EDUCATION_T7)
    title 'T6'
% note: level 2 and 3, and level 4 and 5 have been merged.


   
