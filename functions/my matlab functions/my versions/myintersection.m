function Jintersection = myintersection(Jcell,J2)
% costume version of intersect that allows a cell-array as argument, in
% which case it takes the intersection of all the index-vectors in that
% array.

if nargin==1
    n = max(size(Jcell));

    if isnumeric(Jcell{1})
        Jintersection = Jcell{1};
        for i=2:n
            Jintersection = intersect(Jintersection,Jcell{i});
        end
    else
        Jintersection = find(Jcell{1});
        for i=2:n
            Jintersection = intersect(Jintersection,find(Jcell{i}));
        end
    end
else
    Jintersection = intersect(Jcell,J2);
end

end