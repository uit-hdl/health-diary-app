function out = AUCfromSinglePnt(sn,sp)
x = 1 - sp;
y = sn;
out = 1/2*(1 + y - x);
end