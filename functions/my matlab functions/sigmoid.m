function y = sigmoid(x,varargin)

%% optional arguments
location = 0;
scale = 1;
lvl = 0;
yrange = 1;
plotIt = false;

p = inputParser;
addOptional(p, 'location', location, @(x) isnumeric(x));
addOptional(p, 'scale', scale,       @(x) isnumeric(x));
addOptional(p, 'lvl', lvl,       @(x) isnumeric(x));
addOptional(p, 'yrange', yrange,       @(x) isnumeric(x));
addOptional(p, 'plotIt', plotIt,     @(x) islogical(x));

parse(p,varargin{:});

location = p.Results.location;
scale    = p.Results.scale;
lvl      = p.Results.lvl;
yrange   = p.Results.yrange;
plotIt   = p.Results.plotIt;

%% function body

y = 1./(exp(-(x-location)/scale) + 1)*yrange + lvl;

if plotIt
    xrange = location + [-1 1]*scale*10;
    xx = xrange(1):(scale)/10:xrange(2);
    plot(xx,  1./(exp(-(xx-location)/scale) + 1)*yrange + lvl)
end

end