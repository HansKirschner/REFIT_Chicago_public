function [ptask,outcometask,tvolatile,tstable]=data_REFITChigaco(i)

load('all_behavior_PLSession.mat')


index = find(D(1).Stimno==i);

ptask       = D(1).Prob(index)'/100;
outcometask = D(1).outcome(index)';

N = length(ptask);
n = 10; % after 10 trials post changepoint we assume stability...

change_points = find(diff(ptask)~=0);
tvolatile = false(N,1);
for i=1:length(change_points)
    tvolatile(change_points(i) + (1:n)) = 1; 

end

tvolatile(1:10)=1;

tstable = ~tvolatile;
tstable(1:n) = 0;