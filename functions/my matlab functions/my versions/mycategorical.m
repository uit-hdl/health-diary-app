function x = mycategorical(x,varargin)
% This is my one-stop function for converting to type categorical. It
% allows user to reorder and rename categories. By default, reorders
% categories so that the most numerous cateogry becomes the first category
% after sorting the variables (makes it more useful for fitting liear
% functions). The remaining variables keep their order relative to one
% another.

% *** ¤¤¤ Managing arguments ¤¤¤ ***
p = inputParser;
% *** required parameters ***
addRequired(p,'x');
% *** optional parameters ***
newOrder = 'newOrder';
newNames = 'newNames';
mergeVar = 'mergeVar';
defaultOrder = [];
defaultNames = [];
defaultMerge = [];
addParameter(p, newOrder, defaultOrder);
addParameter(p, newNames, defaultNames);
addParameter(p, mergeVar, defaultMerge);
parse(p,x,varargin{:});

if iscell(x)
    x = str2double(x);
end
x = categorical(x);
x(x=="NA") = missing;

% ** rename variables **
if ~isempty(p.Results.newNames)
    x = renamecats(x,p.Results.newNames);
end

% ** reorder variables **
if isempty(p.Results.newOrder)
    % by default: relevel so that most numerous category becomes default
    % level:
    n = countcats(x);
    ord = categories(x);
    [~,defaultLvl] = max(n);
    ord = [ord(defaultLvl);ord(:)];
    ord(defaultLvl+1) = [];
    x = reordercats(x,ord);
else

    x = reordercats(x,p.Results.newOrder);
end

if ~isempty(p.Results.mergeVar)
    x = mergecats(x,p.Results.mergeVar);
end

end

