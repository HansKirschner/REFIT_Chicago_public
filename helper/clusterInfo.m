function permutedT_Points = clusterInfo(Pointslme_Pvalue,Pointslme_TStats,threshold)

% find significant points
candid_Points = Pointslme_Pvalue <= threshold;
candid_Points_marked = zeros(1,length(candid_Points));
candid_Points_marked(1) = candid_Points(1);
candid_Points_marked(length(candid_Points)) = candid_Points(length(candid_Points));

%remove orphan time points
for i = 2:length(Pointslme_Pvalue)-1
    if candid_Points(i-1) == 0 && candid_Points(i) ==1 && candid_Points(i+1) ==0
        candid_Points_marked(i) = 0;
    else
        candid_Points_marked(i) = candid_Points(i);
    end
end

% combine whole time range with relevent time & significant information
clusters = candid_Points_marked; % significant or not
clusterT = Pointslme_TStats;  % t values

%%find how many clusters there are, and compute summed T of each cluster
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
a = tmp(1:cl,:);
eachCluster = a(:,logical(sum(a,1)~=0));

%now, compute summed T of each cluster
dat_clusterSumT_Points = zeros(HowManyClusters,1);
for c = 1:HowManyClusters
    dat_clusterSumT_Points(c,1) = sum(clusterT(eachCluster(c,eachCluster(c,:) ~=0)));
end
if size(dat_clusterSumT_Points,1) > 0 % if there is at least one signifiant cluster
    permutedT_Points= max(dat_clusterSumT_Points);
else
    permutedT_Points = 0;
end