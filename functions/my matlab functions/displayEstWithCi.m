function displayStr = displayEstWithCi(estimate, ci, displayStyle, CiDisplayStyle, NsigDig)
% takes estimate and ci and displays them as a string, with desired format
% and number of decimals.
if nargin==2
    displayStyle   = "decimal";
    CiDisplayStyle = "full";
    NsigDig = 2;
elseif nargin==3
    CiDisplayStyle = "full";
    NsigDig = 2;
elseif nargin==4
    NsigDig = 2;
end

% round to make results more readable
if displayStyle=="decimal"
    ci       = round(ci,NsigDig-1);
    estimate = round(estimate,NsigDig);
elseif displayStyle=="percentage"
    ci       = round(100*ci,NsigDig-1);
    estimate = round(100*estimate,NsigDig);
end

if CiDisplayStyle=="full"
    displayStr = sprintf('%g (%g,%g)',estimate,ci(1),ci(2));
    
elseif CiDisplayStyle=="plusminus"
    deviation = ci(2) - mean(ci);
    displayStr = sprintf('%g +/-%g',estimate,deviation);
end
end