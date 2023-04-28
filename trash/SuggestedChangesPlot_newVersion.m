
%% Train Model
T67_mainModel
%% Run the Variable Forge
theGreatVariableForge
%% Produce User Table
clear bobba
bobba.id = 0;
bobba.srh = 2;
bobba.age = 6.7;
bobba.friendsSupp = categorical(0);
bobba.liveWspouse = categorical(0);
bobba.strokeOrHrtAtk = categorical(0);
bobba.sex = categorical(1);
bobba.smokeNow = categorical(1);
bobba.bmi = categorical(4);
bobba.hypert = categorical(1);
bobba.PAfrq = categorical(1);
bobba.PAint = categorical(1);
bobba.diabHba1c = categorical(1);

bobba.insomnia = categorical(4);
bobba.tense = categorical(3);
bobba.futureWiev = categorical(3);
bobba.fear = categorical(2);
bobba.worried = categorical(3);
bobba.dizzy = categorical(2);
bobba.depr = categorical(4);
bobba.struggle = categorical(4);
bobba.useless = categorical(4);
bobba.blameSelf = categorical(4);
% bobba.hscl = 3;
bobba = struct2table(bobba);
% plotSuggestedChanges(bobba,lme)

% Add derived variables for model Input:
bobba = rawUserData2ModelInput(bobba);
% Get suggested lifestyle changes for Bobba:
S = suggestFutureChange(bobba);
% Calculate average theoretical SRH given current status:
currentSRH  = lme.predict(bobba);


fieldNames = fieldnames(S);
N_decisionVar = numel(fieldNames);
potSRHarray = currentSRH;
textArray = {'Average SRH for people in your current category'};
clusters  = {'Current'};

for i=1:N_decisionVar
    Name = fieldNames{i};
    newLvls = S.(Name).newLvl;
    Nsuggestions = numel(newLvls);
    
    for j=1:Nsuggestions
        potBobba = bobba;
        potBobba.(Name) = newLvls{j};
        potBobba = rawUserData2ModelInput(potBobba);
        
        potSRH = lme.predict(potBobba);
        S.(Name).newSRH{j} = potSRH;
        
        % Save for plotting
        potSRHarray(end+1) = potSRH;
        clusters{end+1}    = Name;
        textArray{end+1}   = S.(Name).changeText{j}; %#ok<*SAGROW>
    end
    
end

% *** Reorder suggested changes by SRH effect size. Sort first by group
% (using maximum SRH to represent each cluster) and secondly within each
% cluster.
NewOrder = rankOrderLifeStyleChanges(clusters,potSRHarray,textArray)
potSRHarray = NewOrder.SRHarray;
clusters = NewOrder.clusters;
textArray = NewOrder.textArray;

% ¤¤¤ Plot Suggested Changes ¤¤¤

close all
figure
barText = categorical(textArray);
barText = reordercats(barText,textArray);
barh(barText,potSRHarray)

% Determine x-axis limits:
s = sort(potSRHarray);
xlim([floor(s(1)),ceil(s(end))])
xticklabels({'Very bad','Bad','Good','Very Good'})
title 'Suggested health-variables to focus on'

hold on
Nbars = numel(potSRHarray);
for i=1:Nbars
    
    if clusters(i)=="Current"
       col = color2triplet("black")
       
    elseif clusters(i)=="PA"
        col = color2triplet("green")
        
     elseif clusters(i)=="hscl"
        col = color2triplet("purple")
        
    elseif clusters(i)=="hypert"
        col = color2triplet("red")
        
    elseif clusters(i)=="diabHba1c"
        col = color2triplet("pink")
        
    elseif clusters(i)=="smokeNow"
        col = color2triplet("grey")
        
    elseif clusters(i)=="insomnia"
        col = color2triplet("blue")
        
    elseif clusters(i)=="bmi"
        col = color2triplet("orange");
    end
    
    plot(potSRHarray(i), i,'o','MarkerFaceColor',col,...
                               'MarkerEdgeColor','k','MarkerSize',7);
    scatter(potSRHarray(i), i, 'MarkerEdgeColor','k',...
                               'MarkerFaceColor',col)

end

line([potSRHarray(1),potSRHarray(1)], [-1,Nbars+1],...
               'LineStyle','--','LineWidth',1,'Color','k');



