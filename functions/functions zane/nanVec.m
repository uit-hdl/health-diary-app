function z = nanVec(x,y,nanCondition)
% creates a vector of logical zeros, with nans in the same positions as x.
% if two vecotors x and y are provided, then creates a vector of zeros and
% nans, with nans in positions where both x and y have nans, or nans in
% positions where x or y have nans, depending on the third argument
% nanCondition.
% "or" --> assigns nan if EITHER is nan
if nargin==1
    Inan = ismissing(x);
    
else
    Inan_x = ismissing(x);
    Inan_y = ismissing(y);
    
    if nanCondition=="or"
        Inan = or(Inan_x,Inan_y);
    elseif nanCondition=="and"
        Inan = and(Inan_x,Inan_y);
    end
end

z = zeros(size(x));
z(Inan) = nan;

end