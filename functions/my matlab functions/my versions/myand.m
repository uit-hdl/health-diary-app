function Iand = myand(indexArray,arg2,nanTreatment)

if nargin<3
    nanTreatment = "and";
end

if iscell(indexArray)
    Iand = indexArray{1};
    for i=2:length(indexArray)
        Iand = and(Iand,indexArray{i});
    end
else
    arg1 = indexArray;
    
    Inan = nanVec(arg1,arg2,nanTreatment);    
    Iand = and(arg1==1,arg2==1) + Inan;
end

end