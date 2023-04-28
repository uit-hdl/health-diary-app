function show_TUvar_def(varName)
% allows quickly looking up the definition of a TU variable.
if isstring(varName)
    varName = char(varName);
end

if varName(end-2:end-1)=="_T"
    varName = varName(1:end-3);
end
path = 'C:\Users\perwa\OneDrive - UiT Office 365\Health companion app\nesstar screenshots';
img = imread(strcat(path,'\',varName),'png');
clf
image(img);

% ¤¤¤ Exercise ¤¤¤
if varName=="EXERCISE"
    disp('Variable appears in T6 and T7')
elseif varName=="EXERCISE_LEVEL"
    disp('Variable appears in T6 and T7')
elseif varName=="PHYS_ACTIVITY_LEISURE"
    disp('Variable appears in T6 and T7')
elseif varName=="PHYS_ACTIVITY_LEISURE_LIGHT"
    disp('Variable appears in T4 and T5') 
elseif varName=="PHYS_ACTIVITY_LEISURE_HARD"
    disp('Variable appears in T4 and T5') 
    
elseif varName=="ALCOHOL_FREQUENCY"
    disp('Variable appears in T6 and T7')
elseif varName=="ALCOHOL_TIMES"
    disp('Variable appears in T4 and T5')
elseif varName=="ANGINA"
    disp('Variable appears in all sets')
elseif varName=="ASTHMA"
    disp('Variable appears in all sets')
elseif varName=="CHOLESTEROL"
    disp('Variable appears in all sets')
elseif varName=="SMOKE_DAILY"
    disp('Variable appears in all sets')
    
% ¤¤¤ Hopkins Checklist Variables (for mental health evaluation) ¤¤¤
elseif varName=="INSMONIA"
    disp('Variable appears in all sets')
elseif varName=="DEPRESSED"
    disp('Variable appears in T4,T6 and T7')
elseif varName=="WORRIED"
    disp('Variable appears in T4,T6 and T7')
elseif varName=="FEAR"
    disp('Variable appears in T4,T6 and T7')
elseif varName=="DIZZY"
    disp('Variable appears in T4,T6 and T7')
elseif varName=="TENSE"
    disp('Variable appears in T4,T6 and T7')
elseif varName=="BLAME_YOURSELF"
    disp('Variable appears in T4,T6 and T7')
elseif varName=="USELESS"
    disp('Variable appears in T4,T6 and T7')
elseif varName=="STRUGGLE"
    disp('Variable appears in T4,T6 and T7')
elseif varName=="FUTURE"
    disp('Variable appears in T4,T6 and T7')
end
    
    

end