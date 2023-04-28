function out = log2cat(I,str1,str2)
% converts binary vector from categorical to logical.
out = strings(numel(I),1);
out(I)  = str1;
out(~I) = str2;
end