function ix_shuffle  = reorder_according_to_list(x, x_order_list)
% Takes a list of objects x and an ordering list x_ordered which
% dictates the ordering of the elements. If an element of x is not in
% x_order_list, then the returned index list deletes these elements in
% addition to reordering existing elements.
%% example
% %     1    2    3    4    5    6    7    8
% x = ["f", "g", "a", "x", "d", "c", "e", "z"];
% %                1   2   3   4   5   6   7   8   9  10
% x_order_list = ["a" "b" "c" "d" "e" "f" "g" "h" "i" "j"];
%%

n = numel(x_order_list);
ix_shuffle = zeros(1, n);
ix_delete = zeros(1, n)==1;
for i=1:n
    ix_in_reordered_list = find(findInd(x, x_order_list(i)), 1);
    if isempty(ix_in_reordered_list)
        ix_delete(i) = 1;
        ix_shuffle(i) = 0;
    else
        ix_shuffle(i) = ix_in_reordered_list;
    end
end

ix_shuffle = ix_shuffle(ix_shuffle~=0);

end