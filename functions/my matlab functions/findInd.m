function Isub = findInd(Jwhole,Jsub)
% Find positions of elements of Jsub that are in Jwhole. Specifically,
% takes two linear index vectors Jwhole and Jsub, and returns a logical
% index vector I of the same size as Jwhole whith ones if the element is in
% Jsub.
%% Ex: 
% Jwhole = [1.0 2.1  3.0 4.0 5.0 6.0];
% Jsub   = [1.0 2.1 6.0];
% returns:  [1 1 0 0 0 1]
%% preliminary
if nargin==1
    Jsub = Jwhole;
    Jwhole = 1:Jsub(end);
end

if iscell(Jwhole)
    Jwhole = string(Jwhole);
elseif iscell(Jsub)
    Jsub = string(Jsub);
end
%%
% the code expects column vectors:
if isrow(Jwhole)
    Jwhole = Jwhole';
end
if isrow(Jsub)
    Jsub = Jsub';
end

if isempty(Jsub)
    Isub = zeros(size(Jwhole))==1;
else
    Isub = sum(Jwhole'==Jsub,1)>0;
    Isub = reshape(Isub, size(Jwhole));
end


end