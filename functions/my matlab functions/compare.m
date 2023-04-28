function a = compare(x, relation, y, nanTreatment)
% compares all the elements of x with y, via the relation "relation", which
% can be "==", "<", ">", "<=", ">=". Returns a vector of ones, zeros, and
% nan values (depending on value of nanTreatment). nanTreatment determines
% how nans are treated, the default is to retain nan as they appeared in x.
% I made this function since regular comparison sets nan to 0, and
% sometimes it is desirable to keep them as nan.

% find elements in x >= 1.5, and set nan for positions where x==nan.
% example: compare(x, "geq", 1.5,)
if nargin==3
    nanTreatment = "retainNan";
end
if relation=="==" || relation=="eq"
    relation = '==';
end
%% code
% find positions of nan.
nans = nanVec(x);

if iscategorical(x)
    lvls = myunique(x);
    x = double(string(x));
    
    y = double(string(y));
end

if relation=="=="
    a = x==y;
elseif relation==">=" || relation=="geq"
    a = x>=y;
elseif relation=="<=" || relation=="leq"
    a = x<=y;
elseif relation==">"
    a = x>y;
elseif relation=="<"
    a = x<y;
end

a = double(a);

if nanTreatment=="retainNan"
    a = a + nans;
else

end