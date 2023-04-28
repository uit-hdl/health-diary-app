function JsubNew = getIndecesWRTnewBasis(J0,J0sub,Jclean)
% Suppose you are forming a new set J0(Jclean) = Jnew, and you want to
% references the subset J0sub, but with respect to the set Jnew and not the
% mother set J0. That is what this function does.
%% example 1:
% J0   = 1:numel(union(Jtrain0,Jval0));
% J0sub = CVresults.JatleastOne;
% Jclean = ~Inan;
% YtestOld = data.AGE_T7(J0sub);
%% example 2:
% J0 = 1:7;
% Yold =  [1 4 15 23 11 7 50];
% I0sub = [1 1 0  1  1  0 1];
% Iclean =[1 1 0  1  0  1 1];
% J0sub = [1,2,4,5,7];
% Jclean = find(Iclean);
%% preliminary:

if islogical(J0)
    J0 = find(J0);
end
if islogical(J0sub)
    J0sub = find(J0sub);
end
if islogical(Jclean)
    Jclean = find(Jclean);
end
%%
Isub0 = findInd(J0,J0sub);
IcleanNew = Isub0(Jclean);
JsubNew = find(IcleanNew);
end
