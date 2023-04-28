function Irows = id2index_TUdata(longData,idList,time)
% takes a vector of id numbers in idList and finds the row indeces that
% correspond to those id's in the part of the survey that corresponds to
% the survey index (4-7) provided by the variable time. longData is a data
% frame that contains data in long format (original is TUdata with data
% from T4 to T7).

IrowsAll = findInd(longData.id,idList);
Itime = longData.time==time;
Irows = and(IrowsAll,Itime);
end