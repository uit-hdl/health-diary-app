function y = myunique(x, ignoreMissing)
% costume made version of "unique", which only returns one occurence of
% missing type values. By setting ignoreMissing to true, the returned
% object y does not contain a missing element.
%%
if nargin==1
    ignoreMissing = false;
end

stringOG = false;
if isstring(x)
    x = categorical(x);
    stringOG = true;
end

y = unique(x);

if iscategorical(y)
    if any(ismissing(y))
        y(ismissing(y)) = []; % remove all nans
        y(end+1) = missing; % add the unique one.
    end
else
    if any(isnan(y))
        y(isnan(y)) = []; % remove all nans
        y(end+1) = NaN; % add the unique one.
    end
end

if ignoreMissing && ismissing(y(end))
    y = y(1:end-1);
end 

if stringOG
    y = string(y);
end

end