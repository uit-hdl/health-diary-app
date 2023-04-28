function str = vec2string(x, shape)
% convert vector with numerical values (e.g. [1,2,0.5]) to a string of the
% form "1, 2, 0.5"
if nargin==1
    shape = "horizontal";
end

str = string(x(1));
for i=2:numel(x)
    if shape=="horizontal"
        str = sprintf('%s, %s',str,string(x(i)));
    else
        str = sprintf('%s\n%s',str,string(x(i)));
    end
end


end