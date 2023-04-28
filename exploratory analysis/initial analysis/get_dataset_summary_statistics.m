% how many exercise at 2-3 times per week or more with at least moderate
% intensity?
I_6 = TUdata.t==6;
I_7 = TUdata.t==7;
PA_group = and(TUdata.PAfrq_t6t7>=4, TUdata.PAint_t6t7>=2);
computeCImeanEst(PA_group(I_6), "2", "nsig", 3)*100
computeCImeanEst(PA_group(I_7), "2", "nsig", 3)*100

% what was the mean age in each study?
mean(TUdata.age(I_6))
mean(TUdata.age(I_7))

% what proportion were women?
computeCImeanEst(~TUdata.sex(I_6), "2", "nsig", 3)*100
computeCImeanEst(~TUdata.sex(I_7), "2", "nsig", 3)*100
