% Create table that shows collinearities between variables

T = data(data.t==7, ["age", "smokeNow", ...
    "angina", ...
    "cancer", "hii", "hypert", "diab", "strokeOrHrtAtk" ...
    "bmi34", "PAf34i23", "hscl", "insomnia", ...
    "blameSelf", "fear", "depr", "worried", "friendsSupp", ...
    ])
[Tcorr, pVal] = correlationTable(T, "round2", 1, ...
    "showPercentage", true, ...
    "calcP", true, ...
    "displayPvalues", true)

Tcorr
%% Look at a specific relationship
T = TUdata(:, ["age", "bmi"])