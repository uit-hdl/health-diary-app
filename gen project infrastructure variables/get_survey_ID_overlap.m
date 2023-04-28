if ~exist("TUdata", "var")
    importLongData
    renameVariablesOfInterest
end
clear ID_overlap

for t1 = 4:7
    for t2 = 4:7
        ID_overlap.id{t1-3, t2-3} = intersect(TUdata.id(TUdata.t == t1), ...
            TUdata.id(TUdata.t == t2));
        ID_overlap.I{t1-3, t2-3} = findInd(TUdata.id, ...
            ID_overlap.id{t1-3, t2-3});
    end
end

description = ["structure that shows the ids that overlap between survey";...
    " i and j."];
save("survey_id_overlap.mat", "ID_overlap", "description")