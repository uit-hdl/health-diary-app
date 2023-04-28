function I_or = myor(indexArray, arg2, nanTreatment)
% my version of the function "or", which accepts as argument a cell array
% of logical index vectos.

% nanTreatment is an optional argument that determines how to treat entries
% where at least one of the vectors has a nan value. The default is for
% both values to set as nan only when both are nan ("or").

% *** Possible options ***
% "and" --> put nan only when both have nan.
% "or"  --> put nan if nan in one or more of the vectors

if nargin < 3
    nanTreatment = "or";
end

if iscell(indexArray)
    n_arrays = length(indexArray);
    I_or = zeros(size(indexArray{1}));
    if n_arrays > 1
        for i = 2:n_arrays
            array1 = indexArray{i-1};
            array2 = indexArray{i};
            I_nan = nanVec(array1, array2, nanTreatment);
            I_or = I_or + or(indexArray{i-1} == 1, indexArray{i} == 1) + I_nan;
        end
    end

else

    arg1 = indexArray;

    I_nan = nanVec(arg1, arg2, nanTreatment);
    I_or = or(indexArray == 1, arg2 == 1) + I_nan;

end

end