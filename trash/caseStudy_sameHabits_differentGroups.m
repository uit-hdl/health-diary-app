% Generate fictional characters
clear peter robin lisa


unorderedCats = renameAndRelevel(categorical(["0" "1"]),[],["1","0"])
bmiCats = myunique(data.bmi);
sexCats = myunique(data.sex);
% *** Robin ***
% Robin is a 32 years old middleweight man. He smokes, has sleep issues,
% does not exercise, and has felt a little depressed the last two weeks.
robin.id = 0; % assign arbitrary id; does not matter.
robin.srh = 3;
% unchangable variables:
robin.age = 32/10; % age in decade
robin.old = categorical(0);
robin.sex = sexCats(2);
% decision variables
robin.bmi = bmiCats(bmiCats=="obese");
robin.insomnia = categorical(3);
robin.physact = categorical(1); 
robin.physact23 = unorderedCats(unorderedCats=="0");
robin.physact34 = categorical(0); 
robin.depr = categorical(3);
robin.smoke = categorical(0);
robin.drink = categorical(3);
robin.friendsSupp = categorical(1);

robin = struct2table(robin);


% Lisa is a 21 year old obese woman. She experiences sleep issues a few
% times per month. She smokes, does no physical activity on an average
% week, and feels somewhat depressed.

% *** lisa ***
lisa.id = 0; % assign arbitrary id; does not matter.
lisa.srh = 3;
% unchangable variables:
lisa.age = 22/10; % age in decade
lisa.old = categorical(0);
lisa.sex = sexCats(1);
% decision variables
lisa.bmi = bmiCats(bmiCats=="obese");
lisa.insomnia = categorical(3);
lisa.physact = categorical(1); % Bobba does not exercise
lisa.physact23 = unorderedCats(unorderedCats=="0"); 
lisa.physact34 = categorical(0); 
lisa.depr = categorical(3);
lisa.smoke = categorical(0);
lisa.drink = categorical(3);
lisa.friendsSupp = categorical(1);


lisa = struct2table(lisa);

% *** Peter *** Peter is a 67 year old man who is very physically active,
% and has a BMI in the underweight range. He has issues with sleep multiple
% times per week. He does not smoke or drink.
peter.id = 0; % assign arbitrary id; does not matter.
peter.srh = 3;
% unchangable variables:
peter.age = 75/10; % age in decade
peter.old = categorical(1);
peter.sex = sexCats(2);
% decision variables
peter.bmi = bmiCats(bmiCats=="obese");
peter.insomnia = categorical(3);
peter.physact = categorical(2);
peter.physact23 = unorderedCats(unorderedCats=="0"); 
peter.physact34 = categorical(0); 
peter.depr = categorical(3);
peter.smoke = categorical(0);
peter.drink = categorical(3);
peter.friendsSupp = categorical(1);


peter = struct2table(peter);

T = [robin;peter;lisa];
T.bmi = categorical(T.bmi,'Ordinal',true)
T.Properties.RowNames = ["robin","peter","lisa"] %#ok<*NOPTS>

% $$ ¤¤ CREATE PLOTS ¤¤ $$
%% Create robins version bar chart:

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

versionName{4} = 'PA: 1-2 hrs/week';
robin_ver{4}.physact = categorical(3);

versionName{5} = 'PA: 3+ hrs/week';
robin_ver{5}.physact = categorical(4);

robin_ver{6}.depr = categorical(2);
versionName{6} = 'improve depression';

robin_ver{6}.depr = categorical(2);
versionName{6} = 'improve depression';

robin_ver{7}.bmi = bmiCats(bmiCats=="norm");
versionName{7} = 'obese-->normal';


robinsTable = robin_ver{1};
for i=2:Nversions
    robinsTable = [robinsTable;robin_ver{i}]; %#ok<*AGROW>
end

subplot(1,3,1)
    robin_p = 100*binopdf(4,4,lme.predict(robinsTable))
    barText = categorical(versionName);
    barText = reordercats(barText,versionName);
    bar(barText,robin_p,0.4,'k')
    str = '32 year old obese and inactive man'
    title(str)



%% Create robins version bar chart:
decisionVars = ["bmi","insomnia","physact","depr","smoke","drink", "friendsSupp"];
Nversions = 7;
lisa_ver = cell(1,Nversions);
versionName = cell(1,Nversions);
for i=1:Nversions
    lisa_ver{i} = lisa;
end

versionName{1} = 'current';

versionName{2} = 'reduce insomnia';
lisa_ver{2}.insomnia = categorical(2);

versionName{3} = 'fix insomnia';
lisa_ver{3}.insomnia = categorical(1);

versionName{4} = 'PA: 1-2 hrs/week';
lisa_ver{4}.physact = categorical(3);

versionName{5} = 'PA: 3+ hrs/week';
lisa_ver{5}.physact = categorical(4);

lisa_ver{6}.depr = categorical(2);
versionName{6} = 'improve depression';

lisa_ver{7}.bmi = bmiCats(bmiCats=="norm");
versionName{7} = 'obese-->normal';


lisasTable = lisa_ver{1};
for i=2:Nversions
    lisasTable = [lisasTable;lisa_ver{i}]; %#ok<*AGROW>
end

subplot(1,3,2)
    lisa_p = 100*binopdf(4,4,lme.predict(lisasTable))
    barText = categorical(versionName);
    barText = reordercats(barText,versionName);
    bar(barText,lisa_p,0.4,'k')
    str = '22 year old obese and inactive woman'
    title(str)

%% Create Peters version bar chart:
Nversions = 7;
peter_ver = cell(1,Nversions);
versionName = cell(1,Nversions);
for i=1:Nversions
    peter_ver{i} = peter;
end

versionName{1} = 'current';

versionName{2} = 'reduce insomnia';
peter_ver{2}.insomnia = categorical(2);

versionName{3} = 'fix insomnia';
peter_ver{3}.insomnia = categorical(1);

versionName{4} = 'PA: 1-2 hrs/week';
peter_ver{4}.physact = categorical(3);

versionName{5} = 'PA: 3+ hrs/week';
peter_ver{5}.physact = categorical(4);

peter_ver{6}.depr = categorical(2);
versionName{6} = 'improve depression';

peter_ver{7}.bmi = bmiCats(bmiCats=="norm");
versionName{7} = 'obese-->normal';

petersTable = peter_ver{1};
for i=2:Nversions
    petersTable = [petersTable;peter_ver{i}]; %#ok<*AGROW>
end

subplot(1,3,3)
    peter_p = 100*binopdf(4,4,lme.predict(petersTable))
    barText = categorical(versionName);
    barText = reordercats(barText,versionName);
    bar(barText,peter_p,0.4,'k')
    str = '75 year old obese and inactive man'
    title(str)