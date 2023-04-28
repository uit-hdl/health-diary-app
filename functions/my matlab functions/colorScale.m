function C = colorScale(theme,n)

if nargin==0
    strcat(sprintf(' blue2pink\n teal\n purple\n darkpurple\n pink'),...
        sprintf(' pink\n darkgreen\n lightgreen\n lightblue\n'),...
        sprintf(' darkblue\n darkred\n grey\n darkgrey\n lightgrey'))
else
    
    if isstring(theme)
        if theme=="blue2pink"
            color0 = [0 0 1];
            color1 = [1 0 0];
        elseif theme=="green2yellow"
            color0 = [0 0 1];
            color1 = [1 0 0];
        end

    else
        color0 = color2triplet(theme{1});
        color1 = color2triplet(theme{2})-color2triplet(theme{1});
    end
    
    C = cell(1,n);
    for i=1:n
        C{i} = color0 + (i-1)/(n-1)*color1;
    end
        
end
end