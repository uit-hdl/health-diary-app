function mu_insomnia = probInsomnia(S)
PA  = S.exercise;
junkFood = S.junkFood; 
mentIll = S.mentIll;
insomnia = S.insomnia;
srh = S.srh;

mu_insomnia = .8 ...
    - PA(end)*.2 - PA(end-1)*.2 - PA(end-3)*.3 - mean(PA(end-14:end-7))*1.2...
    + mentIll(end)*1.3 + mentIll(end-1)*.2 + mean(mentIll(end-14:end-7))*.1...
    + junkFood(end)*.1 ...
    + insomnia(end)*0.2 + insomnia(end-1)*.1 + insomnia(end-2)*.1...
    - srh(end)*.3;
end