function z = squeezeItIn(x, Jsqueeze,y_squeeze,replaceJ)
% take a vector or array x and an element y, and squeezes y in between
% position J1 and J2, producing a new vector z of length numel(x)+1.

%% example input
% x = 1:10;
% Jsqueeze = 3;
% y_squeeze = [0 0];
% z: 
%     1     2     3     0     0     4     5     6     7     8     9    10
%% preliminary
if nargin==3
    replaceJ = false;
end
%% code

if replaceJ
    z = [x(1:Jsqueeze-1), y_squeeze, x(Jsqueeze+1:end)];
else
    z = [x(1:Jsqueeze), y_squeeze, x(Jsqueeze+1:end)];
end

end