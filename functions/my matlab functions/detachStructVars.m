function detachStructVars(S)
% takes a structure S and detaches the field variables so that they become
% free workspace variables.

% NOTE: THIS DOES NOT WORK!
names = fieldnames(S);
for i=1:length(names)
    eval([names{i} '=S.' names{i} ]);
end

end