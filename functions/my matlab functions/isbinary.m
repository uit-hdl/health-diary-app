function y = isbinary(x)
x_unique = myunique(x,true);

if numel(x_unique)==2
    y = true;
else
    y = false;
end

end