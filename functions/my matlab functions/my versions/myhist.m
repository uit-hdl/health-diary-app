function a = myhist(x,nanTreatment,normalization)

if nargin==1
    nanTreatment = "exclude";
    normalization = "prob";
elseif nargin==2
    normalization = "prob";
end

if isempty(nanTreatment)
    nanTreatment = "exclude";
end

if nanTreatment=="exclude"
    if iscategorical(x)
        I = ~ismissing(x);
    else
        I = ~isnan(x);
    end
else
    I = 1:numel(x);
end 


a = histogram(x(I),'Norm',normalization);

end