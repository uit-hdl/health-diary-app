
clear stats S
% S for stats:
S.id.t4 = TUdata.id(TUdata.t==4);
S.id.t5 = TUdata.id(TUdata.t==5);
S.id.t6 = TUdata.id(TUdata.t==6);
S.id.t7 = TUdata.id(TUdata.t==7);

S.id.t4andt5 = intersect(S.id.t4,S.id.t5);
S.id.t5andt6 = intersect(S.id.t5,S.id.t6);
S.id.t6andt7 = intersect(S.id.t6,S.id.t7);

S.id.t4andt5andt6 = myintersection({S.id.t4,S.id.t5,S.id.t6});
S.id.t5andt6andt7 = myintersection({S.id.t5,S.id.t6,S.id.t7});
S.id.t4andt5andt6andt7 = myintersection({S.id.t4,S.id.t5,S.id.t6,S.id.t7});

S.tables.surveyOverlapTable = array2table(...
    [numel(S.id.t4andt5),numel(S.id.t5andt6),numel(S.id.t6andt7),...
    numel(S.id.t4andt5andt6),numel(S.id.t5andt6andt7),numel(S.id.t4andt5andt6andt7)],...
    'v',{'t4andt5','t5andt6','t6andt7','t4andt5andt6','t5andt6andt7','t4andt5andt6andt7'});

S.I.t4 = TUdata.t==4;
S.I.t5 = TUdata.t==5;
S.I.t6 = TUdata.t==6;
S.I.t7 = TUdata.t==7;
S.J.t4andt5  = findInd(TUdata.id,S.id.t4andt5);
S.J.t5andt6  = findInd(TUdata.id,S.id.t5andt6);
S.J.t6andt7  = findInd(TUdata.id,S.id.t6andt7);

close
histogram(TUdata.depr(S.I.t4))








