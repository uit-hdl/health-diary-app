function suggest = suggestFutureChange(user)
% Takes a table T that must include a persons
% 1: Physical activity level (frequency and intensity 'f{_}i{_}')
% 2: BMI (categorical 1-4)
% 3: HypterTension (binary)
% 4: Diabetes (binary)
% 5: Smoking (binary)
% 6: Hopkins Symptoms Checklist (numerical in range [1,4])
% 7: Insomnia (categorical 1-4)

% Returns a structure "suggest" which contains, for each variable, cell
% arrays "newLvl" and "changeText" which together describe suggested change
% for to the variable. "newLvl" are the suggested new levels (categorical
% or numerical depending on the variable) to the variable, and "changeText"
% contains the corresponding text outputs which describes the change.

%% Code

% ¤¤¤ EXERCISE ¤¤¤
% ¤¤ PA frequency: less than once per week ¤¤
if user.PA == "f1i1" || user.PA == "f1i2" || user.PA == "f1i3"
    % code: f--> frequency (lvl 1,2 or 3); i--> intensity (lvl 1, 2 or 3)
    suggest.PA.newLvl{1} = "f2i2";
    suggest.PA.newLvl{2} = "f3i3";
    suggest.PA.newLvl{3} = "f4i3";
    if user.age >= 6.5
        suggest.PA.newLvl{3} = "f4i3";
    end

% ¤¤ PA frequency: 1 time per week ¤¤
elseif user.PA == "f2i1"
    suggest.PA.newLvl{1} = "f2i2";
    suggest.PA.newLvl{2} = "f3i3";
    suggest.PA.newLvl{3} = "f4i3";
    if user.age >= 6.5
        suggest.PA.newLvl{3} = "f3i3";
    end

elseif user.PA == "f2i2"
    suggest.PA.newLvl{1} = "f3i2";
    suggest.PA.newLvl{2} = "f3i3";
    suggest.PA.newLvl{3} = "f4i3";
    if user.age >= 6.5
        suggest.PA.newLvl{3} = "f3i3";
    end
elseif user.PA == "f2i3"
    suggest.PA.newLvl{1} = "f3i3";
    suggest.PA.newLvl{2} = "f4i3";
    if user.age >= 6.5
        suggest.PA.newLvl{2} = "f3i3";
    end

% ¤¤ PA frequency: 1-3 times per week ¤¤ 
elseif user.PA == "f3i1"
    suggest.PA.newLvl{1} = "f2i3";
    suggest.PA.newLvl{2} = "f3i2";
    if user.age < 6.5
        suggest.PA.newLvl{3} = "f3i3";
    end
elseif user.PA == "f3i2"
    suggest.PA.newLvl{1} = "f2i3";
    if user.age >= 6.5
        suggest.PA.newLvl{2} = "f3i3";
    end
elseif user.PA == "f3i3"
    suggest.PA.newLvl{1} = "f4i3";
    if user.age >= 6.5
        suggest.PA.newLvl{1} = "f3i3";
    end
end

% check if PA levels are maxed out exists before adding text:
PA_maxed_out = or(user.PA == "f4i2" && user.age >= 6.5, ...
                  user.PA == "f4i3" && user.age < 6.5);
if not(PA_maxed_out)
    for i = 1:numel(suggest.PA.newLvl)
        suggest.PA.changeText{i} = map_newLvl_to_string(suggest.PA.newLvl{i});
    end
end

% ¤¤¤ BMI ¤¤¤
% Healthy Range:    18.5-24.9 kg/m^2
% Overweight Range: 25.0-29.9 kg/m^2
range_normal = round([18.5 * user.height^2, 24.9 * user.height^2], 1);
range_over = round([25.0 * user.height^2, 29.9 * user.height^2], 1);
if user.bmi == "3"
    suggest.bmi.newLvl{1} = "2";
    suggest.bmi.changeText{1} = sprintf('Lower weight to range %g-%g kg', ...
        range_normal(1), range_normal(2));
elseif user.bmi == "4"
    suggest.bmi.newLvl{1} = "3";
    suggest.bmi.newLvl{2} = "2";
    suggest.bmi.changeText{1} = sprintf('Lower weight to range %g-%g kg', ...
        range_over(1), range_over(2));
    suggest.bmi.changeText{2} = sprintf('Lower weight to range %g-%g kg', ...
        range_normal(1), range_normal(2));
end

% ¤¤¤ HypterTension ¤¤¤
% if user.highBP == "1"
%     suggest.highBP.newLvl{1} = "0";
%     suggest.highBP.changeText{1} = sprintf('Lower bloodpressure to healthy range');
% end

% ¤¤¤ Diabetes ¤¤¤
if user.diabHba1c == "1"
    suggest.diabHba1c.newLvl{1} = "0";
    suggest.diabHba1c.changeText{1} = sprintf('Lower blood sugar levels to healthy range');
end

% ¤¤¤ Smoking ¤¤¤
if user.smokeNow == "1"
    suggest.smokeNow.newLvl{1} = "0";
    suggest.smokeNow.changeText{1} = sprintf('Quit smoking');
end

% ¤¤¤ Mental Illness ¤¤¤
if user.hscl > 1
    suggest.hscl.newLvl{1} = max(user.hscl-1, 1);
    suggest.hscl.changeText{1} = sprintf('Improve mental health by one unit on HSCL-scale');

    if suggest.hscl.newLvl{1} > 1
        suggest.hscl.newLvl{2} = 1;
        suggest.hscl.changeText{2} = sprintf('Reach optimal mental health level on HSCL-scale');
    end
end

% ¤¤¤ Support Friends ¤¤¤
if user.friendsSupp == "0"
    suggest.friendsSupp.newLvl{1} = "1";
    suggest.friendsSupp.changeText{1} = sprintf('Establish mutually supportive friendships');
end

% *** Convert strings to type categorical ***
FldNames = fieldnames(suggest);
N = numel(FldNames);

for i = 1:N
    newLvls = suggest.(FldNames{i}).newLvl;
    for j = 1:numel(newLvls)
        if isstring(newLvls{j})
            suggest.(FldNames{i}).newLvl{j} = categorical(newLvls{j});
        end
    end
end

end


% ¤¤¤ Local Functions ¤¤¤
function Text = map_newLvl_to_string(Lvl)
if Lvl == "f2i1"
    Text = sprintf('Mild exercise (e.g. brisk walk) once per week');
elseif Lvl == "f2i2"
    Text = sprintf('Moderate exercise (get sweaty) once per per week');
elseif Lvl == "f2i3"
    Text = sprintf('Intense exercise (get exhausted) once per week');

elseif Lvl == "f3i1"
    Text = sprintf('Mild exercise (like a brisk walk) 1-3 times per week');
elseif Lvl == "f3i2"
    Text = sprintf('Moderate exercise (get sweaty) 1-3 times per week');
elseif Lvl == "f3i3"
    Text = sprintf('Intense exercise (get exhausted) 1-3 times per week');

elseif Lvl == "f4i1"
    Text = sprintf('Mild exercise (like a brisk walk) 4+ times per week');
elseif Lvl == "f4i2"
    Text = sprintf('Moderate exercise (get sweaty) 4+ times per week');
elseif Lvl == "f4i3"
    Text = sprintf('Intense exercise (get exhausted) 4+ times per week');
end

end