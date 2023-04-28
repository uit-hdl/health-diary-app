function out = color2triplet(color)
% maps color string to RGB triplet.
if nargin==0
    strcat(sprintf(' orange\n teal\n purple\n darkpurple\n pink'),...
           sprintf(' pink\n darkgreen\n lightgreen\n lightblue\n'),...
           sprintf(' darkblue\n darkred\n grey\n darkgrey\n lightgrey'))
else
    if isnumeric(color)
        out = color;
    else
        if color=="blue" || color=="b"
            out = [0, 0.4470, 0.7410];
        elseif color=="red" || color=="r"
            out = [0.6350, 0.0780, 0.1840];
        elseif color=="green" || color=="g"
            out = [0.4660, 0.6740, 0.1880];
        elseif color=="yellow" || color=="y"
            out = [0.9290, 0.6940, 0.1250];
            
        elseif color == "orange"
            out = [255,106,0]/255;
        elseif color=="brown"
            out = [101 61 33]/255;
        elseif color == "teal"
            out = [0,255,255]/255;
        elseif color == "purple"
            out = [127,0,110]/255;
        elseif color == "darkpurple"
            out = [127,0,55]/255;
        elseif color == "pink"
            out = [255, 0, 220]/255;
        elseif color == "darkgreen"
            out = [38 127 0]/255;
        elseif color == "lightgreen"
            out = [0 255 72]/255;
        elseif color == "lime"
            out = [182 255 0]/255;
        elseif color == "lightblue"
            out = [155 127 255]/255;
        elseif color == "darkblue"
            out = [33 0 107]/255;
        elseif color == "darkred"
            out = [127 0 0]/255;
        elseif color == "grey"
            out = [96 96 96]/255;
        elseif color == "darkgrey"
            out = [48 48 48]/255;
        elseif color == "lightgrey"
            out = [160 160 160]/255;
        else
            out = color;
        end
    end
end

end