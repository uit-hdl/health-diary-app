function X = conv2cat(X,newNames,mergeCat)
% converts elements of column array to type categorical and renames
% and/or merges variables if desired.

if iscell(X)
    X = str2double(X);
end
        
X = categorical(X);
X(X=="NA") = missing;

if nargin>1
    X = renamecats(X, newNames);
end

if nargin==3
    X = mergecats(X, mergeCat);
end

end