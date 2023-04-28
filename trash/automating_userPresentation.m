%% get table that contains the prepared variables
%#ok<*AGROW>
theGreatVariableForge
%% fit model
version = "1";
if version=="1"
    % use physact23 to represent high lvl of PA.
    variables = {'age','sex','PA','physact34','bmi','diabHba1c','smokeNow',...
                 'mentIll','insomnia'};
    interactionTerms = {'PAfrq:physact34'};
    I_tu = (t>=6);
    
elseif version=="2"
    % use PAintHigh (based on EXERCICE_LEVEL) to represent high lvl of PA. 
    variables = {'age','sex','PAfrq','PAintHigh','bmi','diabHba1c'...
                  ,'mentIll','insomnia','smokeNow'};
    interactionTerms = {'PAfrq:PAintHigh'};
    I_tu = (t>=6);
    
elseif version=="3"
    % Uses PAhard and PAlight (T4+5 variables) to represent exercise.
    variables = {'age','sex','PAhard','PAlight','bmi','diabHba1c',...
                 'mentIll','insomnia','smokeNow'};
    interactionTerms = {'PAfrq:PAintHigh'};
    I_tu = (t<=5);
end
DiffArray = whichVarsInDataset(data,{variables,interactionTerms})

formula = getLinearModelFormula([variables,interactionTerms,{'(1|id)'}],'srh');
lme = fitglme(data(I_tu,:),formula);
% lme = fitglme(data(I_tu,:),'srh ~ age + sex');
lme.Coefficients
close all
figure
plotCoeffLinearModel(lme)

%% define individual
clear bobba
bobba.id = 0;
bobba.srh = 2;
bobba.age = 3.2;
bobba.old = categorical(double(bobba.age>=6.5));
bobba.strokeOrHrtAtk = categorical(0);
bobba.sex = categorical(1);
bobba.smokeNow = categorical(1);
bobba.bmi = categorical(3);
bobba.hypert = categorical(1);
bobba.PAfrq = categorical(1);
bobba.PAfrq3 = categorical(0);
bobba.PA = categorical("f1i1");
bobba.physact = 1;
bobba.physact34 = categorical(double(bobba.physact>=3));
bobba.PAhard = categorical(1);
bobba.PAlight = categorical(2);
bobba.PAintHigh = categorical(0);
bobba.glucoseHemog = categorical(3);
bobba.friendsSupp = categorical(0);
bobba.liveWspouse = categorical(0);
bobba.diabHba1c = categorical(1);
bobba.insomnia = categorical(3);
bobba.insomnia4 = categorical(double(bobba.insomnia=="4"));
bobba.mentIll = categorical(3);
bobba = struct2table(bobba);


combos = {};

close all
figure
subplot(121)
S = summary(data);
userBasedModelPresentation(bobba,S,lme,decisVars,combos)

subplot(122)
    V = bobba.Properties.VariableNames(5:end);
    barText = categorical(V);
    barText = reordercats(barText,V);
    T = subtable(bobba,V);
    T = convertvars(T, V, 'string');
    T = convertvars(T, V, 'double');
    y = table2array(T)
    bar(barText,y,'FaceColor',[0 .5 .5],'EdgeColor',[0 1 0])
    hold on
    plot(1:numel(y),y,'o','markerFaceColor','b')
    title 'your current status'
    ylim([-0.1,max(y)+1])
    yticks(0:10)
    
%%

P = potentialFuture(bobba, decisVars, data, lme, combos);
allVars = fieldnames(P);
NvarTot = numel(allVars);
NvarSingle = numel(decisVars);
Cmap = colormap('hsv');

close all
figure
xx = [];
x0 = 1;
n_ticks = 0;
lineWidth = 1.7;
markerSize = 8;

Ncombos = height(combos);
NLevelChanges = 0;
for i=1:NvarSingle
    for j=1:numel(P.(decisVars{i}).newX)
        NLevelChanges = NLevelChanges + 1;
    end
end
NLevelChanges = NLevelChanges + Ncombos;

srh0 = lme.predict(bobba);

% baseline:
scatter(1,srh0,'k','filled');
line([1,1],[0,srh0],'color','k','lineW',lineWidth)
hold on
s = plot(1,srh0,'ko','MarkerFaceColor',color2triplet('grey'),'MarkerSize',markerSize);
yline(srh0,'--')
xlabels = {'', 'current'};
ymin = srh0;
ymax = srh0;

for i=1:NvarTot

    X = allVars{i};
    
    if i<=NvarSingle
        NpotChanges = numel(P.(X).newX);
    else
        NpotChanges = 1;
    end
    
    xx = x0 + (1:NpotChanges);
    n_ticks = n_ticks + NpotChanges;
    yy = P.(X).potY;
    
    for j=1:NpotChanges
        line([x0+j,x0+j],[0,yy(j)],'col','k','lineW',lineWidth) 
        
        if i<=NvarSingle
            xlabels = [xlabels,getLevelLabel(X,P.(X).newX(j))];
        else
            J_and = strfind(X,'and');
            xlab = sprintf('%s & %s',X(1:J_and-1),X(J_and+3:end))
            xlabels = [xlabels,xlab];
        end
    end
    
    col = Cmap(ceil(i/NvarTot*height(Cmap)),:)
    s = plot(xx,yy,'ok','MarkerFaceColor',col,'MarkerSize',markerSize);
    
    x0 = x0 + NpotChanges;
    
    ymax = max(ymax,max(P.(X).potY));
    ymin = min(ymin,min(P.(X).potY));
end


xlim([0,n_ticks+2])
ylim([ymin*0.96, ymax*1.04])
xticks(0:(NLevelChanges+1))
xticklabels(xlabels)






%% playing around with colors
close all
n = 10;

for i=1:n
    C = [0 0 1] + i/n*[1 0 0];
    s = plot(i,i,'ok','MarkerFaceColor',C,'MarkerSize',7)
    hold on
end

for i=1:n
    C = [0 1 1] + i/n*[1 0 0];
    s = plot(i,i,'ok','MarkerFaceColor',C,'MarkerSize',7)
    hold on
end

for i=1:n
    C = [0 1 1] + i/n*[1 0 0];
    s = plot(i,i,'ok','MarkerFaceColor',C,'MarkerSize',7)
    hold on
end

C = colorScale({'red','lightgreen'},n)
for i=1:n
    s = plot(i,i,'ok','MarkerFaceColor',C{i},'MarkerSize',7)
    hold on
end

