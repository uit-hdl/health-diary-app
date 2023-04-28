function P = potentialFuture(TcurrState,dataSummary,model,var,combos)
% takes an individuals health status (table TcurrState, which contains
% numerical and categorical variables indicating physical activity level,
% BMI, etc...) and returns a structure with one field for each variable in
% the cell array 'var'. The field in P corresponding to variable X contains
% the potential levels (in increasing order, assuming X is ordinal) of X
% and the corresponding SRH that would result if X was changed to any of
% those levels. If X is continuous (numeric) then P instead contains
% information on estimated change if it is increased or lowered by one
% unit.

% For example of usage, see 
%% Preliminary
if nargin==4
    combos = [];
end
%% Code
% Predict the average SRH associated with the data given by user:
srh0 = model.predict(TcurrState);

for i=1:numel(var)
    X = var{i};
    X0   = TcurrState.(X);
    
% ¤¤¤ if X is categorical ¤¤¤
    if iscategorical(X0)
%         ¤¤¤¤
        % get the levels for categorical variable:
%         Xrange = myunique(Tmodel.(X));
        % remove the <missing> from Xrange:
%         Xrange = Xrange(isval(Xrange));
% ¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤¤
        Xrange = categorical(dataSummary.(X).Categories);
        % potential new levels for the habit X:
        I_potX = X0~=Xrange;
        potX = Xrange(I_potX);
        [~,Isort] = sort(cat2double(potX));
        potX = potX(Isort);

        n_potChanges = numel(potX);
        srhPot = zeros(1,n_potChanges);
        % create table describing status after each potential change:
        T_pot = TcurrState;
        for j=1:n_potChanges
            T_pot.(X) = potX(j);
            potX(j)
            srhPot(j) = model.predict(T_pot);
        end

        % save:
        P.(X).newX   = potX';
        P.(X).deltaY = srhPot - srh0;
        P.(X).potY   = srhPot;
        
% ¤¤¤ if X is continuous ¤¤¤
    elseif isnumeric(X0)
        T_pot1 = TcurrState;
        T_pot2 = TcurrState;
        T_pot1.(X) = X0 + 1;
        T_pot2.(X) = X0 - 1;
        srhPotential1 = model.predict(T_pot1);
        srhPotential2 = model.predict(T_pot2);
        
        % save:
        P.(X).newX   = X0 + [-1 1];
        P.(X).deltaY = [srhPotential1,srhPotential2] - srh0;
        P.(X).potY   = [srhPotential1,srhPotential2];
        
    end
end

% ¤¤¤ changing several variables at once ¤¤¤
clear X
for i=1:height(combos)
    
    for j=1:numel(combos{i,1})
        X{j}     = combos{i,1}{j};
        X_pot(j) = combos{i,2}(j); %#ok<*AGROW>
    end
    
    NvarsInCombo = numel(X);
    
    Xstr = sprintf('%s_%g',X{1},X_pot(1));
    for j=2:NvarsInCombo
         Xstr = strcat( Xstr,'and', sprintf('%s_%g',X{j},X_pot(j)) );
    end
%     Xstr = strcat(sprintf('%s_%g',X{1},X_pot{1}),'and',...
%                   sprintf('%s_%g',X{2},X_pot{2}));
    
    T_pot = TcurrState;
    
    for j=1:NvarsInCombo
        T_pot.(X{j}) = categorical(X_pot(j));
    end
%     
%     T_pot.(X{2}) = categorical(X_pot(2));
    srhPot = model.predict(T_pot);
    
    P.(Xstr).newX   = Xstr;
    P.(Xstr).deltaY = srhPot - srh0;
    P.(Xstr).potY   = srhPot;
end



%%
% T_potential.(varName) = categorical(3);
% model.predict(T_potential)
end