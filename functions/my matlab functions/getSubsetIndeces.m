function J = getSubsetIndeces(x,xsub)
% Gets the positions of the values xsub in x.

% convert to string arrays if type is character array
if iscell(x)
    x = string(x);
end
if iscell(xsub)
    xsub = string(xsub);
end

% convert to correct shapes if needed
if size(x,2)==1
    x = x';
end
if size(xsub,2)==1
    xsub = xsub';
end

J = mod(find((x==xsub')'), numel(x)) + double(xsub==x(end))'*numel(x);
end