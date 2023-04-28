function mu_exercise = probExercise(S)
PA  = S.exercise;
junkFood = S.junkFood; 
mentIll = S.mentIll;
insomnia = S.insomnia;
srh = S.srh;
mu_exercise = .3...
    + PA(end)*.3 + PA(end-1)*.8 + PA(end-3)*1.3 + mean(PA(end-14:end-7))*1.5 ...
    - mentIll(end)*.4 - junkFood(end)*.03 + ...
    - insomnia(end)*1.1 - insomnia(end-1)*.4 - insomnia(end-2)*.2 ...
    + srh(end)*.2;
end