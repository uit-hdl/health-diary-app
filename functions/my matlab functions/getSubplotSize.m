function N = getSubplotSize(k)
% ** description **
% takes the number of images k and returns a field N which contains the
% SUBPLOT shape that is convenient for displaying the n images in a
% approximately SQUARE shape.

xx = (1:6).^2;

n = find((k<=xx),1,'first');
N(1) = n;
N(2) = n - (k<=n*(n-1));
end