function mu_mentIll = probMentIll(S)
PA  = S.exercise;
junkFood = S.junkFood; 
mentIll = S.mentIll;
insomnia = S.insomnia;
srh = S.srh;

mu_mentIll = .6 ...
    - PA(end)*1.1 - PA(end-1)*.3 - PA(end-2)*.3 - mean(PA(end-14:end-7))*.7...
    + mentIll(end-1)*.9 + mentIll(end-2)*.4 + mean(mentIll(end-14:end-7))*.3...
    + junkFood(end)*.2 + junkFood(end-1)*.1 ...
    + insomnia(end)*1.4 + insomnia(end-1)*.5 + insomnia(end-2)*.2...
    - srh(end)*.4;
end