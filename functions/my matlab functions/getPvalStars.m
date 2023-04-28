function sigSymbols = getPvalStars(p)
% takes a vector of pvalues and returns a character array with symbols
% indicating levels of significance.
% p = lme.Coefficients.pValue;
%%
s1 = (p<0.1).*(0.05<=p);
s2 = (p<0.05).*(0.01<=p)*2;
s3 = (p<0.01).*(0.001<=p)*3;
s4 = (p<0.001)*4;
S = s1 + s2 + s3 + s4 + 1;

sigSymbolBank = {' ','.','*','**','***'};

Npval = numel(p);
sigSymbols = cell(Npval,1);
for i=1:Npval
    sigSymbols{i} = sigSymbolBank{S(i)};
end

end