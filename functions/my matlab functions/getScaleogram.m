function M = getScaleogram(x,Fs,plotIt,crop,ab,varargin)
% ** DESCRIPTION **
% computes and displays the scaleogram of the signal x. Fs is the sampling
% frequency of the signal (if downsampled then Fs = Fs0/Nds). 
%% preliminary

%% optional name-value-pair arguments:
p = inputParser;
addOptional(p, 'showUnits', false, @(x) islogical(x));
parse(p,varargin{:});
% Get the number of name-value-pair arguments:
NnameValPairArgs = numel(p.Parameters) - numel(p.UsingDefaults);
posnargin = nargin - NnameValPairArgs;
%% Positional arguments:
if posnargin==1
    Fs = 44100;
    plotIt = false;
    crop = 10:60;
    ab = [.85 .03];
elseif posnargin==2
    plotIt = false;
    crop = 10:60;
    ab = [.85 .03];
elseif posnargin==3
    crop = 10:60;
    ab = [.85 .03];
elseif posnargin==4
    ab = [.85 .03];
end
%%



[cfs,~,f] = cwt(x,'amor',Fs);
% tms = (0:length(x)-1)/Fs; % sampling times
M = abs(cfs);

if crop==false
    crop = 1:height(M);
end
p.Results.showUnits
plotIt
if plotIt || p.Results.showUnits
%     a = .85;
%     b = 0.03;
%     ab(1)=1;
%     ab(2)=inf;
    
    
    if p.Results.showUnits
        Icrop = and(f<800, f>15);
        f = f(Icrop);
        imagesc(pseudoLog(M(Icrop,:),ab(1),ab(2)))
        
        % fix x axis ticks:
        xticklabels(string(xticks/fs))
        % fix y axis ticks:
        N0 = 10;
        yaxis_density = 10;
        Nfrq = sum(Icrop);
        yticks(N0:yaxis_density:Nfrq)
        yticklabels(string(round(f(N0:yaxis_density:Nfrq),0)))
        xlabel 'time (s)'
        ylabel 'Frequenzy (Hz)'
    else
        imagesc(pseudoLog(M(crop,:),ab(1),ab(2)))
    end
end

end