%% analysis of Micheal
clear peter robin lisa

bmiCats = myunique(data.bmi);

% *** Robin ***
% Robin is a 32 years old middleweight man. He smokes, has sleep issues,
% does not exercise, and has felt a little depressed the last two weeks.
robin.srh = 3;
robin.id = 1;
robin.age = 3.2;
robin.sex = categorical("male");
robin.physact = categorical("1");
robin.physact34 = categorical("0");
robin.insomnia = categorical("4");
robin.drinkFrq = categorical("1");
robin.heartAttack = categorical("0");
robin.depr = categorical("4");
robin.bmi = categorical("norm");
robin.worried = categorical("3");
robin.smoke = categorical("1");
robin.old = categorical("0");
robin.friendsSupp = categorical("0");
robin.angina = categorical("0");


robin = struct2table(robin);

% Lisa is a 21 year old obese woman. She sleeps ok. She smokes, 
% does no physical activity on an average
% week, and feels somewhat depressed.
% *** lisa ***
lisa.srh = 3;
lisa.id = 2;
lisa.age = 2.1;
lisa.sex = categorical("female");
lisa.physact = categorical("1");
lisa.physact34 = categorical("0");
lisa.insomnia = categorical("1");
lisa.drinkFrq = categorical("2");
lisa.heartAttack = categorical("0");
lisa.depr = categorical("2");
lisa.bmi = categorical("obese");
lisa.worried = categorical("3");
lisa.smoke = categorical("1");
lisa.old = categorical("0");
lisa.friendsSupp = categorical("1");
lisa.angina = categorical("0");

lisa = struct2table(lisa);

% *** Peter *** Peter is a 67 year old man who is very physically active,
% and has a BMI in the underweight range. He has issues with sleep multiple
% times per week. He does not smoke or drink.
peter.id = 3;
peter.srh = 3;
peter.age = 6.7;
peter.sex = categorical("female");
peter.physact = categorical("3");
peter.physact34 = categorical("1");
peter.insomnia = categorical("3");
peter.drinkFrq = categorical("1");
peter.heartAttack = categorical("0");
peter.depr = categorical("1");
peter.bmi = categorical("under");
peter.worried = categorical("2");
peter.smoke = categorical("0");
peter.old = categorical("1");
peter.friendsSupp = categorical("1");
peter.angina = categorical("0");

peter = struct2table(peter);
% lme.predict(robinsTable)

T = [robin;peter;peter];
T.bmi = categorical(T.bmi,'Ordinal',true)
T.Properties.RowNames = ["robin","peter","lisa"] %#ok<*NOPTS>
% lme.predict(robinsTable)
%% Create robins version bar chart:
decisionVars = ["bmi","insomnia","physact","depr","smoke","drink"];

Nversions = 7;
robin_ver = cell(1,Nversions);
versionName = cell(1,Nversions);
for i=1:Nversions
    robin_ver{i} = robin;
end

versionName{1} = 'current';

versionName{2} = 'reduce insomnia';
robin_ver{2}.insomnia = categorical(2);

versionName{3} = 'fix insomnia';
robin_ver{3}.insomnia = categorical(1);

versionName{4} = 'PA: 0-1 hrs/week';
robin_ver{4}.physact = categorical(2);

versionName{5} = 'PA: 1-2 hrs/week';
robin_ver{5}.physact = categorical(3);

robin_ver{6}.depr = categorical(1);
versionName{6} = 'reduce depression';

robin_ver{7}.smoke = categorical(0);
versionName{7} = 'quit smoking';

robinsTable = robin_ver{1};
for i=2:Nversions
    robinsTable = [robinsTable;robin_ver{i}]; %#ok<*AGROW>
end

subplot(1,3,1)
robin_p = lme.predict(robinsTable)
barText = categorical(versionName);
barText = reordercats(barText,versionName);
bar(barText,robin_p,0.4)
str1 = 'Robin is a 32 years old middleweight man. He smokes,';
str2 = 'has sleep issues, does not exercise, and has felt ';
str3 = 'quite depressed recently.';
str = sprintf('%s \n %s \n %s \n',str1,str2,str3)
title(str)



%% Create Peters version bar chart:
Nversions = 5;
peterV = cell(1,Nversions);
versionName = cell(1,Nversions);
for i=1:Nversions
    peterV{i} = peter;
end

versionName{1} = 'current';

versionName{2} = 'bmi: under weight --> normal';
peterV{2}.bmi = categorical("norm");

versionName{3} = 'reduce insomnia';
peterV{3}.insomnia = categorical(2);

versionName{4} = 'fix insomnia';
peterV{4}.insomnia = categorical(1);

versionName{5} = 'PA: at least 3 hrs/week';
peterV{5}.physact = categorical(4);

petersTable = peterV{1};
for i=2:Nversions
    petersTable = [petersTable;peterV{i}]; %#ok<*AGROW>
end

subplot(1,3,2)
peter_p = lme.predict(petersTable)
barText = categorical(versionName);
barText = reordercats(barText,versionName);
bar(barText,peter_p,0.4)
str1 = 'Peter is a 67 year old underweight man  '
str2 = 'who is very physically active. He  '
str3 = 'experiences sleep issues multiple times '
str4 = 'per week. He does not smoke or drink.'
str = sprintf('%s \n %s \n %s \n %s \n',str1, str2, str3,str4)
title(str)


%% Create lisas version bar chart:
Nversions = 7;
lisaV = cell(1,Nversions);
versionName = cell(1,Nversions);
for i=1:Nversions
    lisaV{i} = lisa;
end

versionName{1} = 'current';

versionName{2} = 'bmi: obese --> over-weight';
lisaV{2}.bmi = categorical("over");

versionName{3} = 'PA: 0-1 hrs/week';
lisaV{3}.physact = categorical(2);

versionName{4} = 'PA: 2-3 hrs/week';
lisaV{4}.physact = categorical(3);

versionName{5} = 'reduce depression';
lisaV{5}.depr = categorical(2);

versionName{6} = 'reduce worry';
lisaV{6}.worried = categorical(2);

versionName{7} = 'quit smoking';
lisaV{7}.smoke = categorical(0);

lisasTable = lisaV{1};
for i=2:Nversions
    lisasTable = [lisasTable;lisaV{i}]; %#ok<*AGROW>
end

subplot(1,3,3)
lisa_p = lme.predict(lisasTable)
barText = categorical(versionName);
barText = reordercats(barText,versionName);
bar(barText,lisa_p,0.4)
str1 = 'Lisa is a 21 year old obese woman. She experiences sleep'
str2 = 'issues a few times per month. She smokes, is not physically '
str3 = 'active, and feels somewhat depressed.'
str = sprintf('%s \n %s \n %s \n',str1,str2,str3);
title(str)

sgtitle('Expected effect on health') 
%%
micheal_0 = table(age,physact,smoke,depr,id);
micheal_1 = micheal_0;
micheal_2 = micheal_0;
micheal_3 = micheal_0;
micheal_4 = micheal_0;

micheal = table(age,physact,smoke,depr,id);

micheal_1.physact = categorical(min(double(micheal_0.physact) + 1,4));
micheal_2.physact = categorical(min(double(micheal_0.physact) + 2,4));
micheal_3.smoke = categorical( max(double(micheal_0.smoke) - 1,0) );
micheal_4.depr  = categorical( max(cat2double(micheal_0.depr) - 1,0) );

p(1) = dec2perc( 1-binocdf(3 -1,4,lme.predict(micheal_0)));
p(2) = dec2perc( 1-binocdf(3 -1,4,lme.predict(micheal_1)));
p(3) = dec2perc( 1-binocdf(3 -1,4,lme.predict(micheal_2)));
p(4) = dec2perc( 1-binocdf(3 -1,4,lme.predict(micheal_3)));
p(5) = dec2perc( 1-binocdf(3 -1,4,lme.predict(micheal_4)));

colNames = ["current condition","add 0-1 hrs ex./week","add 1-2 hrs ex./week",...
            "stop smoking", "Improve depression"];

T = array2table(p,'v',colNames);

T(2,:) = num2cell(p - p0_atleast3);
T{2,1} = nan
T.Properties.RowNames = ["prob. (%)" "prob. increase (%)"]
giveTitle2table(micheal,"Mikael")
T = giveTitle2table(T,"*** PROBABILITY SRH ATLEAST GOOD ***")