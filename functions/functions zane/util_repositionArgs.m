function [i_permutation, x_permuted] = util_repositionArgs(x, x_repos, i_newpos)
% rearranges the elements of x so that the elements in x_repos are
% put in positions I_newpos. The remaining elements fill in the remaining
% gaps, and retain their position relative to one another.

%% example input
% x = ["a", "b", "c", "d", "e", "f", "g", "h"];
% x_repos = ["h", "e"];
% i_newpos = [1, 3];

%% body
if iscell(x)
    x = string(x);
end

N_x = numel(x);

if isempty(x_repos)
    i_permutation = 1:N_x;
    x_permuted = x;
else
    
    [i_who_repos, ~] = find(util_makeCol(x) == util_makeRow(x_repos));
    i_who_not_repos = setdiff(1:N_x, i_who_repos);
    
    
    i_permutation = 1:N_x;
    i_permutation(i_newpos) = i_who_repos;
    i_permutation(setdiff(1:N_x, i_newpos)) = i_who_not_repos;
    
    x_permuted = x(i_permutation);
end

end