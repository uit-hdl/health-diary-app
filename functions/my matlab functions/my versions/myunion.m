function Junion = myunion(Jcell,J2)
% Costum function that allows cell array of index-arrays as argument, in
% which case it will take the union across all those index-arrays.

if nargin==1
    n = max(size(Jcell));

    if isnumeric(Jcell{1})
        Junion = Jcell{1};
        for i=2:n
            Junion = union(Junion,Jcell{i});
        end
    elseif islogical(Jcell{1})
        Junion = Jcell{1};
        for i=2:n
            Junion = Junion + Jcell{i};
        end
        Junion = Junion>0;
    end
elseif nargin==2
    if islogical(J2)
        J2 = find(J2);
    end
    if islogical(Jcell)
        Jcell = find(Jcell);
    end
    Junion = union(Jcell,J2);
end

end