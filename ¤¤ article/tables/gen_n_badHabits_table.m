% In this script, I compute the effect of having N bad habits

theGreatVariableForge

data = data(data.t == 7, :);

%%
clear T
low_PA = compare(data.PAfrq, "<=", "1");
overweight = compare(data.bmi, ">=", "3");
mental_distress = compare(data.hscl, ">=", 1.85);
diabetes = compare(data.diabHba1c, "==", "1");
smokes = compare(data.smokeNow, "==", "1");
lacking_friends = compare(data.friendsSupp, "==", "0");
n_bad_LSF = sum([low_PA, overweight, mental_distress, diabetes, smokes, lacking_friends], 2);

T = table(low_PA, overweight, mental_distress, diabetes, smokes, lacking_friends, n_bad_LSF, srh)

count = zeros(5, 2);
count(1, :) = [sum(n_bad_LSF==0), mean(n_bad_LSF==0)*100]
count(2, :) = [sum(n_bad_LSF==1), mean(n_bad_LSF==1)*100]
count(3, :) = [sum(n_bad_LSF==2), mean(n_bad_LSF==2)*100]
count(4, :) = [sum(n_bad_LSF==3), mean(n_bad_LSF==3)*100]
count(5, :) = [sum(n_bad_LSF>=4), mean(n_bad_LSF>=4)*100]
count = round(count, 2)


Prob_badSRH_0_badLSF = computeCImeanEst(srh(T.n_bad_LSF==0)<=2, "3", [], 3)*100
Prob_badSRH_1_badLSF = computeCImeanEst(srh(T.n_bad_LSF==1)<=2, "3", [], 3)*100
Prob_badSRH_2_badLSF = computeCImeanEst(srh(T.n_bad_LSF==2)<=2, "3", [], 3)*100
Prob_badSRH_3_badLSF = computeCImeanEst(srh(T.n_bad_LSF==3)<=2, "3", [], 3)*100
Prob_badSRH_atleast_4_badLSF = computeCImeanEst(srh(T.n_bad_LSF>=4)<=2, "3", [], 3)*100

T_prob_poorSRH = array2table( ...
    [ ...
    [Prob_badSRH_0_badLSF; ...
    Prob_badSRH_1_badLSF; ...
    Prob_badSRH_2_badLSF; ...
    Prob_badSRH_3_badLSF; ...
    Prob_badSRH_atleast_4_badLSF], ...
    count], ...
    "RowNames", ["0 bad LS-factors" "1 bad LS-factors" "2 bad LS-factors" "3 bad LS-factors" "Atleast 4 bad LS-factors"], ...
    "VariableNames", ["P(SHR<=2)" "ci lower" "ci upper" "count" "(%)"])


writetable(T_prob_poorSRH, ...
    fullfile(pwd, "tables", "T_prob_poorSRH.csv"), ...
    "WriteRowNames", true)



