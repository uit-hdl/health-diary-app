idx_women = data.sex == "0";
idx_men = data.sex == "1";
clear T
t = 6;
% HSCL
T.hscl_men = computeCImeanEst(data.hscl(and(idx_women, data.t == t)), "2")
T.hscl_women = computeCImeanEst(data.hscl(and(idx_men, data.t == t)), "2")

T.hii_men = computeCImeanEst(data.hii(and(idx_women, data.t == t)), "2")
T.hii_women = computeCImeanEst(data.hii(and(idx_men, data.t == t)), "2")

T.srh_men = computeCImeanEst(data.srh(and(idx_women, data.t == t)), "2")
T.srh_women = computeCImeanEst(data.srh(and(idx_men, data.t == t)), "2")


%%
util_calc_ci_diff_2_means( ...
    data.srh(and(idx_women,data.t == t)), ...
    data.srh(and(idx_men, data.t == t)) ...
    )
