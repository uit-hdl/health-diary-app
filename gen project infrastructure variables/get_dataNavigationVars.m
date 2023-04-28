%% Create data orientation variabels

for t=4:7
    s = sprintf('T%g',t);
    info.(s).I = (TUdata.t==t);
    info.(s).J = info.(s).I;
end

save('info.mat',"info")