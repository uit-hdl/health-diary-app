function [ci, ciWidth, meanEst, stdev] = computeCImeanEst(dataMatrix, ciRepr, method, nSigDig)
% function that computes 95% confidence intervals for estimate of
%  mean value m using sample data_matrix. If data_matrix is a matrix with
%  each column corresponding to a sample, then function returns a matrix
%  where row i is the ci correspoding to sample i. N is size of each
%  sample. Default method is to assume that the mean is to use the
%  t-distribution

% Hint: Use "format short g" to not display trailing zeroes.

%% preliminary
if nargin == 1
    ciRepr = "1";
    method = "tdist";
    nSigDig = [];
elseif nargin == 2
    method = "tdist";
    nSigDig = [];
elseif nargin == 3
    nSigDig = [];
end

if isempty(ciRepr)
    ciRepr = "1";
end
if isempty(method)
    method = "tdist";
end

if isrow(dataMatrix) % means that it is a row vector -- flip to column vector
    dataMatrix = dataMatrix';
end

%% Main Code

% sum the number of non-nan elements for each column
N = sum(~isnan(dataMatrix));

meanEst = mean(dataMatrix, 'omitnan')';

if method == "normal"
    stdev = sqrt(var(dataMatrix, 'omitnan')./N);
    ciWidth = 1.96 * stdev';
else
    stdev = sqrt(var(dataMatrix, 'omitnan')./N);
    ciWidth = tinv(0.975, N-1) * stdev';
end


ci = meanEst + ciWidth * [-1, 1];

if ~isempty(nSigDig)
    ci = round(ci, nSigDig);
    meanEst = round(meanEst, nSigDig);
end

% *** table representation ***
if ciRepr == "2"
    %     form: [ciLower,estimate,ciUpper]
    ciLower = ci(:, 1);
    estimate = meanEst;
    ciUpper = ci(:, 2);
    showWidth = false;
    outTable = false;
    if showWidth
        ci = table(ciLower, estimate, ciUpper, ciWidth);
    else
        if outTable
            ci = table([estimate, ciLower, ciUpper]);
        else
            ci = [ciLower, estimate, ciUpper];
        end
    end
end


% *** table representation ***
if ciRepr == "3"
    %     form: [ciLower,estimate,ciUpper]
    ciLower = ci(:, 1);
    estimate = meanEst;
    ciUpper = ci(:, 2);
    showWidth = false;
    outTable = false;
    if showWidth
        ci = table(ciLower, estimate, ciUpper, ciWidth);
    else
        if outTable
            ci = table([estimate, ciLower, ciUpper]);
        else
            ci = [estimate, ciLower, ciUpper];
        end
    end
end

% *** Display in Console ***
if ciRepr == "4"
    meanEst = meanEst;
    ci = ci;
    ciWidth = ciWidth;
    stdev = stdev;
    str1 = sprintf('CI: (%.1f %.1f %.1f)', ci(1), meanEst, ci(2));
    str2 = sprintf('ci width: %.1f', ciWidth);
    str3 = sprintf('estimate std: %.1f', stdev);
    str = sprintf('%s\n%s\n%s', str1, str2, str3);
    disp(str)
end

end