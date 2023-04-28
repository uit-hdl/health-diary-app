function [new_names, old_names] = util_rename_with_yaml(old_table, new_names_yaml_file)
% takes a categorical or string array and renames the elements according to
% the directions given by the yaml file.
names_map = yaml.loadFile(new_names_yaml_file);
old_names = string(fieldnames(names_map));
N = numel(old_names);
new_names = strings([N, 1]);

for i=1:N
    new_names(i) = names_map.(old_names(i));
end

end