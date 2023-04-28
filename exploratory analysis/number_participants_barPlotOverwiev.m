% in this script I want to create a data overview. How many participants in
% each study? How many participated in T4 and T5, T4 and T5 and T6, etc...

% how many participants were there in each study?
clf
bar(sum([TUdata.time==4,TUdata.time==5,TUdata.time==6,TUdata.time==7]))

% how many participated in both T4 and T5?
idT4 = TUdata.id(TUdata.time==4);
idT5 = TUdata.id(TUdata.time==5);
idT6 = TUdata.id(TUdata.time==6);
idT7 = TUdata.id(TUdata.time==7);
id_t4t5 = myintersection(idT4,idT5);
id_t5t6 = myintersection(idT5,idT6);
id_t6t7 = myintersection(idT6,idT7);
id_t4t5t6 = myintersection({idT4,idT5,idT6});
id_t5t6t7 = myintersection({idT4,idT5,idT6});
id_t4t5t6t7 = myintersection({idT4,idT5,idT6,idT7});

Nsubj = [numel(idT4),numel(idT5),numel(idT6),numel(idT7),...
        numel(id_t4t5),numel(id_t5t6),numel(id_t6t7),...
        numel(id_t4t5t6),numel(id_t5t6t7),...
        numel(id_t4t5t6t7)];

mybar({'T4','T5','T6','T7','T4+T5','T5+T6','T6+T7',...
                        'T4+T5+T6','T5+T6+T7','T4+T5+T6+T7'},Nsubj)


