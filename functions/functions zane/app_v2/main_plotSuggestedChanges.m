function main_plotSuggestedChanges(T_user, lme)
% Takes a table T_user with user data and a linear mixed effects model lme
% and returns a plot showing the effect of chaning various health-related
% habits in order of impact.

%%
% Add derived variables for model Input:
T_user = map_userdata_to_model_input(T_user);

% Get suggested lifestyle changes for User:
S = suggestFutureChange(T_user);
S.hscl
T_user.hscl
% Calculate theoretical mean SRH given current status:
current_srh = lme.predict(T_user);
sprintf("Current srh: %g", current_srh)

names_lifestyle_factors = fieldnames(S);
n_decision_vars = numel(names_lifestyle_factors);
potSRHarray = current_srh;
textArray = {'Predicted health for people matching your current status'};
clusters = {'Current'};
set(groot, 'defaultAxesTickLabelInterpreter', 'latex')

for i = 1:n_decision_vars
    lifestyle_factor = names_lifestyle_factors{i};
    new_Lvls = S.(lifestyle_factor).newLvl;
    n_suggestions = numel(new_Lvls);
    for j = 1:n_suggestions
        potential_future = T_user;
        potential_future.(lifestyle_factor) = new_Lvls{j};
        potential_future = map_userdata_to_model_input(potential_future);

        potential_srh = lme.predict(potential_future);
        S.(lifestyle_factor).newSRH{j} = potential_srh;

        % Save for plotting
        potSRHarray(end+1) = potential_srh;
        clusters{end+1} = lifestyle_factor; %#ok<*AGROW>
        textArray{end+1} = S.(lifestyle_factor).changeText{j}; %#ok<*SAGROW>
    end

end

% *** Reorder suggested changes by SRH effect size. Sort first by group
% (using maximum SRH to represent each cluster) and secondly within each
% cluster.
NewOrder = rankOrderLifeStyleChanges(clusters, potSRHarray, textArray);
potSRHarray = NewOrder.SRHarray;
clusters = NewOrder.clusters;
textArray = NewOrder.textArray;


% ¤¤¤ Plot Suggested Changes ¤¤¤
barText = categorical(textArray);
barText = reordercats(barText, textArray);
barh(barText, potSRHarray, "BarWidth", 0.08, "FaceColor", ...
    color2triplet("grey"), "EdgeColor", "none")
ax = gca;
ax.FontSize = 12;

% Determine x-axis limits:
s = sort(potSRHarray);
xlim([floor(s(1)), ceil(s(end))])
xticks([1, 2, 3, 4])
xticklabels({'Very bad', 'Bad', 'Good', 'Very Good'})
title('Estimated effect of reaching various health goals', "Interpreter", "latex")

hold on
Nbars = numel(potSRHarray);
for i = 1:Nbars

    if clusters(i) == "Current"
        col = color2triplet("black");

    elseif clusters(i) == "PA"
        col = color2triplet("green");

    elseif clusters(i) == "hscl"
        col = color2triplet("purple");

    elseif clusters(i) == "hypert"
        col = color2triplet("red");

    elseif clusters(i) == "diabHba1c"
        col = color2triplet("pink");

    elseif clusters(i) == "smokeNow"
        col = color2triplet("grey");

    elseif clusters(i) == "insomnia"
        col = color2triplet("blue");

    elseif clusters(i) == "friendsSupp"
        col = color2triplet("teal");

    elseif clusters(i) == "bmi"
        col = color2triplet("orange");
    end

    plot(potSRHarray(i), i, 'o', 'MarkerFaceColor', col, ...
        'MarkerEdgeColor', 'k', 'MarkerSize', 7);
    scatter(potSRHarray(i), i, 'MarkerEdgeColor', 'k', ...
        'MarkerFaceColor', col)

end

line([potSRHarray(1), potSRHarray(1)], [-1, Nbars + 1], ...
    'LineStyle', '--', 'LineWidth', 1, 'Color', 'k');
end