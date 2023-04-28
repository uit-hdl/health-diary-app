function user_table = map_userdata_to_model_input(user_table)
% Turns a table with raw user inputs (age, Gender, answers to mental health
% questions, etc... ) into a table which contains variables (such as
% "insomnia4", or "old") that conforms to the input expected by the linear
% model.

% ¤¤¤ Exercise ¤¤¤

% If variable PA does not exist, derive it
var_names = user_table.Properties.VariableNames;
containsPA = sum(ismember(var_names, 'PA')) > 0;
if ~containsPA
    % Derive PA from PAfrq and PAint. Only run when "PA" is not present in
    % the table.
    F = cat2double(user_table.PAfrq);
    I = cat2double(user_table.PAint);
    user_table.PA = categorical(strcat("f", string(F), "i", string(I)));

elseif containsPA
    % Contains both, ensure no conflict (PA takes priority)
    PAstr = char(user_table.PA);
    F = str2double(PAstr(2));
    I = str2double(PAstr(4));
end

% add true/false variables needed for interaction terms:
user_table.PAf23i23 = categorical(double(and(F >= 2, I >= 2)));
user_table.PAf3i3 = categorical(double(and(F == 3, I == 3)));
user_table.PAf2i2 = categorical(double(and(F == 2, I == 2)));
user_table.PAf4i3 = categorical(double(and(F == 4, I == 3)));

% ¤¤¤ Old Person category ¤¤¤
X = user_table.age;
user_table.old = categorical(double(X >= 6.5));

% ¤¤¤ insomnia lvl 4 ¤¤¤
X = cat2double(user_table.insomnia);
user_table.insomnia4 = categorical(double(X == 4));
user_table.insomnia34 = categorical(double(X >= 3));

% ¤¤¤ Computing HSCL from Questionaire variables ¤¤¤
% check if table already cotains HSCL:
containsHSCL = sum(ismember(var_names, 'hscl')) == 1;
if ~containsHSCL
    % Derive HSCL from Questionaire variables
    HCLvars = {'futureView', 'blameSelf', 'worried', 'depr', 'fear', ...
        'dizzy', 'tense', 'useless', 'struggle', 'insomnia'};

    Thscl = table2array(subtable(user_table, HCLvars));

    % Defined as missing if more than 3 questions are not answered
    if sum(ismissing(Thscl), 2) > 3
        warning 'more than 3 mental health variables missing.'
    else
        user_table.hscl = mean(cat2double(Thscl), 2, 'omitnan');
    end
end

% ¤¤¤ Compute BMI ¤¤¤
containsBMI = sum(ismember(var_names, 'bmi')) == 1;
if ~containsBMI
    user_table.bmi = getIntervalIndex(user_table.weight/user_table.height^2, ...
        [0, 18.5, 25, 30, inf]);
    user_table.bmi = categorical(user_table.bmi);
end
% ** BMI lvl 3 and 4 **
X = cat2double(user_table.bmi);
user_table.bmi34 = categorical(double(X >= 3));

% ¤¤¤ Sex ¤¤¤
if user_table.sex == "female"
    user_table.sex = categorical(0);
elseif user_table.sex == "male"
    user_table.sex = categorical(1);
end

end