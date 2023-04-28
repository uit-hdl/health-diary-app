function plotSuggestedChanges(T_user, lme)
% Takes a table T_user with user data and a linear mixed effects model lme
% and returns a plot showing the effect of chaning various health-related
% habits in order of impact.

%%
% Add derived variables for model Input:
T_user = rawUserData2ModelInput(T_user);
% Get suggested lifestyle changes for User:
S = suggestFutureChange(T_user);

% Calculate average theoretical SRH given current status:
current_SRH = lme.predict(T_user);

fieldNames = fieldnames(S);
N_decisionVar = numel(fieldNames);
potSRHarray = current_SRH;
textArray = {'Average SRH for people in your current category'};
clusters = {'Current'};

for i = 1:N_decisionVar
    Name = fieldNames{i};
    newLvls = S.(Name).newLvl;
    Nsuggestions = numel(newLvls);

    for j = 1:Nsuggestions
        potFuture = T_user;
        potFuture.(Name) = newLvls{j};
        potFuture = rawUserData2ModelInput(potFuture);

        potSRH = lme.predict(potFuture);
        S.(Name).newSRH{j} = potSRH;

        % Save for plotting
        potSRHarray(end+1) = potSRH;
        clusters{end+1} = Name; %#ok<*AGROW>
        textArray{end+1} = S.(Name).changeText{j}; %#ok<*SAGROW>
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
close all
figure
barText = categorical(textArray);
barText = reordercats(barText, textArray);
barh(barText, potSRHarray)

% Determine x-axis limits:
s = sort(potSRHarray);
xlim([floor(s(1)), ceil(s(end))])
xticklabels({'Very bad', 'Bad', 'Good', 'Very Good'})
title 'Estimated effect of reaching health goal'

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