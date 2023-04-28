%% create tabular overview of PA intensity and PA frequency
if ~exist('TUdata', 'var')
    importLongData
end
theGreatVariableForge

X = categorical(nan(height(TUdata), 1)); % they need to answer both questions to qualify
for i_frq = 1:4
    for i_int = 1:3
        var_name = sprintf('f%gi%g', i_frq, i_int);
        X(and(data.PAfrq == string(i_frq), data.PAint == string(i_int))) = var_name;
    end
end
% X(or(X == "f1i2", X == "f1i3")) = [];

T_t6 = strings(4, 3);
T_t7 = strings(4, 3);
for i_frq = 1:4
    for i_int = 1:3
        var_name = sprintf('f%gi%g', i_frq, i_int);
        T_t6(i_frq, i_int) = util_sumAndMean(X(data.t==6) == var_name, "format", "s + (%%)");
        T_t7(i_frq, i_int) = util_sumAndMean(X(data.t==7) == var_name, "format", "s + (%%)");
    end
end

T_PA_t6 = array2table(T_t6, 'RowNames', ["less than 1/week", "1/week", "2-3/week", "approx. every day"], ...
    'VariableNames', ["Easy", "Moderate", "Hard"])
T_PA_t7 = array2table(T_t7, 'RowNames', ["less than 1/week", "1/week", "2-3/week", "approx. every day"], ...
    'VariableNames', ["Easy", "Moderate", "Hard"])

%% save as csv files
writetable(T_PA_t6,"..\..\tables\T_PA_frq_int_t6.csv","WriteRowNames",true)
writetable(T_PA_t7,"..\..\tables\T_PA_frq_int_t7.csv","WriteRowNames",true)

