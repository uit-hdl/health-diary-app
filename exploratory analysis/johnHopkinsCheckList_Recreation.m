importLongData
theGreatVariableForge
%%
HCLvars = {'FUTURE_T','BLAME_YOURSELF_T','WORRIED_T','DEPRESSED_T','FEAR_T',...
            'DIZZY_T','TENSE_T','USELESS_T','STRUGGLE_T','INSOMNIA_T'};
        
T = table2array(subtable(TUdata0,HCLvars));

% Defined as missing if more than 3 questions are not answered
Imissing = sum(ismissing(T),2)>3;

HCL = mean(T,2,'omitnan');
HCL(Imissing) = nan;

close all
figure
subplot(151)
    histogram(HCL(TUdata0.time==6))
    title 'calculated (Geirs Procedure)'
subplot(152)
    histogram(TUdata0.HSCLT(TUdata.t==6))
    title 'HSCLT'
subplot(153)
    histogram(TUdata0.hscl(TUdata.t==6)) 
    title 'hscl'
subplot(154)
    histogram(TUdata0.HSCL_GROUP_T(TUdata.t==6)) 
    title 'HSCL_GROUP_T'
subplot(155)
    histogram(discretize(HCL(TUdata0.time==6),[0,0.5,1,1.5,2,2.5,3,3.5,4,4.5])) 
    title 'HSCL_GROUP_T'

 

