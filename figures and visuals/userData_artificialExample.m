sleep =           [8 5.5 6.0 7.2 5.0 7 7 6 7];
noScreenAfter10 = [1 0   1   1   0   0 1 0 0];
exercise        = [1 0   1   0   1   0 1 1 1];
srh             = [4 2   4   3   3   2 4 3 4];

clf
subplot(1,2,1)
exerP = plot(exercise,'-','color','b');
hold on
m = mean(exercise);
yline(m,'--','color','b')
goodDays = find(exercise>m);
badDays = find(exercise<m);
plot(goodDays,exercise(goodDays),'o','color','g','MarkerFaceColor','g')
plot(badDays,exercise(badDays),'o','color','r','MarkerFaceColor','red')

noScreenP = plot(noScreenAfter10+2,'-','color','cyan');
yline(mean(noScreenAfter10)+2,'--','color','cyan')
m = mean(noScreenAfter10);
goodDays = find(noScreenAfter10>m);
badDays = find(noScreenAfter10<m);
plot(goodDays,noScreenAfter10(goodDays)+2,'o','color','g','MarkerFaceColor','g')
plot(badDays,noScreenAfter10(badDays)+2,'o','color','r','MarkerFaceColor','red')


sleepP = plot(sleep-2,'-','color','m');
yline(mean(sleep)-2,'--','color','m')
m = mean(sleep);
goodDays = find(sleep>m);
badDays = find(sleep<m);
plot(goodDays,sleep(goodDays)-2,'o','color','g','MarkerFaceColor','g')
plot(badDays,sleep(badDays)-2,'o','color','r','MarkerFaceColor','red')

srhP = plot(srh+4,'-o','color','k');
yline(median(srh)+4,'--','color','k')
m = median(srh);
goodDays = find(srh>m);
badDays = find(srh<m);
plot(goodDays,srh(goodDays)+4,'o','color','g','MarkerFaceColor','g');
plot(badDays,srh(badDays)+4,'o','color','r','MarkerFaceColor','red')
set(gca,'ytick',[])
xlabel 'day'

% legend([srhP,sleepP,noScreenP,exerP],{'wellbeing','sleep hrs.','no screen after 10 pm','30 min exercise'})
% legend({'srhP','sleepP'},{'wellbeing','2'})

subplot(1,2,2)
c1 = corr([exercise',srh']);
c2 = corr([noScreenAfter10',srh']);
c3 = corr([sleep',srh']);


barText = categorical(["one","two","three"]);
bar(2,c1(1,2),'b')
hold on
bar(4,c2(1,2),'c')
bar(6,c3(1,2),'m')
ylim([0,1])
set(gca,'xtick',[2,4,6],'xticklabel',["exercise" "no screen after 10 pm" "sleep hrs."])
title 'Association between habit and wellbeing'
%%
plot(1,c1(1,2),'o','MarkerFaceColor','b')
hold on
plot(2,c2(1,2),'o','MarkerFaceColor','cyan')
plot(3,c3(1,2),'o','MarkerFaceColor','m')

