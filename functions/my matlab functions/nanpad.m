function A = nanpad(A, Npadded)
% Takes a cell array A consisting of arrays that can be of different
% lengths and appends neutral/empty elements to each array in order to make
% the lengths consistent. Used mostly for tabular presentation of data. If
% two arguments are provided, then A is assumed to be a vector which is to
% be padded to length Npadded.

%%
if nargin==1
    
    N = numel(A);

    S = zeros(1,N);
    for i=1:N
        S(i) = numel(A{i});
    end

    Npadded = max(S);

        for i=1:N

            n = numel(A{i});

            % flip in case is row:
            if isrow(A{i})
                A{i} = A{i}';
            end

            if isnumeric(A{i})
                a = nan(Npadded-n,1);

            elseif isstring(A{i})
                a = strings([Npadded-n,1]);

            elseif iscell(A{i})
                a = cell(Npadded-n,1);
                for k=1:Npadded-n
                    a{k} = ' ';
                end

            elseif iscategorical(A{i})
                a = categorical(nan(Npadded-n,1));
                if isordinal(A{i})
                    A{i} = categorical(A{i},'ordinal',false); %#ok<*NASGU>
                end

            end

            % append:
            A{i} = cat(1, A{i}, a);

        end

else
    
    n = numel(A);

    % flip in case is row:
    if isrow(A)
        A = A';
    end

    if isnumeric(A)
        a = nan(Npadded-n,1);

    elseif isstring(A)
        a = strings([Npadded-n,1]);

    elseif iscell(A)
        a = cell(Npadded-n,1);
        for k=1:Npadded-n
            a{k} = ' ';
        end

    elseif iscategorical(A)
        a = categorical(nan(Npadded-n,1));
        if isordinal(A)
            A = categorical(A,'ordinal',false); %#ok<*NASGU>
        end

    end

    % append:
    A = cat(1, A, a);
   
end
%%
% a = categorical({'1','2'})'
% H = 5;
% n = numel(a)
% a = cat(1,a,categorical(nan(H-n,1)))


end




