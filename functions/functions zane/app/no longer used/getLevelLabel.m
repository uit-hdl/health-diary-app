function s = getLevelLabel(varName,lvl)
% produces a cell array of strings s whith subindeces corresponding to
% their levels. This function is used in "userBasedModelPresentation"
%%
varName = string(varName);
lvl = string(lvl);
s = convert2LatexFormat(sprintf('%s_%s',varName,lvl) );
end