N = 10000;
x1 = normrnd(0,1,N,1);
b = 0.2;
sigmax2 = sqrt(b^2+.3^2);
b = b*sigmax2
x2 = b*x1 + normrnd(0,.3,N,1)
% x2 = (x2-mean(x2))/std(x2);
clf
plot(x1,x2,'*')
mdl = fitlm(x1,x2)
%%
mdl = fitlm(x2,x1);


alfaVec = [1,2,5];
y = alfaVec(1) + alfaVec(2)*x1 + alfaVec(3)*x2 + normrnd(0,1,N,1);
mdl1 = fitlm(x1,y)
mdl2 = fitlm(x2,y)
mdl3 = fitlm([x1,x2],y)

b1 = mdl1.Coefficients.Estimate'
b2 = mdl2.Coefficients.Estimate'

b1Teo = [alfaVec(1), alfaVec(2)+b*alfaVec(2)]
b1Teo = [alfaVec(1), alfaVec(3)+b*alfaVec(2)]

%% example with three variables
 %#ok<*NOPTS>
% x1 = smoking
% x2 = sleep
% x3 = exercise
N = 1000;
clear x
Sigma = [[1  -.2  -.3];
         [-.2  2  .2];
         [-.3 .2   1]];
xx = mvnrnd([0,0,0],Sigma,N);
x1 = xx(:,1)/std(xx(:,1)); x.smoke = x1;
x2 = xx(:,2)/std(xx(:,2)); x.sleep = x2;
x3 = xx(:,3)/std(xx(:,3)); x.exerc = x3;

plot(x.smoke,x.exerc,'*')

covarM1 = fitlm([x2,x3],x1);
a1 = covarM1.Coefficients.Estimate(2);
b1 = covarM1.Coefficients.Estimate(3);
covarM3 = fitlm([x1,x2],x3)
a3 = covarM3.Coefficients.Estimate(2);
b3 = covarM3.Coefficients.Estimate(3);

% simulate the response variable y = health:
alfaVec = [1 -.4 .6 .7];
alfa0 = alfaVec(1);
alfa1 = alfaVec(2);
alfa2 = alfaVec(3);
alfa3 = alfaVec(4);
y = [ones(N,1) x1 x2 x3]*alfaVec' + normrnd(0,.1,N,1);

M1    = fitlm([x1,x2],y)
beta1 = M1.Coefficients.Estimate
M2    = fitlm([x2,x3],y)
beta2 = M2.Coefficients.Estimate

% confirm theoretical calculations:
[alfa0, alfa1 + alfa3*a3, alfa2+alfa3*b3]
beta1'
[alfa0, alfa2 + alfa1*a1, alfa3+alfa1*b1]
beta2'
% we see that the equations are confirmed by the simulated results.




















