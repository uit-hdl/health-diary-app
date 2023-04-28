function plotWithCI(M,xVals,col,lineTpe,leg,estRow)
% Plots estimate and ci's provided as rows in matrix M. The estimate is
% assumed to be contained in the second row.
if nargin==2
    col = ["lightblue","b","lightblue"];
    leg = {'95% bootstrap-ci','estimate'};
    lineTpe = ["--","-","--"];
    estRow = 2;
elseif nargin==3
    leg = {'95% bootstrap-ci','estimate'};
    lineTpe = ["--","-","--"];
    estRow = 2;
end
if isempty(lineTpe)
    lineTpe = ["--","-","--"];
    estRow = 2;
end
if isempty(col)
    col = ["lightblue","b","lightblue"];
end
if isempty(xVals)
    xVals = 1:width(M);
end

if estRow==1
    M = [M(2,:);M(1,:);M(3,:)];
end

if numel(col)==1
    col = repmat(col,[1,3]);
end

plot(xVals,M(1,:),'color',color2triplet(col{1}),'linestyle',lineTpe{1});
hold on
plot(xVals,M(2,:),'color',color2triplet(col{2}),'linestyle',lineTpe{2});
plot(xVals,M(3,:),'color',color2triplet(col{3}),'linestyle',lineTpe{3});
legend(leg)
end