function X = getCovariateVector(namesCovariates,indivTable)
% takes a cell array of covariate names (as they are ordered when using
% lm.CoefficientNames) and an individuals description table indivTable, and
% returns a numerical vector X which can then be used to make predictions
% using the command lm.Coefficinets.Estimate * X.

% format: expects all categorical variables to end with a _ followed by an
% integer, such as sex_1, liveWspouse_0 etc.

%% ex
% namesCovariates = {'(Intercept)','age','sex_1','liveWspouse_0','old_1:smokeNow_1'};
% indivTable = data(67000,:);
% indivTable = data(and(data.id==33062,data.t==6),:)

%% preliminary
if class(namesCovariates)=="GeneralizedLinearMixedModel"
    namesCovariates = namesCovariates.CoefficientNames;
end
%%
Nnames = numel(namesCovariates);
X = zeros(1,Nnames);
X(1) = 1;
for i=2:Nnames

    Jinteraction = strfind(namesCovariates{i},':');
    
    
    if isval(Jinteraction)
        % ¤¤¤ INTERACTION/COMPOSITE TERM ¤¤¤
        % separate the variables:
        InteractionVars = split(namesCovariates{i},':');
        
        iv = zeros(1,2);
        for j=1:2
            varName = InteractionVars{j};
            x1 = varName(end);
            x2 = varName(end-1);
                
            discreteVar = and(isval(str2double(x1)),x2=='_');
            
            if discreteVar==false
                % variable is continuous:
                iv(j) = indivTable.(varName);
            else
                % variable is categorical:
                lvl = categorical({x1});
                V = varName(1:end-2);
                iv(j) = util_compare(indivTable.(V),"==",lvl);
            end
        end
        X(i) = iv(1)*iv(2);

    else
        % ¤¤¤ SINGLE VARIABLE TERM ¤¤¤
        varName = namesCovariates{i};
        
        x1 = varName(end);
        x2 = varName(end-1);
        discreteVar = and(isval(str2double(x1)),x2=='_');
       
        if discreteVar==false
            % variable is continuous:
            X(i) = indivTable.(varName);
        else
            % variable is categorical:
            lvl = categorical({x1});
            V = varName(1:end-2);
            X(i) = util_compare(indivTable.(V),"==",lvl);
        end
        
    end
        
end


end