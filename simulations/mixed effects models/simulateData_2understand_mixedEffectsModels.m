%#ok<*NOPTS>
% the average person exercises for 30 minutes a week, does not smoke, does
% not have diabetes, and has a SRH of 3:
%      1-4     1-2    1-2     1-2     1-2    1-2     1-2
%      physact smoke social  stress  sleep alcohol nutrition

% a very simple model that includes PA as fcn of SRH
M = [[1,1];[2,3];...
     [3,3];[2,2];...
     [1,3];[4,4];...
     [2,1];[2,2];...
     [2,1];[1,1];...
     [4,4];[3,4];...
     [4,4];[3,4];...
     [4,4];[3,4];...
     [4,4];[2,4];...
     [4,3];[3,4];...
     [2,2];[3,2]];

 
 % a very simple model
% M = [[1,1];[2,3];...
%      [1,1];[1,4];...
%      [1,1];[1,1];...
% %      [2,2];[3,2]];
 
%  M = [ [1,1]; [1,3];  [1,1];[3,1];  [1,1];[3,1] ];


Nrows = height(M);
Nid = floor(Nrows/2);
id  = zeros(Nrows,1);
id(mod(1:Nrows,2)==0) = 1:Nid;
id(mod(1:Nrows,2)==1) = 1:Nid;
M = [id,M];

delta = M(mod(1:Nrows,2)==0,:)-M(mod(1:Nrows,2)==1,:);
XdeMeaned = demeanVariables(M)
lm1 = fitlm(delta(:,2),delta(:,3))
lm2 = fitlm(XdeMeaned(:,1),XdeMeaned(:,2))


data = array2table(M,'v',{'id','pa','srh'})
lme0 = fitlme(data,'srh ~ 1 + pa + (1|id)')
lme1 = fitlme(data,'srh ~ 1 + pa')
lme2 = fitlme(data,'srh ~ 1 + pa + (pa-1|id)')
lme3 = fitglme(data,'srh ~ pa + (1|id)','Distribution','poisson')
lme0.Coefficients
lme1.Coefficients
lme2.Coefficients
lme3.Coefficients
%% model comparisons
util_compare(lme0,lme1)

%% MANUALL FITTING OF MIXED EFFECTS MODEL
% mode: y = X*beta + Z*b + e
y = data.srh;
X = [ones(height(M),1),data.pa];
Z = [ones(height(M),1),data.pa];
% Z = ones(height(M),1);
% grouping variable
G = data.id;

lmeMatrix = fitlmematrix(X,y,Z,G);
lmeMatrix.Coefficients
%% Turn SRH into binary variable
M = [[1,0];[2,1];...
     [3,0];[2,1];...
     [1,1];[4,1];...
     [2,0];[2,0];...
     [2,1];[1,0];...
     [4,1];[3,1];...
     [4,1];[3,1];...
     [4,1];[3,1];...
     [4,1];[2,0];...
     [4,1];[3,1];...
     [2,0];[3,1]];

 
 % a very simple model
% M = [[1,1];[2,3];...
%      [1,1];[1,4];...
%      [1,1];[1,1];...
% %      [2,2];[3,2]];
 
%  M = [ [1,1]; [1,3];  [1,1];[3,1];  [1,1];[3,1] ];

Nrows = height(M);
Nid = floor(Nrows/2);
id  = zeros(Nrows,1);
id(mod(1:Nrows,2)==0) = 1:Nid;
id(mod(1:Nrows,2)==1) = 1:Nid;
M = [id,M];

delta = M(mod(1:Nrows,2)==0,:)-M(mod(1:Nrows,2)==1,:);
XdeMeaned = demeanVariables(M)
lm1 = fitglm(delta(:,2),delta(:,3))
lm2 = fitlm(XdeMeaned(:,1),XdeMeaned(:,2))


data = array2table(M,'v',{'id','pa','srh'})
% lme = fitlme(data,'srh ~ pa + (pa-1|id) + (1|id)'
lme0 = fitlme(data,'srh ~ pa + (1|id)')
lme1 = fitlme(data,'srh ~ 1 + pa')
lme2 = fitlme(data,'srh ~ 1 + pa + (pa+1|id)')
glme = fitglme(data,'srh ~ pa + (1|id)','Distribution','bin')
lme0.Coefficients
lme1.Coefficients
lme2.Coefficients
glme.Coefficients
%%

y = data.srh;
X = [ones(height(M),1),data.pa];
Z = [ones(height(M),1),data.pa];
% Z = ones(height(M),1);
% grouping variable
G = data.id;

lmeMatrix = fitlmematrix(X,y,Z,G);
lmeMatrix.Coefficients



%% old way... was slow an inefficient
average = [1,0,0,3];

% john has low activity level, smokes, does not have diabetes, and has
% SRH of 2.
john = array2table([[1,1,0,2] [3,1,0,3]]','v',{'john'})
% john started exercising 1 year later, and as a result he feels better:
john2 = array2table([3,1,0,3],'v',{'physact','smoke','diabetes','srh'})

% chris exercises, smokes, has diabetes, and has a SRH of 1
chris1 = array2table([2,1,0,2],'v',{'physact','smoke','diabetes','srh'})
% chris quit smoking a year later, and feels better because of it:
chris2 = array2table([2,1,0,3],'v',{'physact','smoke','diabetes','srh'})

siri1 = array2table([1,1,0,2],'v',{'physact','smoke','diabetes','srh'})
% siri improved her diet, and got rid of her diabetes.
siri2 = array2table([1,1,0,3],'v',{'physact','smoke','diabetes','srh'})


david1 = array2table(average + [-1 0 0 0],'v',{'physact','smoke','diabetes','srh'})
% siri improved her diet, and got rid of her diabetes.
david2 = array2table(average + [+1 0 0 2],'v',{'physact','smoke','diabetes','srh'})

%% simulate data to confirm model works as intended:
% model: Y = 2.5 + alfa_i + 3.1 * x + e
% where 
% alfa_i ~ norm(0,1.3)
% e ~ nomr(0, 1.5)

% first simulate random individual intercepts:
Nindiv = 10000;
beta_indiv = 2.5 + normrnd(zeros(Nindiv,1),1.3);

% simulate x (which represents amount of exercise per week)
x1 = mygamrnd(2,0.4,[Nindiv,1]);
x2 = mygamrnd(2,0.4,[Nindiv,1]);
x = [x1;x2];

% simulate gender:
sex1 = randn([Nindiv,1])>0; % >0 --> male (assume males are slightly happier)
sex2 = sex1;
sex = [sex1;sex2];

e1 = normrnd(0,1.5,[Nindiv,1]);
e2 = normrnd(0,1.5,[Nindiv,1]);

id = [ones(Nindiv,1); 2*ones(Nindiv,1)];

Y1 = beta_indiv + 1*sex1 + 3.1*x1 + e1;
Y2 = beta_indiv + 1*sex2 + 3.1*x2 + e2;
Y = [Y1;Y2];

simTable = table(Y,x,sex,id);

glm = fitglme(simTable,'Y ~ x + sex + (1|id)');

glm.Coefficients

T_deMeaned = demeanVariables(simTable,'id');
simlm = fitlm(T_deMeaned(:,2),T_deMeaned(:,1));
% it finally works!!! I can manually estimate the parameters!

%% create a larger model with more covariates
% model: Y = 2.5 + alfa_i + 0.8 * x + e
% where 
% alfa_i ~ norm(0,1.3)
% e ~ nomr(0, 1.5)

% set number of individuals and measurments per person:
Nindiv = 1000;
Nmeas = 2;

% simulate individual intercepts:
beta_indiv = 2.0 + normrnd(zeros(Nindiv,1),1);

% simulate x (amount of exercise per week):
sigma_e = 1.5;
sigma_x1 = 0.4;
sigma_x2 = 0.4;
sigma_x3 = 0.6;
x1 = mygamrnd(1,sigma_x1,[Nindiv,Nmeas]);
x2 = mygamrnd(1,sigma_x2,[Nindiv,Nmeas]);
x3 = mygamrnd(1,sigma_x3,[Nindiv,Nmeas]);
e = normrnd(0,sigma_e,[Nindiv,Nmeas]);

% get id-numbers:
id = 1:Nindiv;
id = repmat(id',[Nmeas,1]);


beta_x1 = 0.8;
beta_x2 = 0.2;
beta_x3 = -0.3;
x1 = reshape(x1,[width(x1)*height(x1),1]);
x2 = reshape(x2,[width(x2)*height(x2),1]);
x3 = reshape(x3,[width(x3)*height(x3),1]);
e = reshape(e,[Nmeas*Nindiv,1]);
Y = repmat(beta_indiv,[Nmeas,1]) + beta_x1*x1 + beta_x2*x2 + beta_x3*x3 + e; 

simTable = table(Y,x1,x2,x3,id);

glm = fitlme(simTable,'Y ~ x1 + x2 + x3 +(1|id)');
glm.Coefficients
glm_reml.Coefficients

T_deMeaned = demeanVariables(simTable,'id')
simlm = fitlm(T_deMeaned(:,2:end), T_deMeaned(:,1));

[simlm.Coefficients.pValue';...
glm.Coefficients.pValue']
[simlm.Coefficients.Estimate';...
glm.Coefficients.Estimate']
%% understanding generalized mixed effects models
x = 3.1;
id = 0;
T = table(x,id);
%% Binomial model
% model: log(p/(1-p)) = 2.5 + alfa_i + 0.8 * x + e
% set number of individuals and measurments per person:
Nindiv = 5000;
Nmeas = 1;

% simulate individual intercepts:
beta_0 = -0.3;
beta_indiv = beta_0 + normrnd(zeros(Nindiv,1),1);

% simulate x (amount of exercise per week):
sigma_e = 0.01;
sigma_x1 = 0.3;
sigma_x2 = 0.3;
sigma_x3 = 0.5;
x1 = mygamrnd(1,sigma_x1,[Nindiv,Nmeas]);
x2 = mygamrnd(1,sigma_x2,[Nindiv,Nmeas]);
x3 = mygamrnd(1,sigma_x3,[Nindiv,Nmeas]);
e = normrnd(0,sigma_e,[Nindiv,Nmeas]);

% get id-numbers:
id = 1:Nindiv;
id = repmat(id',[Nmeas,1]);

beta_x1 = 1.3;
beta_x2 = 0.2;
beta_x3 = -0.3;
x1 = reshape(x1,[width(x1)*height(x1),1]);
x2 = reshape(x2,[width(x2)*height(x2),1]);
x3 = reshape(x3,[width(x3)*height(x3),1]);
e = reshape(e,[Nmeas*Nindiv,1]);
X_mult_beta = repmat(beta_indiv,[Nmeas,1]) + beta_x1*x1 + beta_x2*x2 + beta_x3*x3 + e; %#ok<*NASGU>
X_mult_beta = repmat(beta_indiv,[Nmeas,1]) + beta_x1*x1 + e;
P = logit_inv(X_mult_beta);
NsrhLvls = 1;
Y = binornd(NsrhLvls,P);



simTable = table(Y,x1,x2,x3,id);
% T_deMeaned = demeanVariables(simTable,'id')

% glm_bino = fitglme(simTable,'Y ~ x1 + x2 + x3 + (1|id)','Distribution','binomial',...
%                         'BinomialSize',NsrhLvls,'link','logit');
% glm_bino.Coefficients
% glm_bino = fitglme(simTable,'Y ~ x1 + (1|id)','Distribution','binomial')
tic
fitMethods = {'MPL','REMPL','ApproximateLaplace','Laplace'};
glm_bino = fitglme(simTable,'Y ~ x1 + (1|id)','Distribution','binomial',...
                'BinomialSize',NsrhLvls,'FitMethod',fitMethods{1})


glm_bino.Coefficients
close;figure;
histogram(simTable.Y)
toc
%% simulate cross sectional data:
Nindiv = 200000;
% simulate x (amount of exercise per week):
sigma_e = 0.2;
sigma_x1 = 0.3;
sigma_x2 = 0.3;
sigma_x3 = 0.5;
x1 = mygamrnd(1,sigma_x1,[Nindiv,1]);
x2 = mygamrnd(1,sigma_x2,[Nindiv,1]);
x3 = mygamrnd(1,sigma_x3,[Nindiv,1]);
e = normrnd(0,sigma_e,[Nindiv,1]);

beta_0 = 0.1;
beta_x1 = 0.8;
beta_x2 = 0.2;
beta_x3 = -0.3;

X_mult_beta = beta_0 + beta_x1*x1 + beta_x2*x2 + beta_x3*x3 + e; %#ok<*NASGU>
X_mult_beta = beta_0 + beta_x1*x1 + e;
P = 1./(1 + exp(-X_mult_beta));
NsrhLvls = 3;
Y = binornd(NsrhLvls,P);

simTable = table(Y,x1,x2,x3);
close;figure;
histogram(simTable.Y)
glm_bino = fitglm(simTable,'Y ~ x1','Distribution','binomial','BinomialSize',3)

mean(Y == round(3*glm_bino.predict))

%% How do mixed models deal with missing data?
% simulate T4-T7 data, but randomly  set some of the data as nan.
Nindiv = 10;
Nmeas  = 4;
% simulate exercise
x1 = normrnd(0, 1.2, [Nindiv,Nmeas]);x1(1,2:4) = nan;
% simluate sleep quality (will correlate with exercise):
x2 = normrnd(0, 0.9, [Nindiv,Nmeas]);
% simlulate level of social activity:
x3 = 0.3*x1 + 0.1*x2 + normrnd(0, 0.9, [Nindiv,Nmeas]);
% simulate noise:
e = normrnd(0,1.2,[Nindiv,Nmeas]);
% simulate individual SRH baseline levels:
betaIndiv0 = normrnd(0, 0.7, [Nindiv,1]);


% stretch out into long format
x1 = reshape(x1,[width(x1)*height(x1),1]);
x2 = reshape(x2,[width(x2)*height(x2),1]);
x3 = reshape(x3,[width(x3)*height(x3),1]);

% id numbers:
id = 1:Nindiv;
id = repmat(id',[Nmeas,1]);

e = reshape(e,[Nmeas*Nindiv,1]);

betaIndiv0 = repmat(betaIndiv0,[Nmeas,1]);

Y = betaIndiv0 + 2.8 + 0.6*x1 + 1.2*x2 + 0.75*x3 + e; 

simTable = table(Y,x1,x2,x3,id);

glm = fitlme(simTable,'Y ~ x1 + x2 + x3 + (1|id)');
glm.Coefficients
glm.NumObservations
% Missing data is dealt with nicely. However, when a data set lacks a
% variable that the other ones include, then we loose that entire dataset.



