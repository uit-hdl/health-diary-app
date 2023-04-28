%% initiate chain
clear S
P = [[.7,.3];[.2,.8]];
mc = dtmc(P);
numSteps = 20;
S.exercise = simulate(mc,numSteps)-1;
S.mentIll = simulate(mc,numSteps)-1;
S.insomnia = simulate(mc,numSteps)-1;
S.srh = simulate(mc,numSteps)-1;
S.junkFood = simulate(mc,numSteps)-1;

%% simulate next step

% mental health
mu_mentIll = probMentIll(S)
p_mentIll = 1/(1 + exp(-(mu_mentIll + 3*randn)))
S.mentIll(end+1) = binornd(1,p_mentIll);

% Exercise
mu_exercise = probExercise(S)
p_exercise = 1/(1 + exp(-(mu_exercise + 3.0*randn)))
S.exercise(end+1) = binornd(1,p_exercise)

% Junk Food
mu_junkFood = probJunkFood(S)
p_junkFood = 1/(1 + exp(-(mu_junkFood + 0.8*randn)))
S.junkFood(end+1) = binornd(1,p_junkFood)

% Insomnia
mu_insomnia = probInsomnia(S)
p_insomnia = 1/(1 + exp(-(mu_insomnia + 3*randn)))
S.insomnia(end+1) = binornd(1,p_insomnia)

% SRH
mu_SRH = probSRH(S)
p_SRH = 1/(1 + exp(-(mu_SRH + 2.5*randn)))
S.srh(end+1) = binornd(1,p_SRH)

tau = 10;
T = array2table([S.junkFood(end-tau:end),S.exercise(end-tau:end),...
            S.mentIll(end-tau:end),S.insomnia(end-tau:end),S.srh(end-tau:end)],...
            'v',{'junkFood','exercise','mentIll','insomnia','SRH'})
 
%% investigate data:
fitglm(T,'SRH ~ junkFood','distribution','binomial')
