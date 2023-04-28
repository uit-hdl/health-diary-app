function P = userBasedModelPresentation(TcurrState, Tmodel, model, varNames, combos)

%%
% NdecisVars = numel(var);
P = potentialFuture(TcurrState, Tmodel, model, varNames, combos);
allVars = fieldnames(P);
NvarTot = numel(allVars);
NvarSingle = numel(varNames);
Ncombos = height(combos);

% plotting settings:
Cmap = colormap('hsv');
lineWidth = 1.7;
markerSize = 8;

% count the number of changes for which the effect is presented:
NLevelChanges = 0;
for i = 1:NvarSingle
    for j = 1:numel(P.(varNames{i}).newX)
        NLevelChanges = NLevelChanges + 1;
    end
end
NLevelChanges = NLevelChanges + Ncombos;
% baseline SRH:
srh0 = model.predict(TcurrState);

scatter(1, srh0, 'k', 'filled');
line([1, 1], [0, srh0], 'color', 'k', 'lineW', lineWidth)
hold on
plot(1, srh0, 'ko', 'MarkerFaceColor', color2triplet('grey'), 'MarkerSize', markerSize);
yline(srh0, '--')
xlabels = {'', 'current'};

% initialize loop variables:
x0 = 1;
n_ticks = 0;
ymin = srh0;
ymax = srh0;
for i = 1:NvarTot
    X = allVars{i};
    if i <= NvarSingle
        NpotChanges = numel(P.(X).newX);
    else
        NpotChanges = 1;
    end
    xx = x0 + (1:NpotChanges);
    yy = P.(X).potY;

    n_ticks = n_ticks + NpotChanges;

    for j = 1:NpotChanges
        line([x0 + j, x0 + j], [0, yy(j)], 'col', 'k', 'lineW', lineWidth)

        if i <= NvarSingle
            xlabels = [xlabels, getLevelLabel(X, P.(X).newX(j))]; %#ok<*AGROW>
        else
            % format string for nice presentation:
            xlab = replace(X, "and", " & ");
            xlabels = [xlabels, xlab];
        end
    end

    col = Cmap(ceil(i/NvarTot*height(Cmap)), :);
    plot(xx, yy, 'sk', 'MarkerFaceColor', col, 'MarkerSize', markerSize)

    x0 = x0 + NpotChanges;

    ymax = max(ymax, max(P.(X).potY));
    ymin = min(ymin, min(P.(X).potY));
end

xlim([0, n_ticks + 2])
ylim([ymin * 0.96, ymax * 1.04])
xticks(0:(NLevelChanges + 1))
xticklabels(xlabels)

end
