% model: Y = 2.5 + alfa_i + 3.1 * x + e
% where 
% alfa_i ~ norm(0,1.3)
% e ~ nomr(0, 1.5)

clear x e Y beta0
% first simulate random individual intercepts:
Nindiv = 1000;
Nmeas  = 2;

alfa_i = normrnd(zeros(Nindiv,1),10);
beta0 = 2;
beta_indiv = beta0 + alfa_i;
beta_indiv = repmat(beta_indiv,[1,Nmeas]);

% simulate x (which represents amount of exercise per week)
for i=1:Nmeas
    x(:,i) = 0.3*alfa_i + mygamrnd(2,3,[Nindiv,1]); %#ok<*SAGROW>
    e(:,i) = normrnd(0,1.5,[Nindiv,1]); 
end


% get id-numbers:
id = (1:Nindiv)';
id = repmat(id,[1,Nmeas]);

time = zeros([Nmeas*Nindiv,1]);

Y = beta_indiv + 1*x + e;

% reshape into long format
x = reshape(x,[Nmeas*Nindiv,1]);
id = reshape(id,[Nmeas*Nindiv,1]);
Y = reshape(Y,[Nmeas*Nindiv,1]);
simTable = table(Y,x,id);
close all
plot(x(id==1),Y(id==1),'o')
hold on
plot(x(id==2),Y(id==2),'.')
plot(x(id==3),Y(id==3),'*')
%
glm = fitlme(simTable,'Y ~ x  + (1|id)');
lm = fitlm(simTable,'Y ~ x ');
[glm.Coefficients.Estimate,lm.Coefficients.Estimate]




