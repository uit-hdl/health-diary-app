names = TUdata0.Properties.VariableNames;
names = cell2table(names,'V',names);

tables = cell(1,4);
for t=4:7
    clear T
    I = info.(sprintf('T%g',t)).I;
    T.AGE    = ismissing(TUdata.age(I));
    T.ANGINA = ismissing(TUdata.angina(I));
    T.ALCOHOL_FREQUENCY = ismissing(TUdata.alcFreq_t6t7(I));
    T.ALCOHOL_TIMES = ismissing(TUdata.alcFreq_t4t5(I));
    T.ANXIETY = ismissing(TUdata.anx_t4t5(I));
    T.ATRIAL_FIBRILLATION = ismissing(TUdata.atrialFib_t6t7(I));
    T.BLAME_SELF = ismissing(TUdata.blameSelf(I));
    T.BMI = ismissing(TUdata.bmi(I));
    T.CHOLESTEROL = ismissing(TUdata.cholest(I));
    T.CHRONIC_PAIN = ismissing(TUdata.chronPain_t6t7(I));
    T.DEPRESSION = ismissing(TUdata.depr(I));
    T.DIABETES = ismissing(TUdata.diab(I));
    T.DIZZY    = ismissing(TUdata.dizzy(I));
    T.DYSPNEA_CALMLY_FLAT = ismissing(TUdata.dyspCalmFlat_t6t7(I));
    T.DYSPNEA_FAST_UPHILL = ismissing(TUdata.dyspFastUp_t6t7(I));
    T.EDUCATION = ismissing(TUdata.educ(I));
    T.EXERCISE = ismissing(TUdata.PAfrq_t6t7(I));
    T.EXERCISE_LEVEL = ismissing(TUdata.PAint_t6t7(I));
    T.FEAR = ismissing(TUdata.fear_t5t6t7);
    T.HBA1C = ismissing(TUdata.glucoseHemoglob(I));
    T.HDL = ismissing(TUdata.hdlChol(I));
    T.HIGH_DENSITY_LIPOPROTEIN = ismissing(TUdata.hdlChol(I));
    T.HEART_ATTACK = ismissing(TUdata.heartAttack(I));
    T.HYPERTENSION = ismissing(TUdata.hypertension(I));
    T.HIGH_BLOOD_PRESSURE = ismissing(TUdata.highBP_t6t7(I));
    T.HSCL = ismissing(TUdata.HSCLcalc(I));
    T.INSOMNIA_FREQ = ismissing(TUdata.insomnia_t4t5t6(I));
    T.INSOMNIA      = ismissing(TUdata.insomnia_t5t6t7(I));
    T.LONELY      = ismissing(TUdata.lonely_t4t5(I));
    T.LONELY      = ismissing(TUdata.lonely_t4t5(I));
    T.PHYS_ACTIVITY_LEISURE_LIGHT = ismissing(TUdata.PAlight_t4t5(I));
    T.PHYS_ACTIVITY_LEISURE_HARD = ismissing(TUdata.PAhard_t4t5(I));
    T.RESTING_HEART_RATE = ismissing(TUdata.restHR(I));
    T.SEX   = ismissing(TUdata.sex(I));
    T.SMOKE = ismissing(TUdata.smoke(I));
    T.SRH = ismissing(TUdata.srh(I));
    T.STROKE = ismissing(TUdata.stroke(I));
    T.STRUGGLE = ismissing(TUdata.struggle_t5t6t7(I));
    T.SUPPORT_FRIENDS = ismissing(TUdata.friendsSupp_t6t7(I));
    T.TENSE = ismissing(TUdata.tense_t5t6t7(I));
    T.USELESS = ismissing(TUdata.useless_567(I));
    T.WORRIED = ismissing(TUdata.worried_567(I));
    
    TableNames = fieldnames(T);
    
    for i=1:numel(TableNames)
        I_missing = T.(TableNames{i});
        n_complete = sum(~I_missing);
        p_complete = mean(~I_missing);
        
        T.(TableNames{i}) = sprintf('%g%%',round(100*p_complete,1));
    end
    tables{t-3} = struct2cell(T)';
end

T = cell2table([tables{1};tables{2};tables{3};tables{4}],...
            'VariableNames',TableNames,...
            'RowNames',["T4" "T5" "T6" "T7"]) %#ok<*NOPTS> 

%%
save('T_T4_to_T7_overview_missingData',"T")

writetable(T,"T_T4_to_T7_overview_missingData.csv","WriteRowNames",true)