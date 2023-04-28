function Jnew = getNewAdress(data0,J0,Jsub)
% data0 is the original dataframe. J0 contains the linear indeces for a
% subset of data0, for instance the training set. Jsub, also contain linear
% indeces for a subset of data0, for example the set of all non-noisy
% observations. Let dataSub = data0(Jsub,:) be the data frame corresponding
% to the subset Jsub, and suppose you want to access the elements of J0
% that are in dataSub, i.e. get the linear indeces wrt. dataSub of the
% elements corresponding to J0 that are in dataSub. That is what this
% function does.
%% example input
% data0 = HSdata; % whole data set
% J0   = union(Jtrain0,Jval0); % indeces for training set
% Jsub = Jnonoise;
% dataSub = training data whith noissy samples removed
%%
% get id of subset corresponding to J0:
id = data0.UNIKT_LOPENR(J0);
% create subset dataframe:
dataSub = data0(Jsub,:);
% find linear indeces wrt. subset dataframe corresponding to J0:
Jnew = find(findInd(dataSub.UNIKT_LOPENR,id));


end