function coeffs = getMFCC(x,fs,figures,t1,t2)
% computes MFCC's for the timeseries x that was sampled with frequency fs.
% t  = length of a timestep (inverse of sampling frequency)
% t1 = number of timesteps in a window
% t2 = number of overlapping timesteps between coensecutive windows
if nargin==2
    figures = false;
    t1 = 25e-3;
    t2 = 10e-3;
elseif nargin==3
    t1 = 25e-3;
    t2 = 10e-3;
elseif nargin==4
    t2 = 10e-3;
end

t  = fs^-1; % length of a timestep
win = hann(floor(t1/t));
S = stft(x,"Window",win,"OverlapLength",floor(t2/t),"Centered",false);
% coeffs = mfcc(S,fs,"LogEnergy","Ignore");
coeffs = mfcc(S,fs);
coeffs = coeffs';

if figures
    imagesc(flipud(coeffs))
    axis tight
end

end