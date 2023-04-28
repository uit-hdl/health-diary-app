%% Get data
if ~exist('TUdata', 'var')
    importLongData
end
theGreatVariableForge

load("mat_survey_id_overlap.mat", "ID_overlap")
% extract a test set from T7 consisting of participants who only
% participated in T7:
N_test = 400;
id_T7_only = setdiff(ID_overlap.id{4, 4}, ID_overlap.id{3, 3});
id_T7_test = randsample(id_T7_only, N_test);

I_test = and(findInd(data.id, id_T7_test), data.t == 7);
I_fit = and(~I_test, data.t >= 6);

J_test = find(I_test);
J_fit = find(I_fit);

description = "test (N=400) and training set. " + ...
    "Test set consists of individuals that are in T7 but not T6";
save("testAndTrainingSet.mat", "I_fit", "I_test", "J_fit", "J_test", ...
    "N_test", "id_T7_test", "description")




