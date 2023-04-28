
%% Create young user
id = 0;
srh = 3;
t = 7;
% ¤¤¤ General Info ¤¤¤
age = 30 / 10;
sex = categorical(1);
weight = 88;
height = 1.79;
education = categorical(3);
% ¤¤¤ Diseases, habits and social ¤¤¤
smokeNow = categorical(0);
highBP = categorical(1);
diabHba1c = categorical(1);
hii = 1.8;
friendsSupp = categorical(1);
liveWspouse = categorical(1);
% ¤¤¤ Exercise ¤¤¤
PAfrq = categorical(2);
PAint = categorical(2);
% ¤¤¤ HSCL ¤¤¤
futureView = categorical(2);
struggle = categorical(1);
useless = categorical(1);
depr = categorical(2);
blameSelf = categorical(1);
tense = categorical(1);
dizzy = categorical(1);
worried = categorical(1);
fear = categorical(1);
insomnia = categorical(2); %#ok<*ADPROPLC>

T_user = table(t, id, srh, age, sex, weight, height, education, ...
    smokeNow, highBP, ...
    diabHba1c, hii, ...
    friendsSupp, liveWspouse, ...
    PAfrq, PAint, ...
    futureView, struggle, useless, depr, blameSelf, ...
    tense, dizzy, worried, fear, insomnia);

T_user = map_userdata_to_model_input(T_user);


% Predict
lme = load_model(navi)
y_0 = lme.predict(T_user)

