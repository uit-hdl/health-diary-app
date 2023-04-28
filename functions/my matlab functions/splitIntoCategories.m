function x_categorical = splitIntoCategories(x,cuts,relation,newNames,conv2categ)
% takes a vector of numerical inputs x, and divides it into an ordinal
% categorical variable as indicated by the values in the vector cuts, so
% that categories are formed according to  cuts(i) <= x < cuts(i+1). iIf
% relation is set to "eq", then all elements of cuts are used to identify
% a subset of x. Returns an integer vector or logical vector depending on
% which relation is used.

%% example input
% x = [1,2,5,1,1,10,7,3,6,5,nan,nan,11,2,6]
% cuts = [5,6];
% returns:  x_categorical = [1,1,2,1,1,3,3,1,3,2,NaN,NaN,3,1,3]
%%
if nargin==2
    relation = "geq";
    newNames = [];
    conv2categ = true;
elseif nargin==3
    newNames = [];
    conv2categ = true;
elseif nargin==4
    conv2categ = true;
end

if isempty(conv2categ)
    conv2categ = false;
end

if iscategorical(x)
    x = cat2num(x);
end

sz = size(x);
Inan = isnan(x);

if relation=="geq"
    
    if nargin==1
        cuts = (max(x)+min(x))/2;
    end
    cuts = [-inf,cuts,+inf];
    x_categorical = zeros(sz);
    for i=1:numel(cuts)-1
        I = and(cuts(i)<=x, x<cuts(i+1));
        x_categorical(I) = i;
    end
    
elseif relation=="eq"
    if iscolumn(cuts)
        cuts = cuts';
    end
    if iscolumn(x)
        x = x';
    end
    
    x_categorical = sum(double(x==cuts'),1);
end

x_categorical(Inan) = nan;

x_categorical = reshape(x_categorical,sz);

if conv2categ
    x_categorical = mycategorical(x_categorical,'newNames',newNames);
end

% if ~isempty(newNames)
%     x_categorical = renamecats(x_categorical, newNames);
% end
end