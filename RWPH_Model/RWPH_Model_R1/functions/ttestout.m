% jrw 2014
% HK 2014 updated so that it also works for unequal samples
function outstring = ttestout(sample1,sample2,tail);

if tail == 1
    info = 'both';
elseif tail == 2
    info = 'right';
elseif tail == 3
    info = 'left';
end

if length(sample1) == length(sample2)
        [h,p,ci,t] = ttest(sample1,sample2,'Tail',info);
else
        [h,p,ci,t] = ttest2(sample1,sample2,'Tail',info);
end
    
d = effectsize(sample1,sample2);
outstring = ['  ' num2str(nanmean(sample1)) ' (' num2str(sem(sample1)) ') vs. ' num2str(nanmean(sample2)) ' (' num2str(sem(sample2)) '); t(' num2str(t.df) ') = ' num2str(t.tstat) ', p = ' num2str(p) ', d = ' num2str(d)];
disp(outstring);
