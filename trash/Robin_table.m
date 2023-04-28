
lm = fitglme(data,strcat('srh ~ age + smoke+ sex + physact + insomnia + drinkFrq',...
    '+ heartAttack + useless + depr + bmi + worried + old + friendsSupp + angina + '))
%%
clear robin
robin.age = 3.2;
robin.sex = categorical("male");
robin.physact = categorical("1");
robin.physact34 = categorical("0");
robin.insomnia = categorical("4");
robin.drinkFrq = categorical("1");
robin.heartAttack = categorical("0");
robin.useless = categorical("3");
robin.depr = categorical("4");
robin.bmi = categorical("obese");
robin.worried = categorical("2");
robin.smoke = categorical("1");
robin.old = categorical("0");
robin.friendsSupp = categorical("0");
robin.angina = categorical("0");
robin.srh = 3;

T = struct2table(robin)
lme.CoefficientNames
lm.predict(T)
lme.predict(T)