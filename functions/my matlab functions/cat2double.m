function x = cat2double(x)
% convert categorical to double. Ex: {'0', '3', '2'} --> [0, 3, 2]
x = str2double(cellstr(x));
end