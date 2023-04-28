function Z = convert2LatexFormat(S)
% takes as input a character array S = {'str1', 'str2', 'abc_123', ...},
% and converts each character array to latex format. Ex.,  name_sub is
% formatted to name_{sub}. Similarly, name1_sub1:name2_sub2 gets formatted
% to name1_{sub1}:name2_{sub2}. Primarily used to make names from fitted
% linear models look nicer when plotting.

% example input: S = {'name1_sub','name1_sub1:name22_sub2','name3_sub1:name2:name4_1'}
%%

if not(iscell(S)) && ischar(S)
    S = {S};
end

n = numel(S);
B = cell(n,1);
for i=1:n
    s = S{i};
    stringState = "upper";
    
    for j=1:numel(s)
        x = s(j);
        
        levelChange = false;
        if x=="_"
            stringState = "lower";
            levelChange = true;
        end
        if stringState=="lower" && x==":"
            stringState = "upper";
            levelChange = true;
        end
            
        if levelChange
            B{i}(end+1) = j;
        end
        
        if j==numel(s) && not(isempty(B{i}))
            B{i}(end+1) = j;
        end
            
    end
end

% s = S{2};
% strcat(s(1     :B(1)  ),'{',... %j=1
%        s(B(1)+1:B(2)-1),'}',... %j=2
%        s(B(2)  :B(3)  ),'{',... %j=3
%        s(B(3)+1:B(4)  ),'}')    %j=4
%    
Z = cell(1,n);
for i=1:n
    s = S{i};
    b = B{i};
    
    if isempty(B{i})
        Z{i} = s;
        
    else
        m = numel(b);
        z = strcat(s(1:b(1)  ),'{');

        for j=2:m
            if mod(j,2)==1
                    z = strcat(z, s(b(j-1):b(j)), '{');
            else
                if j==m
                    z = strcat(z, s(b(j-1)+1:b(m)), '}');
                else
                    z = strcat(z, s(b(j-1)+1:b(j)-1), '}');
                end

            end

        end
        
        Z{i} = z;
        
    end
    
end


end