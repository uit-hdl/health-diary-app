function [I,K] = windowSegment(x,W,L)
% creates a matrix where each row is a window of indeces that arise from
% sliding a window of length W across the data vector x such that the
% windows overlap by L elements.

N = length(x);

K = floor((N-L)/(W-L));    % number of windows
n = (1:K+1)*W - (0:K)*L; % right endpoints of windows
% N_s = (K+1)*W - K*L - N;   % spillover

I = cell(K+1,1);             % matrix that contains the window indeces

for i=1:K
    I{i} = n(i)-W+1:n(i);
end

if n(K)==N
    I{K+1} = NA; % in case we can fit exactly K windows
else
    I{K+1} = n(K+1)-W+1:N ;
end

end