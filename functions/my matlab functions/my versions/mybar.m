function mybar(x,y)
% my alternative version of the bar function, which allows user to directly
% input a cell array of strings with the names of the categories.

if nargin==1
    bar(x);
elseif nargin==2
    barText = categorical(x);
    barText = reordercats(barText,x);
    bar(barText,y)
end

end