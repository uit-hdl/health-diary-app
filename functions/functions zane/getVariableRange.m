function surveys = getVariableRange(varName,longData,timeName)
% takes the variable in varName, and checks which surveys the variable was
% recorded. longData is a table that contains the study variables in long
% format. TimeName is the name of the column that indicates the survey
% time.

%%
if nargin==2
    timeName = 'time';
end
%%
t = longData.(timeName);
X = longData.(varName);


Ival = isval(X);

IatleastOne = 1:4;
surveys = 4:7;
for i=surveys
    IatleastOne(i-3) = sum(Ival(t==i))>0;
end
IatleastOne = logical(IatleastOne);

surveys = surveys(IatleastOne);

end