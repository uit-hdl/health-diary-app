function data = create_tailorMade_PAcategories(X, data, frq_levels, int_levels)
% convenience function used to create new categories based on specified
% combinations of level pf PA frequency and intensity. For instance, to get
% the group with moderate or high PA-level and PA-frequency between 2 and
% 5, enter frq_levels = [2,3,4,5] and int_levels = [2,3]
%%
n_frq = numel(frq_levels);
n_int = numel(int_levels);

s = zeros(height(X), 1);
for i = 1:n_frq
    frq = frq_levels(i);
    for j = 1:n_int
        int = int_levels(j);
        name = sprintf('f%gi%g', frq, int);
        s = s + (X == name);
    end
end
s = s + nanVec(s, X, "or");

merge_PA_output = mycategorical(s);


str_frq = erase(strjoin(string(frq_levels))," ");
str_int = erase(strjoin(string(int_levels))," ");

merge_var_name = sprintf('PAf%si%s', str_frq, str_int);

data.(merge_var_name) = merge_PA_output;
end