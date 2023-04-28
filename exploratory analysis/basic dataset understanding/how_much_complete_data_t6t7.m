fixedVars = {'age:age', 'education', ...
    'strokeOrHrtAtk', ...
    'sex', 'diabHba1c'};
decisionVars = {'PA', 'hii*hii', ...
    'bmi', 'hypert', 'smokeNow', ...
    'friendsSupp', 'hscl*hscl', 'insomnia'};
interactionPart = {'bmi:old', 'smokeNow:old', ...
    'old:insomnia23', 'old:PAf4i3', ...
    'insomnia23:PAf4i3', 'insomnia23:PAf23i23'};

formula = getLinearModelFormula([fixedVars, ...
    decisionVars, ...
    interactionPart], ...
    'srh');

%% how much data in each survey seprately?
lm6 = fitlm(data(data.t == 6, :), formula);
lm7 = fitlm(data(data.t == 7, :), formula);

lm6.NumObservations
lm7.NumObservations

%% how many participants with complete data in each set?
var_names = [lm6.PredictorNames; "srh"];
T6 = data(data.t == 6, var_names);
T7 = data(data.t == 7, var_names);

[sum(sum(ismissing(T6), 2) == 0), ...
    sum(sum(ismissing(T7), 2) == 0)]

%% how many with complete data that were included in both surveys?
load("survey_id_overlap.mat", "ID_overlap")
I_both = and(data.t >= 6, ID_overlap.I{3, 4});
T = data(I_both, ["t"; "id"; "srh"; var_names]);

I_complete = sum(ismissing(T), 2) == 0;
id_complete = T.id
% get id of those with complete data in T6:
id_complete_t6 = T.id(and(I_complete, T.t == 6));
id_complete_t7 = T.id(and(I_complete, T.t == 7));
id_complete_t6t7 = intersect(id_complete_t6, id_complete_t7)

% total number of participants that participated in both surveys
N_consec_participants = numel(unique(data.id(I_both)))
N_consec_participants_completeData = numel(id_complete_t6t7)

N_consec_participants_completeData/N_consec_participants
%% how many were excluded due to incomplete data?
T6 = data(data.t == 6, ["t"; "id"; "srh"; var_names]);
T7 = data(data.t == 7, ["t"; "id"; "srh"; var_names]);
mean(sum(ismissing(T6), 2) == 0)*100
mean(sum(ismissing(T7), 2) == 0)*100
