function T = rawUserData2ModelInput(T)
% Turns a table with raw user inputs (age, Gender, ) into a table which
% contains derived variables (such as "insomnia4", or "old") which are
% nessecary for the fitted linear model to make predictions.

% ¤¤¤ Exercise ¤¤¤

% If variable PA does not exist, derive it
varNames   = T.Properties.VariableNames;
containsPA = sum(ismember(varNames,'PA'))==1;
if ~containsPA
    % Derive PA from PAfrq and PAint. Only run when "PA" is not present in
    % the table.
    F = cat2double(T.PAfrq);
    I = cat2double(T.PAint);
    T.PA = categorical(strcat("f",string(F),"i",string(I)));
    
elseif containsPA
    % Contains both, ensure no conflict (PA takes priority)
    PAstr = char(T.PA);
    F = str2double(PAstr(2));
    I = str2double(PAstr(4));
end

if F==1
    I = 1;
end

T.PAf23i23 = categorical(double(and(F>=2,I>=2)));
T.PAf4i3 = categorical(double(and(F==4,I==3)));
T.PAf3i3   = categorical(double(and(F==3,I==3)));
T.PAf2i2   = categorical(double(and(F==2,I==2)));

% ¤¤¤ Old Person category ¤¤¤
X = T.age;
T.old = categorical(double(X>=6.5));

% ¤¤¤ insomnia lvl 4 ¤¤¤
X = cat2double(T.insomnia);
T.insomnia4  = categorical(double(X==4));
T.insomnia34 = categorical(double(X>=3));

% ¤¤¤ Computing HSCL from Questionair variables ¤¤¤
containsHSCL = sum(ismember(varNames,'hscl'))==1;
if ~containsHSCL
    % Derive HSCL from Questionaire variables
    HCLvars = {'futureView','blameSelf','worried','depr','fear',...
                'dizzy','tense','useless','struggle','insomnia'};
        
    Thscl = table2array(subtable(T,HCLvars));

    % Defined as missing if more than 3 questions are not answered
    if sum(ismissing(Thscl),2)>3
        warning 'more than 3 mental health variables missing.'
    else
        T.hscl = mean(cat2double(Thscl), 2, 'omitnan');
    end
end

% ¤¤¤ Compute BMI ¤¤¤
containsBMI = sum(ismember(varNames,'bmi'))==1;
if ~containsBMI
    T.bmi = getIntervalIndex(T.weight/T.height^2,...
                            [0, 18.5, 25, 30, inf]);
    T.bmi = categorical(T.bmi);
end
% ** BMI lvl 3 and 4 **
X = cat2double(T.bmi);
T.bmi34 = categorical(double(X>=3));

% ¤¤¤ Sex ¤¤¤
if T.sex=="female"
    T.sex = categorical(0);
elseif T.sex=="male"
    T.sex = categorical(1);
end

end