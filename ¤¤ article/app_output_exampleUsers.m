% In this script I create two fictional users, and show what their output
% looks like

%% preliminary
id = 0; srh = 3; t = 7;
lme = load_model(navi);

%% Create data for old overweight man
% ¤¤¤ General Info ¤¤¤
age = 68 / 10;
sex = categorical(1);
weight = 88;
height = 1.79;
education = categorical(3);
% ¤¤¤ Diseases, habits and social ¤¤¤
smokeNow = categorical(1);
highBP = categorical(1);
diabHba1c = categorical(1);
hii = 1.8;
friendsSupp = categorical(1);
liveWspouse = categorical(1);
% ¤¤¤ Exercise ¤¤¤
PAfrq = categorical(2);
PAint = categorical(1);
% ¤¤¤ HSCL ¤¤¤
futureView = categorical(1);
struggle = categorical(1);
useless = categorical(1);
depr = categorical(2);
blameSelf = categorical(1);
tense = categorical(1);
dizzy = categorical(1);
worried = categorical(1);
fear = categorical(1);
insomnia = categorical(2); %#ok<*ADPROPLC>
T_oldMan = table(t, id, srh, age, sex, weight, height, education, ...
    smokeNow, highBP, ...
    diabHba1c, hii, ...
    friendsSupp, liveWspouse, ...
    PAfrq, PAint, ...
    futureView, struggle, useless, depr, blameSelf, ...
    tense, dizzy, worried, fear, insomnia);

T_user = map_userdata_to_model_input(T_oldMan) %#ok<*NASGU> 

lme.predict()
main_plotSuggestedChanges(T_oldMan, lme)

%% Create data for middleaged woman with psychological distress
id = 0; srh = 3; t = 7;
% ¤¤¤ General Info ¤¤¤
age = 32 / 10;
sex = categorical(0);
height = 1.67;
weight = 75.2;
education = categorical(3);
% ¤¤¤ Diseases, habits and social ¤¤¤
smokeNow = categorical(0);
diabHba1c = categorical(0);
hii = 0;
friendsSupp = categorical(1);
liveWspouse = categorical(1);
% ¤¤¤ Exercise ¤¤¤
PAfrq = categorical(1);
PAint = categorical(2);
% ¤¤¤ HSCL ¤¤¤
futureView = categorical(3);
struggle = categorical(2);
useless = categorical(3);
depr = categorical(3);
blameSelf = categorical(3);
tense = categorical(2);
dizzy = categorical(1);
worried = categorical(4);
fear = categorical(3);
insomnia = categorical(2); %#ok<*ADPROPLC>

T_worriedWoman = table(t, id, srh, age, sex, weight, height, education, ...
    smokeNow, ...
    diabHba1c, hii, ...
    friendsSupp, liveWspouse, ...
    PAfrq, PAint, ...
    futureView, struggle, useless, depr, blameSelf, ...
    tense, dizzy, worried, fear, insomnia);
lm_input_table = map_userdata_to_model_input(T_worriedWoman);

lme = load_model()
T_user = T_worriedWoman

main_plotSuggestedChanges(T_worriedWoman, lme)
%%

% Save user to file
user_folder = "C:\Users\perwa\OneDrive - UiT Office 365\Health companion app\saved matlab files\user-tables";
user_file = fullfile(user_folder, "T_user.mat");
save(user_file, 'T')

% load model:
model_folder = "C:\Users\perwa\OneDrive - UiT Office 365\Health companion app\saved matlab files\models";
model_file = fullfile(model_folder, "model_jan_17.mat");
load(model_file, 'lme');

close all
main_plotSuggestedChanges(T, lme)