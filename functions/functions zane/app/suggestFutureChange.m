function suggested_changes = suggestFutureChange(T_user)
% Takes a table T that must include a persons
% 1: Physical activity level (frequency and intensity 'f{_}i{_}') (12 levels)
% 2: BMI (categorical 1-4)
% 3: HypterTension (binary)
% 4: Diabetes (binary)
% 5: Smoking (binary)
% 6: Answers to questions used to calculate HSC

% Returns a structure "suggest" which contains, for each variable, cell
% arrays "newLvl" and "changeText" which together describe suggested change
% for to the variable. "newLvl" are the suggested new levels (categorical
% or numerical depending on the variable) to the variable, and "changeText"
% contains the corresponding text outputs which describes the change.

%% Code
is_old = T_user.age >= 6.5;
% ¤¤¤ Physical Activity ¤¤¤
if T_user.PA == "f1i1"
    % code: f--> frequency (lvl 1,2, 3 or 4); i--> intensity (lvl 1, 2 or 3)
    suggested_changes.PA.newLvl{1} = "f2i2";
    if is_old
        suggested_changes.PA.newLvl{2} = "f3i3";
    else
        suggested_changes.PA.newLvl{2} = "f4i3";
    end
elseif T_user.PA == "f1i2"
    suggested_changes.PA.newLvl{1} = "f3i2";
    if is_old
        suggested_changes.PA.newLvl{2} = "f3i3";
    else
        suggested_changes.PA.newLvl{2} = "f4i3";
    end
elseif T_user.PA == "f1i3"
    suggested_changes.PA.newLvl{1} = "f2i3";
    if is_old
        suggested_changes.PA.newLvl{2} = "f3i3";
    else
        suggested_changes.PA.newLvl{2} = "f4i3";
    end
elseif T_user.PA == "f2i1"
    suggested_changes.PA.newLvl{1} = "f2i2";
    suggested_changes.PA.newLvl{2} = "f3i2";
    suggested_changes.PA.newLvl{3} = "f3i3";
    if ~is_old
        suggested_changes.PA.newLvl{4} = "f4i3";
    end

elseif T_user.PA == "f2i2"
    suggested_changes.PA.newLvl{1} = "f3i2";
    if is_old
        suggested_changes.PA.newLvl{2} = "f3i3";
    else
        suggested_changes.PA.newLvl{2} = "f4i3";
    end

elseif T_user.PA == "f2i3"
    suggested_changes.PA.newLvl{1} = "f3i3";
    if ~is_old
        suggested_changes.PA.newLvl{2} = "f4i3";
    end

elseif T_user.PA == "f3i1"
    suggested_changes.PA.newLvl{1} = "f2i3";
    suggested_changes.PA.newLvl{2} = "f3i3";
    if ~is_old
        suggested_changes.PA.newLvl{3} = "f4i3";
    end

elseif T_user.PA == "f3i2"
    suggested_changes.PA.newLvl{1} = "f3i3";
    if ~is_old
        suggested_changes.PA.newLvl{2} = "f4i3";
    end
elseif T_user.PA == "f3i3"
    if ~is_old
        suggested_changes.PA.newLvl{1} = "f4i3";
    end
elseif T_user.PA == "f4i1"
    suggested_changes.PA.newLvl{1} = "f4i2";
    if ~is_old
        suggested_changes.PA.newLvl{2} = "f4i3";
    end
elseif T_user.PA == "f4i2"
    if ~is_old
        suggested_changes.PA.newLvl{1} = "f4i3";
    end
end


% add 
if exist('suggested_changes', 'var')
    for i = 1:numel(suggested_changes.PA.newLvl)
        suggested_changes.PA.changeText{i} = suggestedLvl2text(suggested_changes.PA.newLvl{i});
    end
end

% ¤¤¤ BMI ¤¤¤
% Healthy Range:    18.5-24.9 kg/m^2
% Overweight Range: 25.0-29.9 kg/m^2
Rnormal = round([18.5 * T_user.height^2, 24.9 * T_user.height^2], 1);
Rover = round([25.0 * T_user.height^2, 29.9 * T_user.height^2], 1);
if T_user.bmi == "3"
    suggested_changes.bmi.newLvl{1} = "2";
    suggested_changes.bmi.changeText{1} = sprintf('Lower weight to range %g-%g kg', ...
        Rnormal(1), Rnormal(2));
elseif T_user.bmi == "4"
    suggested_changes.bmi.newLvl{1} = "3";
    suggested_changes.bmi.newLvl{2} = "2";
    suggested_changes.bmi.changeText{1} = sprintf('Lower weight to range %g-%g kg', ...
        Rover(1), Rover(2));
    suggested_changes.bmi.changeText{2} = sprintf('Lower weight to range %g-%g kg', ...
        Rnormal(1), Rnormal(2));
end

% ¤¤¤ High Bloodpressure ¤¤¤
% if user.highBP == "1"
%     suggested_changes.highBP.newLvl{1} = "0";
%     suggested_changes.highBP.changeText{1} = sprintf('Lower bloodpressure to healthy range');
% end

% ¤¤¤ Diabetes ¤¤¤
if T_user.diabHba1c == "1"
    suggested_changes.diabHba1c.newLvl{1} = "0";
    suggested_changes.diabHba1c.changeText{1} = sprintf('Lower blood-sugar levels to healthy range');
end

% ¤¤¤ Smoking ¤¤¤
if T_user.smokeNow == "1"
    suggested_changes.smokeNow.newLvl{1} = "0";
    suggested_changes.smokeNow.changeText{1} = sprintf('Quit smoking');
end

% ¤¤¤ Mental Illness ¤¤¤
if T_user.hscl > 1
    suggested_changes.hscl.newLvl{1} = max(T_user.hscl-1, 1);
    suggested_changes.hscl.changeText{1} = sprintf('Improve mental health by one level on HSCL-scale');

    if suggested_changes.hscl.newLvl{1} > 1
        suggested_changes.hscl.newLvl{2} = 1;
        suggested_changes.hscl.changeText{2} = sprintf('Reach optimal mental health level on HSCL-scale');
    end
end

% ¤¤¤ Support Friends ¤¤¤
if T_user.friendsSupp == "0"
    suggested_changes.friendsSupp.newLvl{1} = "1";
    suggested_changes.friendsSupp.changeText{1} = sprintf('Having mutually supportive friendships');
end

% *** Convert strings to type categorical ***
FldNames = fieldnames(suggested_changes);
N = numel(FldNames);

for i = 1:N
    newLvls = suggested_changes.(FldNames{i}).newLvl;
    for j = 1:numel(newLvls)
        if isstring(newLvls{j})
            suggested_changes.(FldNames{i}).newLvl{j} = categorical(newLvls{j});
        end
    end
end

end


% ¤¤¤ Local Functions ¤¤¤
function Text = suggestedLvl2text(Lvl)
if Lvl == "f2i1"
    Text = sprintf('Mild intensity exercise (e.g. brisk walk)\n once per week');
elseif Lvl == "f2i2"
    Text = sprintf('Moderate intensity exercise (you become sweaty)\n nonce per week');
elseif Lvl == "f2i3"
    Text = sprintf('High intensity exercise (you become exhausted)\n once per week');
elseif Lvl == "f3i1"
    Text = sprintf('Mild intensity exercise (e.g. brisk walk)\n 1-3 times per week');
elseif Lvl == "f3i2"
    Text = sprintf('Moderate intensity exercise (you become sweaty)\n 1-3 times per week');
elseif Lvl == "f3i3"
    Text = sprintf('High intensity exercise (you become exhausted)\n 1-3 times per week');
elseif Lvl == "f4i2"
    Text = sprintf('Moderate intensity exercise (you become exhausted)\n at least 4 times per week');
elseif Lvl == "f4i3"
    Text = sprintf('High intensity exercise (you become exhausted)\n at least 4 times per week');
end

end