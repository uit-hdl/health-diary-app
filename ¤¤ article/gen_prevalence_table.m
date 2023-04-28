% Used to produce table in paper that dichotomizes the Tromsø7 data, and
% computes prevalences for the "bad-SRH" and "good-SRH" subsets.

theGreatVariableForge

% Create stratas
data = data(data.t==7, :);
ix_srh_bad = (data.srh<=2);
ix_srh_good = (data.srh>=3);
data_srh_good = data(ix_srh_good, :);
data_srh_bad = data(ix_srh_bad, :);

clear T
% ¤¤¤¤ Good or Very Good SRH ¤¤¤¤
T.srh_good.age = computeCImeanEst(data_srh_good.age, "2");
T.srh_good.females = computeCImeanEst(compare(data_srh_good.sex, "==", 0), "2");
T.srh_good.education_upper_secondary = computeCImeanEst(compare(data_srh_good.education, "==", 1), "2");
T.srh_good.education_high_school = computeCImeanEst(compare(data_srh_good.education, "==", 2), "2");
T.srh_good.education_university = computeCImeanEst(compare(data_srh_good.education, "==", 3), "2");
T.srh_good.hii_multi_comorbidity = computeCImeanEst(compare(data_srh_good.hii, ">=", 3), "2");
T.srh_good.friendsSupp = computeCImeanEst(compare(data_srh_good.friendsSupp, "==", 1), "2");
T.srh_good.liveWspouse = computeCImeanEst(compare(data_srh_good.liveWspouse, "==", 1), "2");
% ¤¤ PA ¤¤
% PA-frequency
T.srh_good.PAfrq_0pw = computeCImeanEst(compare(data_srh_good.PAfrq, "==", 1), "2");
T.srh_good.PAfrq_1pw = computeCImeanEst(compare(data_srh_good.PAfrq, "==", 2), "2");
T.srh_good.PAfrq_3pw = computeCImeanEst(compare(data_srh_good.PAfrq, "==", 3), "2");
T.srh_good.PAfrq_4pw = computeCImeanEst(compare(data_srh_good.PAfrq, "==", 4), "2");
% PA-intensity
T.srh_good.PAint_mild = computeCImeanEst(compare(data_srh_good.PAint, "==", 1), "2");
T.srh_good.PAint_moderate = computeCImeanEst(compare(data_srh_good.PAint, "==", 2), "2");
T.srh_good.PAint_high = computeCImeanEst(compare(data_srh_good.PAint, "==", 3), "2");
% ¤¤ BMI ¤¤
T.srh_good.bmi_under = computeCImeanEst(compare(data_srh_good.bmi, "==", 1), "2");
T.srh_good.bmi_normal = computeCImeanEst(compare(data_srh_good.bmi, "==", 2), "2");
T.srh_good.bmi_over = computeCImeanEst(compare(data_srh_good.bmi, "==", 3), "2");
T.srh_good.bmi_obese = computeCImeanEst(compare(data_srh_good.bmi, "==", 4), "2");
% ¤¤ Diabetes, Smoking, and HSCL ¤¤
T.srh_good.diabetes = computeCImeanEst(compare(data_srh_good.diabHba1c, "==", 1), "2");
T.srh_good.smoker = computeCImeanEst(compare(data_srh_good.smokeNow, "==", 1), "2");
T.srh_good.hscl_symptoms = computeCImeanEst(compare(data_srh_good.hscl, ">=", 1.85), "2");

% ¤¤¤¤ Bad or Very Bad SRH ¤¤¤¤
T.srh_bad.age = computeCImeanEst(data_srh_bad.age, "2");
T.srh_bad.females = computeCImeanEst(compare(data_srh_bad.sex, "==", 0), "2");
T.srh_bad.education_upper_secondary = computeCImeanEst(compare(data_srh_bad.education, "==", 1), "2");
T.srh_bad.education_high_school = computeCImeanEst(compare(data_srh_bad.education, "==", 2), "2");
T.srh_bad.education_university = computeCImeanEst(compare(data_srh_bad.education, "==", 3), "2");
T.srh_bad.hii_multi_comorbidity = computeCImeanEst(compare(data_srh_bad.hii, ">=", 3), "2");
T.srh_bad.friendsSupp = computeCImeanEst(compare(data_srh_bad.friendsSupp, "==", 1), "2");
T.srh_bad.liveWspouse = computeCImeanEst(compare(data_srh_bad.liveWspouse, "==", 1), "2");
% ¤¤ PA ¤¤
% PA-frequency
T.srh_bad.PAfrq_0pw = computeCImeanEst(compare(data_srh_bad.PAfrq, "==", 1), "2");
T.srh_bad.PAfrq_1pw = computeCImeanEst(compare(data_srh_bad.PAfrq, "==", 2), "2");
T.srh_bad.PAfrq_3pw = computeCImeanEst(compare(data_srh_bad.PAfrq, "==", 3), "2");
T.srh_bad.PAfrq_4pw = computeCImeanEst(compare(data_srh_bad.PAfrq, "==", 4), "2");
% PA-intensity
T.srh_bad.PAint_mild = computeCImeanEst(compare(data_srh_bad.PAint, "==", 1), "2");
T.srh_bad.PAint_moderate = computeCImeanEst(compare(data_srh_bad.PAint, "==", 2), "2");
T.srh_bad.PAint_high = computeCImeanEst(compare(data_srh_bad.PAint, "==", 3), "2");
% ¤¤ BMI ¤¤
T.srh_bad.bmi_under = computeCImeanEst(compare(data_srh_bad.bmi, "==", 1), "2");
T.srh_bad.bmi_normal = computeCImeanEst(compare(data_srh_bad.bmi, "==", 2), "2");
T.srh_bad.bmi_over = computeCImeanEst(compare(data_srh_bad.bmi, "==", 3), "2");
T.srh_bad.bmi_obese = computeCImeanEst(compare(data_srh_bad.bmi, "==", 4), "2");
% ¤¤ Diabetes, Smoking, and HSCL ¤¤
T.srh_bad.diabetes = computeCImeanEst(compare(data_srh_bad.diabHba1c, "==", 1), "2");
T.srh_bad.smoker = computeCImeanEst(compare(data_srh_bad.smokeNow, "==", 1), "2");
T.srh_bad.hscl_symptoms = computeCImeanEst(compare(data_srh_bad.hscl, ">=", 1.85), "2");

% Convert to formatted strings
variables_srh_good = fieldnames(T.srh_good);
n_variables = numel(variables_srh_good)
for i=1:n_variables
    if variables_srh_good{i}=="age"
        values = T.srh_good.(variables_srh_good{i})*10;
        str = sprintf("%0.3g (%0.3g-%0.3g)", values(2), values(1), values(3))
    else
        values = T.srh_good.(variables_srh_good{i})*100;
        str = sprintf("%0.3g (%0.3g-%0.3g)", values(2), values(1), values(3))
    end
    T.srh_good.(variables_srh_good{i}) = str
end

variables_srh_bad = fieldnames(T.srh_bad);
n_variables = numel(variables_srh_bad);
for i=1:n_variables
    if variables_srh_bad{i}=="age"
        values = T.srh_bad.(variables_srh_bad{i})*10;
        str = sprintf("%0.3g (%0.3g-%0.3g)", values(2), values(1), values(3))
    else
        values = T.srh_bad.(variables_srh_bad{i})*100;
        str = sprintf("%0.3g (%0.3g-%0.3g)", values(2), values(1), values(3))
    end
    T.srh_bad.(variables_srh_bad{i}) = str
end

T_good_vs_bad = array2table( ...
    [string(struct2cell(T.srh_bad)), string(struct2cell(T.srh_good))], ...
    "RowNames", variables_srh_bad, ...
    "VariableNames", ["bad or very bad SRH", "good or very SRH"])

writetable(T_good_vs_bad, fullfile(pwd , 'tables', 'T7_prevalences.csv'), "WriteRowNames", true)

%%
T.srh_bad.age_geq_65 = computeCImeanEst(compare(data_srh_bad.age, ">=", 6.5), "2");

T.srh_bad.females = computeCImeanEst(compare(data.sex(ix_srh_bad, :), "==", 0), "2")
T.education = computeCImeanEst(compare(data.education(ix_srh_bad, :), "==", 3), "2")
T.education