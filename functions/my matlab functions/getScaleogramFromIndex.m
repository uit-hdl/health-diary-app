function [M,id,x] = getScaleogramFromIndex(dataFrame,I,k,aa,plotIt,nodes,Nds,labels,Fs)
% Plotts recordings from a subset I of data frame dataFrame (typically
% HSdata). k refers to the position of the observation within the subset
% which is plotted. Requires 4 input arguments. If nodes is not provided,
% then no segmentation information is plotted. M is the matrix containing
% the scaleogram data, id is the id of the plotted observation, and x is
% the HS-signal plotted (downsampled).

if nargin==4
    plotIt = true;
    nodes = [];
    Nds = 20;
    labels = [];
    Fs = 44100;
elseif nargin==5
    nodes = [];
    Nds = 20;
    labels = [];
    Fs = 44100;
elseif nargin==6
    Nds = 20;
    labels = [];
    Fs = 44100;
elseif nargin==7
    labels = [];
    Fs = 44100;
elseif nargin==8
    Fs = 44100;
end

if isempty(I)
    J = 1:height(dataFrame);
else
    J = find(I);
end
% get adress of recording in the whole population:
kk = J(k);
id = dataFrame.UNIKT_LOPENR(kk);

if numel(aa)==1
    
    x = wav2TS(id,aa);
    x = downsample(x,Nds);
    M = getScaleogram(x,floor(Fs/Nds),plotIt);
    hold on
    if ~isempty(nodes)
        n = numel(x);
        assignedStates = getExpandedReprOfStates(nodes.loc{kk,aa},...
                                                 nodes.state{kk,aa},n);
        plotAssignedStates(assignedStates,[2,4],['r','b'],1)
    end
    
else
    
    for i=1:4
        subplot(2,2,i)
        x = wav2TS(id,aa(i));
        x = downsample(x,Nds);
        M = getScaleogram(x,floor(Fs/Nds),plotIt);
        hold on
        if ~isempty(nodes)
            n = numel(x);
            assignedStates = getExpandedReprOfStates(nodes.loc{kk,aa(i)},...
                                                     nodes.state{kk,aa(i)},n);
            plotAssignedStates(assignedStates,[2,4],['r','b'],1)
        end
    end
    
end

if ~isempty(labels) && numel(aa)==1
    if labels.mur==true
        murGrade = dataFrame.(sprintf('Murmur_%g_grade_ref_ny_T72',aa))(kk);
        strMur   = sprintf('murmurGrade=%g',murGrade);
    end
    if labels.vhd==true
        vhdg = [dataFrame.ASGRADE_T72(kk),dataFrame.ARGRADE_T72(kk),...
            dataFrame.MSGRADE_T72(kk),dataFrame.MRGRADE_T72(kk)];
        strVhd = sprintf('    AS,AR,MS,MR = [%g,%g,%g,%g]',vhdg(1),vhdg(2),...
                                                        vhdg(3),vhdg(4));
    end
        
        
    title(strcat(strMur,strVhd));
end

end