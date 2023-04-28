
% Description: 32 years old, smokes, obese, physically inactive, poor
% mental health, Diabetes, poor sleep. Example of someone with overall
% really poor health.

clear bobba
bobba.t = 7;
bobba.hii = 4;
bobba.id = 0;
bobba.education = categorical(1);
bobba.srh = 2;
bobba.age = 3.2;
bobba.friendsSupp = categorical(0);
bobba.liveWspouse = categorical(0);
bobba.strokeOrHrtAtk = categorical(0);
bobba.sex = 'male';
bobba.smokeNow = categorical(1);
bobba.height = 1.8;
bobba.weight = 105;
bobba.hypert = categorical(1);
bobba.highBP = categorical(1);
bobba.PAfrq = categorical(1);
bobba.PAint = categorical(1);
bobba.diabHba1c = categorical(1);
bobba.insomnia = categorical(4);
bobba.tense = categorical(3);
bobba.futureView = categorical(3);
bobba.fear = categorical(2);
bobba.worried = categorical(3);
bobba.dizzy = categorical(2);
bobba.depr = categorical(4);
bobba.struggle = categorical(4);
bobba.useless = categorical(4);
bobba.blameSelf = categorical(4);
% bobba.hscl = 3;
bobba = struct2table(bobba);

bobba = rawUserData2ModelInput(bobba);
