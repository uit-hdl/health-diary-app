function T = giveTitle2table(T,myTitle)
if ischar(myTitle)
    myTitle = string(myTitle);
end
T = table(T,'VariableNames',myTitle);
end