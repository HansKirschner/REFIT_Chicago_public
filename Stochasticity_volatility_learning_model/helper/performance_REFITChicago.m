function [x,xlr, tstable, tvolatile,ac] = performance_REFITChicago(ptask,val,lr)
%keyboard

ii50 = ptask==0.5; 
ptask(ii50) = [];
dv = [0; val(1:end-1)]-.5;
p = 1./(1+exp(-dv));

%ac =  p > rand(length(p),1);
ac = p>=.5;

p(ii50) = [];
lr(ii50) = [];

N = length(p);
n = 10; % after 10 trials post changepoint we assume stability...

change_points = find(diff(ptask)~=0);
tvolatile = false(N,1);
for i=1:length(change_points)
    tvolatile(change_points(i) + (1:n)) = 1;    
end
tstable = ~tvolatile;
tstable(1:n) = 0;

corr_action = ptask>=.5;

choice = p>=.5;
%choice = p > rand(length(p),1);

perf = choice==corr_action;

LC = ptask==.3 | ptask==.7;
HC = ptask==.2 | ptask==.8;

index_LC_early  = tvolatile & LC;
index_LC_Late   = tstable & LC;

index_HC_early  = tvolatile & HC;
index_HC_Late   = tstable & HC;

mpvol_LC   = mean(perf(index_LC_early,:));
mpstab_LC  = mean(perf(index_LC_Late,:));

mpvol_LC   = mean(mpvol_LC);
mpstab_LC  = mean(mpstab_LC);

mpvol_HC   = mean(perf(index_HC_early,:));
mpstab_HC  = mean(perf(index_HC_Late,:));

mpvol_HC   = mean(mpvol_HC);
mpstab_HC  = mean(mpstab_HC);

x = [mpstab_LC mpvol_LC mpstab_HC mpvol_HC];

mLRvol_LC   = mean(lr(index_LC_early,:));
mLRstab_LC  = mean(lr(index_LC_Late,:));

mLRvol_HC   = mean(lr(index_HC_early,:));
mLRstab_HC  = mean(lr(index_HC_Late,:));

xlr = [mLRstab_LC mLRvol_LC mLRstab_HC mLRvol_HC];

end
