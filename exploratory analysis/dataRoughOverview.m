if ~exist('TUwide','var')
    importWideData
end
subplot(2,2,1)
histogram(TUwide.srh4(~isnan(TUwide.srh4)))
subplot(2,2,2)
histogram(TUwide.srh5(~isnan(TUwide.srh5)))
subplot(2,2,3)
histogram(TUwide.srh6(~isnan(TUwide.srh6)))
subplot(2,2,4)
histogram(TUwide.srh7(~isnan(TUwide.srh7)))

prob( TUwide.srh4(~isnan(TUwide.srh4))>=3 ,"perc",2)
