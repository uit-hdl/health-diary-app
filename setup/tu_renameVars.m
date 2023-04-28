function x_new = tu_renameVars(data, oldName, i_survey)
% Utility function for renaming variables in the Tromsø datasets. Used in
% 'renameVariablesOfInterest.mat'

%% example input
% data = TUdata0;
% oldName = "EXERCISE_LEVEL";
% i_survey = [6,7];  % Since this variable only occurs in survey 6 and 7

%% function body
load('mat_info.mat','info')

N = height(data);
x_new = nan(N,1);
s = sprintf('%s_T%g',oldName,i_survey(1));

if ~ismember(s, data.Properties.VariableNames)
    x_old = data.(oldName);
    
    if iscategorical(x_old)
        x_new = categorical(x_new);
    end
       
    for i=1:numel(i_survey)
        str_survey = sprintf('T%g',i_survey(i));
        I_survey_i = info.(str_survey).I;
        x_new(I_survey_i) = x_old(I_survey_i);
    end    
    
else
    x_old = data.(sprintf('%s_T%g',oldName,i_survey(1)));
    
    if iscategorical(x_old)
        x_new = categorical(x_new);
    end
       
    for i=1:numel(i_survey)
        str_survey = sprintf('T%g',i_survey(i));
        str_old = sprintf('%s_%s', oldName, str_survey);
        I_survey_i = info.(str_survey).I;
        x_new(I_survey_i) = data.(str_old)(I_survey_i);
    end    
end


end