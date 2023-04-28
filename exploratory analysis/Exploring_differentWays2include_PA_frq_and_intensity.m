theGreatVariableForge

%%
modelData = data(data.t >= 6, :);
modelData.PA11 = myand(util_compare(modelData.PAfrq, 'eq', '1'), util_compare(modelData.PAint, 'eq', '1'));

modelData.PA12 = myand(util_compare(modelData.PAfrq, 'eq', '1'), util_compare(modelData.PAint, 'eq', '2'));
modelData.PA13 = myand(util_compare(modelData.PAfrq, 'eq', '1'), util_compare(modelData.PAint, 'eq', '3'));
modelData.PAnonsense = myor(modelData.PA12, modelData.PA13);

modelData.PA21 = myand(util_compare(modelData.PAfrq, 'eq', '2'), util_compare(modelData.PAint, 'eq', '1'));
modelData.PA22 = myand(util_compare(modelData.PAfrq, 'eq', '2'), util_compare(modelData.PAint, 'eq', '2'));
modelData.PA23 = myand(util_compare(modelData.PAfrq, 'eq', '2'), util_compare(modelData.PAint, 'eq', '3'));

modelData.PA31 = myand(util_compare(modelData.PAfrq, 'eq', '3'), util_compare(modelData.PAint, 'eq', '1'));
modelData.PA32 = myand(util_compare(modelData.PAfrq, 'eq', '3'), util_compare(modelData.PAint, 'eq', '2'));
modelData.PA33 = myand(util_compare(modelData.PAfrq, 'eq', '3'), util_compare(modelData.PAint, 'eq', '3'));

modelData.PAnonsense = mycategorical(modelData.PAnonsense);
modelData.PA11 = mycategorical(modelData.PA11);
modelData.PA21 = mycategorical(modelData.PA21);
modelData.PA22 = mycategorical(modelData.PA22);
modelData.PA23 = mycategorical(modelData.PA23);
modelData.PA31 = mycategorical(modelData.PA31);
modelData.PA32 = mycategorical(modelData.PA32);
modelData.PA33 = mycategorical(modelData.PA33);

%%
lme1 = fitglme(modelData, 'srh ~ PA11 + PA12 + PA13 + PA21 + PA23 + PA31 + PA32 + PA33 + (1|id)');
% lme1 = fitglme(modelData,'srh ~ PA11 + PA12 + PA13 + PA21 + PA22 + PA23 + PA31 +(1|id)')
lme2 = fitglme(modelData, 'srh ~ PAfrq*PAint + (1|id)');
lme3 = fitglme(modelData, 'srh ~ PA + (1|id)');

%%

close all
figure
subplot(131)
plotCoeffLinearModel(lme1)
ylim([-0.4, 1])
subplot(132)
plotCoeffLinearModel(lme2)
ylim([-0.4, 1])
subplot(133)
plotCoeffLinearModel(lme3)
ylim([-0.4, 1])

%% Encoding PA as one categorical Variable with 9 levels
X = categorical(nan(height(modelData), 1));
X(and(modelData.PAfrq == "1", modelData.PAint == "1")) = 'f1i1';
X(and(modelData.PAfrq == "1", modelData.PAint == "2")) = 'f1i2';
X(and(modelData.PAfrq == "1", modelData.PAint == "3")) = 'f1i3';
X(and(modelData.PAfrq == "2", modelData.PAint == "1")) = 'f2i1';
X(and(modelData.PAfrq == "2", modelData.PAint == "2")) = 'f2i2';
X(and(modelData.PAfrq == "2", modelData.PAint == "3")) = 'f2i3';
X(and(modelData.PAfrq == "3", modelData.PAint == "1")) = 'f3i1';
X(and(modelData.PAfrq == "3", modelData.PAint == "2")) = 'f3i2';
X(and(modelData.PAfrq == "3", modelData.PAint == "3")) = 'f3i3';
X = mergecats(X, {'f1i2', 'f1i3'});
X = renamecats(X, {'f1i2'}, {'nonsense'});
X = mycategorical(X)
modelData.PA = X;

lme3 = fitglme(modelData, 'srh ~ PA + (1|id)')

figure
plotCoeffLinearModel(lme3)

%% physact and PAfrq
modelData.pa11 = myand(util_compare(modelData.PAfrq, 'eq', '1'), util_compare(modelData.physact, 'eq', '1'));

modelData.pa12 = myand(util_compare(modelData.PAfrq, 'eq', '1'), util_compare(modelData.physact, 'eq', '2'));
modelData.pa13 = myand(util_compare(modelData.PAfrq, 'eq', '1'), util_compare(modelData.physact, 'eq', '3'));
modelData.PAnonsense = myor(modelData.pa12, modelData.pa13);

modelData.pa21 = myand(util_compare(modelData.PAfrq, 'eq', '2'), util_compare(modelData.physact, 'eq', '1'));
modelData.pa22 = myand(util_compare(modelData.PAfrq, 'eq', '2'), util_compare(modelData.physact, 'eq', '2'));
modelData.pa23 = myand(util_compare(modelData.PAfrq, 'eq', '2'), util_compare(modelData.physact, 'eq', '3'));

modelData.pa31 = myand(util_compare(modelData.PAfrq, 'eq', '3'), util_compare(modelData.physact, 'eq', '1'));
modelData.pa32 = myand(util_compare(modelData.PAfrq, 'eq', '3'), util_compare(modelData.physact, 'eq', '2'));
modelData.pa33 = myand(util_compare(modelData.PAfrq, 'eq', '3'), util_compare(modelData.physact, 'eq', '3'));

figure
lme3 = fitglme(modelData, 'srh ~ physact + (1|id)')
lme4 = fitglme(modelData, 'srh ~ PAnonsense + pa21 + pa22 + pa23 + pa31 + pa32 + pa33 +(1|id)')

figure
subplot(121)
plotCoeffLinearModel(lme3)
subplot(122)
plotCoeffLinearModel(lme4)