function [eachCluster,dat_clusterSumT] = clusterInfo_OriginalData(Pointslme_Pvalue,Pointslme_TStats,threshold)

candid = Pointslme_Pvalue <= threshold;

%remove orphan time points
candid_woOrphan = candid;
candid_woOrphan(1,1) = candid(1,1);
for i = 2:length(candid)-1
    if candid(i-1) == 0 && candid(i) ==1 && candid(i+1) ==0
        candid_woOrphan(i) = 0;
    else
        candid_woOrphan(i) = candid(i);
    end
end

% combine whole time range with relevent time & significant information
clusters = candid_woOrphan;
clusterT = Pointslme_TStats;

%%find how many clusters are there, and compute summed T of each cluster
tmp = zeros(10,25); % creates a matrix with arbitrary size (n cluster x size of each cluster)
cl = 0;
member = 0;
for i = 2:length(clusters)-1
    if clusters(i-1) ==0 && clusters(i) == 1 && clusters(i+1) == 1
        cl = cl+1;
        member = member +1;
        tmp(cl,member) = i;
    elseif clusters(i-1) ==1 && clusters(i) == 1 && clusters(i+1) == 0
        if i == 2
            cl = cl +1;
            member = member +1;
            tmp(cl,member) = i;
            member = 0;
        else
            member = member +1;
            tmp(cl,member) = i;
            member = 0;
        end
    elseif clusters(i-1) ==1 && clusters(i) == 1 && clusters(i+1) == 1
        if i ==2
            cl = cl+1;
            member = member +1;
            tmp(cl,member) = i;
        else
            member = member +1;
            tmp(cl,member) = i;
        end
    else
    end
end
HowManyClusters = cl;
a = tmp(1:cl,:); % subset significant clusters
eachCluster = a(:,logical(sum(a,1)~=0)); % cut the size at the maximum cluster

%now, compute summed T of each cluster
dat_clusterSumT = nan(HowManyClusters,1);
for c = 1:HowManyClusters
    dat_clusterSumT(c,1) = sum(clusterT(eachCluster(c,eachCluster(c,:) ~=0)));
end


