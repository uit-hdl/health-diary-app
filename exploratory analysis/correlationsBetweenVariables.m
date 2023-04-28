if ~exist('TUdata','var')
    importLongData
end
%%

t = TUdata.t;

variables = {'hypertension','cholest','lipid','glucoseHemoglob','diab',...
             'triglyc_t4t5t6','bmi','heartAttack'};

% create cross correlation table:
Tcross = correlationTable(TUdata(t==6,:),variables,2)

X = abs(table2array(Tcross)*255);
% why does cholestorol levels correlate negatively with triglyceride levels
% and heart attack? should it not be the opposite?

% fitglm(TUdata(t==7,:),'heartAttack ~ cholest')
%% plot correlation matrix in color
close all

figure
image(X)
xticklabels(variables)
yticklabels(variables)
colormap gray
colorbar