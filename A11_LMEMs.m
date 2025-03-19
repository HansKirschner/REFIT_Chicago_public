
clc;clear;
load('Data/REFIT_Chicago_Data_long.mat')

%%
color    = get(groot,'DefaultAxesColorOrder');

WindowSize = 25;

bef     = (WindowSize-1)/2;
post    = (WindowSize-1)/2;

[~,BLPerformanceOrder] = sort(REFIT_Chicago_DataM.BLPerformace(1:94));

Range = ((WindowSize-1)/2)+1:length(BLPerformanceOrder)-((WindowSize-1)/2);


% total points
DiffTotalPoints = REFIT_Chicago_DataM.TotalPoints(95:end)-REFIT_Chicago_DataM.TotalPoints(1:94);

DiffTotalPoints_SlidingWindow       = nan(length(BLPerformanceOrder)-(bef+post),1);
DiffTotalPoints_SlidingWindow_se    = nan(length(BLPerformanceOrder)-(bef+post),1);

for i = ((WindowSize-1)/2)+1:length(BLPerformanceOrder)-((WindowSize-1)/2)

    ubef    = i-bef;
    upost   = i + post;

    DiffTotalPoints_SlidingWindow(i) = mean(DiffTotalPoints(BLPerformanceOrder(ubef:upost)));
    DiffTotalPoints_SlidingWindow_se(i) = se(DiffTotalPoints(BLPerformanceOrder(ubef:upost)));

end

figure(2);clf;
subplot(3,2,1);
shadedErrBar([],DiffTotalPoints_SlidingWindow,DiffTotalPoints_SlidingWindow_se,{ '-o','color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 4, 'lineWidth', 3}); hold on
yline(0, '--k',LineWidth=1)
xlim([Range(1), Range(end)])
xline(round(length(Range)/2)+bef, '--k',LineWidth=1)
ylabel(sprintf('\\Delta Total points \n on-off drug'))
set(gca, 'XTickLabel', []);

% differences p(correct) high outcome noise late learning
DiffLR_LC = REFIT_Chicago_DataM.LR_LC_late(95:end)-REFIT_Chicago_DataM.LR_LC_late(1:94);

DiffLR_LC_SlidingWindow       = nan(length(BLPerformanceOrder)-(bef+post),1);
DiffLR_LC_SlidingWindow_se    = nan(length(BLPerformanceOrder)-(bef+post),1);

for i = ((WindowSize-1)/2)+1:length(BLPerformanceOrder)-((WindowSize-1)/2)

    ubef    = i-bef;
    upost   = i + post;

    DiffLR_LC_SlidingWindow(i) = mean(DiffLR_LC(BLPerformanceOrder(ubef:upost)));
    DiffLR_LC_SlidingWindow_se(i) = se(DiffLR_LC(BLPerformanceOrder(ubef:upost)));

end

subplot(3,2,2);
shadedErrBar([],DiffLR_LC_SlidingWindow,DiffLR_LC_SlidingWindow_se,{ '-o','color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 4, 'lineWidth', 3}); hold on
yline(0, '--k',LineWidth=1)
xlim([Range(1), Range(end)])
xline(round(length(Range)/2)+bef, '--k',LineWidth=1)
ylabel(sprintf('\\Delta P(correct) on-off drug \n high outcome noise'))
set(gca, 'XTickLabel', []);

% eta
DiffEta = REFIT_Chicago_DataM.Eta(95:end)-REFIT_Chicago_DataM.Eta(1:94);

DiffEta_SlidingWindow       = nan(length(BLPerformanceOrder)-(bef+post),1);
DiffEta_SlidingWindow_se    = nan(length(BLPerformanceOrder)-(bef+post),1);

EtaBL_SlidingWindow       = nan(length(BLPerformanceOrder)-(bef+post),1);
EtaNL_SlidingWindow_se    = nan(length(BLPerformanceOrder)-(bef+post),1);

EtaBL = REFIT_Chicago_DataM.Eta(1:94);

for i = ((WindowSize-1)/2)+1:length(BLPerformanceOrder)-((WindowSize-1)/2)

    ubef    = i-bef;
    upost   = i + post;

    DiffEta_SlidingWindow(i) = mean(DiffEta(BLPerformanceOrder(ubef:upost)));
    DiffEta_SlidingWindow_se(i) = se(DiffEta(BLPerformanceOrder(ubef:upost)));

    EtaBL_SlidingWindow(i) = mean(EtaBL(BLPerformanceOrder(ubef:upost)));
    EtaBL_SlidingWindow_se(i) = se(EtaBL(BLPerformanceOrder(ubef:upost)));

end

subplot(3,2,3);
shadedErrBar([],DiffEta_SlidingWindow,DiffEta_SlidingWindow_se,{ '-o','color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 4, 'lineWidth', 3}); hold on
yline(0, '--k',LineWidth=1)
xlim([Range(1), Range(end)])
xline(round(length(Range)/2)+bef, '--k',LineWidth=1)
ylabel(sprintf('\\Delta Eta on-off drug'))
set(gca, 'XTickLabel', []);

% LR variation
DiffLRSD_LC_late = REFIT_Chicago_DataM.LRSD_LC_late(95:end)-REFIT_Chicago_DataM.LRSD_LC_late(1:94);

DiffLRSD_LC_SlidingWindow       = nan(length(BLPerformanceOrder)-(bef+post),1);
DiffLRSD_LC_SlidingWindow_se    = nan(length(BLPerformanceOrder)-(bef+post),1);

for i = ((WindowSize-1)/2)+1:length(BLPerformanceOrder)-((WindowSize-1)/2)

    ubef    = i-bef;
    upost   = i + post;

    DiffLRSD_LC_SlidingWindow(i) = mean(DiffLRSD_LC_late(BLPerformanceOrder(ubef:upost)));
    DiffLRSD_LC_SlidingWindow_se (i) = se(DiffLRSD_LC_late(BLPerformanceOrder(ubef:upost)));

end


subplot(3,2,4);
shadedErrBar([],DiffLRSD_LC_SlidingWindow,DiffLRSD_LC_SlidingWindow_se,{ '-o','color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 4, 'lineWidth', 3}); hold on
yline(0, '--k',LineWidth=1)
xlim([Range(1), Range(end)])
xline(round(length(Range)/2)+bef, '--k',LineWidth=1)
ylabel(sprintf('\\Delta Learning rate SD \n on-off drug'))
set(gca, 'XTickLabel', []);

%

DiffPcorr2MFB_LC = REFIT_Chicago_DataM.Pcorr2MFB_LC(95:end)-REFIT_Chicago_DataM.Pcorr2MFB_LC(1:94);

DiffPcorr2MFB_LC_SlidingWindow       = nan(length(BLPerformanceOrder)-(bef+post),1);
DiffPcorr2MFB_LC_SlidingWindow_se    = nan(length(BLPerformanceOrder)-(bef+post),1);

for i = ((WindowSize-1)/2)+1:length(BLPerformanceOrder)-((WindowSize-1)/2)

    ubef    = i-bef;
    upost   = i + post;

    DiffPcorr2MFB_LC_SlidingWindow(i) = mean(DiffPcorr2MFB_LC(BLPerformanceOrder(ubef:upost)));
    DiffPcorr2MFB_LC_SlidingWindow_se(i) = se(DiffPcorr2MFB_LC(BLPerformanceOrder(ubef:upost)));

end

subplot(3,2,5);
shadedErrBar([],DiffPcorr2MFB_LC_SlidingWindow,DiffPcorr2MFB_LC_SlidingWindow_se,{ '-o','color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 4, 'lineWidth', 3}); hold on
yline(0, '--k',LineWidth=1)
xlim([Range(1), Range(end)])
xline(round(length(Range)/2)+bef, '--k',LineWidth=1)
ylabel(sprintf('\\Delta P(correct after double MFB) \n on-off drug'))
set(gca, 'XTickLabel', []);

%
DiffSNR = REFIT_Chicago_DataM.SNR(95:end)-REFIT_Chicago_DataM.SNR(1:94);

DiffSNR_SlidingWindow       = nan(length(BLPerformanceOrder)-(bef+post),1);
DiffSNR_SlidingWindow_se    = nan(length(BLPerformanceOrder)-(bef+post),1);

for i = ((WindowSize-1)/2)+1:length(BLPerformanceOrder)-((WindowSize-1)/2)

    ubef    = i-bef;
    upost   = i + post;

    DiffSNR_SlidingWindow(i) = mean(DiffSNR(BLPerformanceOrder(ubef:upost)));
    DiffSNR_SlidingWindow_se(i) = se(DiffSNR(BLPerformanceOrder(ubef:upost)));

end

subplot(3,2,6);
shadedErrBar([],DiffSNR_SlidingWindow,DiffSNR_SlidingWindow_se,{ '-o','color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 4, 'lineWidth', 3}); hold on
yline(0, '--k',LineWidth=1)
ylabel(sprintf('\\Delta Signal to noise \n on-off drug'))
xlim([Range(1), Range(end)])
xline(round(length(Range)/2)+bef, '--k',LineWidth=1)
set(gca, 'XTickLabel', []);

h = gcf;
h.Position = [-2394         -90        1070        1104];
print2pdf(fullfile(pwd,'Figures',['BaselinePerformance_x_KeyResutls.pdf']),h,300)

figure(3);clf;
shadedErrBar([],EtaBL_SlidingWindow,EtaBL_SlidingWindow_se,{ '-o','color', color(2,:), 'markerfacecolor',color(1,:), 'markerSize', 4, 'lineWidth', 3}); hold on
yline(0, '--k',LineWidth=1)
ylim([.1 .5])
ylabel(sprintf('Eta off-drug'))
xlim([Range(1), Range(end)])
xline(round(length(Range)/2)+bef, '--k',LineWidth=1)
set(gca, 'XTickLabel', []);
h = gcf;
h.Position = [-2285         730         321         284];
print2pdf(fullfile(pwd,'Figures',['Eta_offDrug.pdf']),h,300)

%% Sliding Window regression
Pointslme_TStats_org = nan(length(BLPerformanceOrder)-(bef+post),1);
Pointslme_Pvalue_org = nan(length(BLPerformanceOrder)-(bef+post),1);

Pcorr_LClatelme_TStats_org = nan(length(BLPerformanceOrder)-(bef+post),1);
Pcorr_LClatelme_Pvalue_org = nan(length(BLPerformanceOrder)-(bef+post),1);

Etalme_TStats_org = nan(length(BLPerformanceOrder)-(bef+post),1);
Etalme_Pvalue_org = nan(length(BLPerformanceOrder)-(bef+post),1);

LRSD_LC_latelm_TStats_org = nan(length(BLPerformanceOrder)-(bef+post),1);
LRSD_LC_latelm_Pvalue_org = nan(length(BLPerformanceOrder)-(bef+post),1);


Pcorr2MFB_LC_TStats_org = nan(length(BLPerformanceOrder)-(bef+post),1);
Pcorr2MFB_LC_Pvalue_org = nan(length(BLPerformanceOrder)-(bef+post),1);

SNR_TStats_org = nan(length(BLPerformanceOrder)-(bef+post),1);
SNR_Pvalue_org = nan(length(BLPerformanceOrder)-(bef+post),1);

for i = ((WindowSize-1)/2)+1:length(BLPerformanceOrder)-((WindowSize-1)/2)

    ubef    = i-bef;
    upost   = i + post;

    Subindex    = [BLPerformanceOrder(ubef:upost);BLPerformanceOrder(ubef:upost)+94];

    SubTable    = REFIT_Chicago_DataM(Subindex,:);

    Pointslme       = fitlme(SubTable, 'TotalPoints ~ DrugSession + SesssionOrder + (1|SubjNr)');
    Pcorr_LClatelme = fitlme(SubTable, 'LR_LC_late ~ DrugSession + SesssionOrder + (1|SubjNr)');
    Etalme          = fitlme(SubTable, 'Eta ~ DrugSession + SesssionOrder + (1|SubjNr)');
    LRSD_LC_latelme = fitlme(SubTable, 'LRSD_LC_late ~ DrugSession + SesssionOrder + (1|SubjNr)');
    Pcorr2MFB_LC    = fitlme(SubTable, 'Pcorr2MFB_LC ~ DrugSession + SesssionOrder + (1|SubjNr)');
    SNR             = fitlme(SubTable, 'SNR ~ DrugSession + SesssionOrder + (1|SubjNr)');


    Pointslme_TStats_org(i)         = Pointslme.Coefficients.tStat(2);
    Pointslme_Pvalue_org(i)         = Pointslme.Coefficients.pValue(2);

    Pcorr_LClatelme_TStats_org(i)   = Pcorr_LClatelme.Coefficients.tStat(2);
    Pcorr_LClatelme_Pvalue_org(i)   = Pcorr_LClatelme.Coefficients.pValue(2);

    Etalme_TStats_org(i)            = Etalme.Coefficients.tStat(2);
    Etalme_Pvalue_org(i)            = Etalme.Coefficients.pValue(2);

    LRSD_LC_latelm_TStats_org(i)    = LRSD_LC_latelme.Coefficients.tStat(2);
    LRSD_LC_latelm_Pvalue_org(i)    = LRSD_LC_latelme.Coefficients.pValue(2);

    Pcorr2MFB_LC_TStats_org(i)      =  Pcorr2MFB_LC.Coefficients.tStat(2);
    Pcorr2MFB_LC_Pvalue_org(i)      =  Pcorr2MFB_LC.Coefficients.pValue(2);

    SNR_TStats_org(i)               =  SNR.Coefficients.tStat(2);
    SNR_Pvalue_org(i)               =  SNR.Coefficients.pValue(2);

end
path('helper/',path);

load('Data/H0_ClusterMass.mat')

threshold = .05;
NPermutations = 1000;
Pointslme_TStats = Pointslme_TStats_org;

figure(3);clf;
subplot(3,2,1);

[eachCluster,dat_clusterSumT] = clusterInfo_OriginalData(Pointslme_Pvalue_org,Pointslme_TStats_org,threshold);
permutedT_Points = abs(permutedT_Points);
permutedT_Points = sort(permutedT_Points);
cutOff = NPermutations - NPermutations * (threshold/2); %2-sided test
critT = permutedT_Points(round(cutOff)); % t-mass of top 10%
sigCluster = abs(dat_clusterSumT) > abs(critT);
% draw clusters
draw = eachCluster(sigCluster,:);
draw = sort(reshape(draw,1,size(draw,1)*size(draw,2)));
draw = draw(draw>0);
w = zeros(length(Pointslme_TStats_org),1);
w(draw)=1;

plot([1:length(Pointslme_TStats)],Pointslme_TStats',LineWidth=4); hold on
yline(0, '--k',LineWidth=1)
ylabel(sprintf('t-value'))
xline(round(length(Range)/2)+bef, '--k',LineWidth=1)
shade_the_back(w, [.7 .7 .7],[1:length(Pointslme_TStats)])
xlim([Range(1), Range(end)])
set(gca, 'XTickLabel', []);
title('Total points')

subplot(3,2,2);
[eachCluster,dat_clusterSumT] = clusterInfo_OriginalData(Pcorr_LClatelme_Pvalue_org,Pcorr_LClatelme_TStats_org,threshold);
permutedT_Pcorr_LClate = abs(permutedT_Pcorr_LClate);
permutedT_Pcorr_LClate = sort(permutedT_Pcorr_LClate);

cutOff = NPermutations - NPermutations * (threshold/2); %2-sided test
critT = permutedT_Pcorr_LClate(round(cutOff)); % t-mass of top 10%
sigCluster = abs(dat_clusterSumT) > abs(critT);

% draw clusters
draw = eachCluster(sigCluster,:);
draw = sort(reshape(draw,1,size(draw,1)*size(draw,2)));
draw = draw(draw>0);
w = zeros(length(Pointslme_TStats_org),1);
w(draw)=1;

plot([1:length(Pcorr_LClatelme_TStats_org)],Pcorr_LClatelme_TStats_org',LineWidth=4); hold on
yline(0, '--k',LineWidth=1)
ylabel(sprintf('t-value'))
xline(round(length(Range)/2)+bef, '--k',LineWidth=1)
shade_the_back(w, [.7 .7 .7],[1:length(Pointslme_TStats)])
xlim([Range(1), Range(end)])
set(gca, 'XTickLabel', []);
title(sprintf('P(corr choice) late learning \n high outcome noise'))

subplot(3,2,3);
[eachCluster,dat_clusterSumT] = clusterInfo_OriginalData(Etalme_Pvalue_org,Etalme_TStats_org,threshold);
permutedT_Eta = abs(permutedT_Eta);
permutedT_Eta = sort(permutedT_Eta);
cutOff = NPermutations - NPermutations * (threshold/2); %2-sided test
critT = permutedT_Eta(round(cutOff)); % t-mass of top 10%
sigCluster = abs(dat_clusterSumT) > abs(critT);
% draw clusters
draw = eachCluster(sigCluster,:);
draw = sort(reshape(draw,1,size(draw,1)*size(draw,2)));
draw = draw(draw>0);
w = zeros(length(Pointslme_TStats_org),1);
w(draw)=1;

plot([1:length(Etalme_TStats_org)],Etalme_TStats_org',LineWidth=4); hold on
yline(0, '--k',LineWidth=1)
ylabel(sprintf('t-value'))
xline(round(length(Range)/2)+bef, '--k',LineWidth=1)
shade_the_back(w, [.7 .7 .7],[1:length(Pointslme_TStats)])
xlim([Range(1), Range(end)])
set(gca, 'XTickLabel', []);
title(sprintf('Eta'))

subplot(3,2,4);
[eachCluster,dat_clusterSumT] = clusterInfo_OriginalData(LRSD_LC_latelm_Pvalue_org,LRSD_LC_latelm_TStats_org,threshold);
permutedT_LRSD_LC_late = abs(permutedT_LRSD_LC_late);
permutedT_LRSD_LC_late = sort(permutedT_LRSD_LC_late);
cutOff = NPermutations - NPermutations * (threshold/2); %2-sided test
critT = permutedT_LRSD_LC_late(round(cutOff)); % t-mass of top 10%
sigCluster = abs(dat_clusterSumT) > abs(critT);
% draw clusters
draw = eachCluster(sigCluster,:);
draw = sort(reshape(draw,1,size(draw,1)*size(draw,2)));
draw = draw(draw>0);
w = zeros(length(LRSD_LC_latelm_TStats_org),1);
w(draw)=1;

plot([1:length(LRSD_LC_latelm_TStats_org)],LRSD_LC_latelm_TStats_org',LineWidth=4); hold on
yline(0, '--k',LineWidth=1)
ylabel(sprintf('t-value'))
xline(round(length(Range)/2)+bef, '--k',LineWidth=1)
shade_the_back(w, [.7 .7 .7],[1:length(Pointslme_TStats)])
xlim([Range(1), Range(end)])
set(gca, 'XTickLabel', []);
title(sprintf('learning rate SD'))

subplot(3,2,5);

[eachCluster,dat_clusterSumT] = clusterInfo_OriginalData(Pcorr2MFB_LC_Pvalue_org,Pcorr2MFB_LC_TStats_org,threshold);
permutedT_Pcorr2MFB = abs(permutedT_Pcorr2MFB);
permutedT_Pcorr2MFB = sort(permutedT_Pcorr2MFB);
cutOff = NPermutations - NPermutations * (threshold/2); %2-sided test
critT = permutedT_Pcorr2MFB(round(cutOff)); % t-mass of top 10%
sigCluster = abs(dat_clusterSumT) > abs(critT);
% draw clusters
draw = eachCluster(sigCluster,:);
draw = sort(reshape(draw,1,size(draw,1)*size(draw,2)));
draw = draw(draw>0);
w = zeros(length(LRSD_LC_latelm_TStats_org),1);
w(draw)=1;

plot([1:length(LRSD_LC_latelm_TStats_org)],Pcorr2MFB_LC_TStats_org',LineWidth=4); hold on
yline(0, '--k',LineWidth=1)
ylabel(sprintf('t-value'))
xline(round(length(Range)/2)+bef, '--k',LineWidth=1)
shade_the_back(w, [.7 .7 .7],[1:length(Pointslme_TStats)])
xlim([Range(1), Range(end)])
set(gca, 'XTickLabel', []);
title(sprintf('P(correct after double MFB)'))

subplot(3,2,6);
[eachCluster,dat_clusterSumT] = clusterInfo_OriginalData(SNR_Pvalue_org,SNR_TStats_org,threshold);
permutedT_SNR = abs(permutedT_SNR);
permutedT_SNR = sort(permutedT_SNR);
cutOff = NPermutations - NPermutations * (threshold/2); %2-sided test
critT = permutedT_SNR(round(cutOff)); % t-mass of top 10%
sigCluster = abs(dat_clusterSumT) > abs(critT);
% draw clusters
draw = eachCluster(sigCluster,:);
draw = sort(reshape(draw,1,size(draw,1)*size(draw,2)));
draw = draw(draw>0);
w = zeros(length(LRSD_LC_latelm_TStats_org),1);
w(draw)=1;

plot([1:length(SNR_TStats_org)],SNR_TStats_org',LineWidth=4); hold on
yline(0, '--k',LineWidth=1)
ylabel(sprintf('t-value'))
xline(round(length(Range)/2)+bef, '--k',LineWidth=1)
shade_the_back(w, [.7 .7 .7],[1:length(Pointslme_TStats_org)])
xlim([Range(1), Range(end)])
set(gca, 'XTickLabel', []);
title(sprintf('SNR'))

h = gcf;
h.Position = [-2394         -90        1070        1104];
print2pdf(fullfile(pwd,'Figures',['LMEMs_KeyResutls_CMC.pdf']),h,300)

ert

%% run cluster based permutaiton test
threshold           = .05;
NPermutations       = 1000;

permutedT_Points    = nan(1,NPermutations);
permutedT_Pcorr_LClate = nan(1,NPermutations);

permutedT_Eta    = nan(1,NPermutations);
permutedT_Pcorr2MFB = nan(1,NPermutations);

permutedT_LRSD_LC_late    = nan(1,NPermutations);
permutedT_SNR = nan(1,NPermutations);

for permt = 1:NPermutations

    permt
    for i = ((WindowSize-1)/2)+1:length(BLPerformanceOrder)-((WindowSize-1)/2)

        ubef    = i-bef;
        upost   = i + post;

        Subindex    = [BLPerformanceOrder(ubef:upost);BLPerformanceOrder(ubef:upost)+94];

        SubTable    = REFIT_Chicago_DataM(Subindex,:);

        shuffle_idx = randperm(height(SubTable)); % Generate random permutation of indices
        SubTable.DrugSession = SubTable.DrugSession(shuffle_idx); % Apply the permutation to the column

        shuffle_idx = randperm(height(SubTable)); % Generate random permutation of indices
        SubTable.SesssionOrder = SubTable.SesssionOrder(shuffle_idx); % Apply the permutation to the column


        Pointslme       = fitlme(SubTable, 'TotalPoints ~ DrugSession + SesssionOrder + (1|SubjNr)');
        Pcorr_LClatelme = fitlme(SubTable, 'LR_LC_late ~ DrugSession + SesssionOrder + (1|SubjNr)');
        Etalme          = fitlme(SubTable, 'Eta ~ DrugSession + SesssionOrder + (1|SubjNr)');
        LRSD_LC_latelme = fitlme(SubTable, 'LRSD_LC_late ~ DrugSession + SesssionOrder + (1|SubjNr)');
        Pcorr2MFB_LC    = fitlme(SubTable, 'Pcorr2MFB_LC ~ DrugSession + SesssionOrder + (1|SubjNr)');
        SNR             = fitlme(SubTable, 'SNR ~ DrugSession + SesssionOrder + (1|SubjNr)');


        Pointslme_TStats(i-bef)         = Pointslme.Coefficients.tStat(2);
        Pointslme_Pvalue(i-bef)         = Pointslme.Coefficients.pValue(2);

        Pcorr_LClatelme_TStats(i-bef)   = Pcorr_LClatelme.Coefficients.tStat(2);
        Pcorr_LClatelme_Pvalue(i-bef)   = Pcorr_LClatelme.Coefficients.pValue(2);

        Etalme_TStats(i-bef)            = Etalme.Coefficients.tStat(2);
        Etalme_Pvalue(i-bef)            = Etalme.Coefficients.pValue(2);

        LRSD_LC_latelm_TStats(i-bef)    = LRSD_LC_latelme.Coefficients.tStat(2);
        LRSD_LC_latelm_Pvalue(i-bef)    = LRSD_LC_latelme.Coefficients.pValue(2);

        Pcorr2MFB_LC_TStats(i-bef)      =  Pcorr2MFB_LC.Coefficients.tStat(2);
        Pcorr2MFB_LC_Pvalue(i-bef)      =  Pcorr2MFB_LC.Coefficients.pValue(2);

        SNR_TStats(i-bef)               =  SNR.Coefficients.tStat(2);
        SNR_Pvalue(i-bef)               =  SNR.Coefficients.pValue(2);

    end

     permutedT_Points(permt)            = clusterInfo(Pointslme_Pvalue,Pointslme_TStats,threshold);
     permutedT_Pcorr_LClate(permt)      = clusterInfo(Pcorr_LClatelme_Pvalue,Pcorr_LClatelme_TStats,threshold);


     permutedT_Eta(permt)               = clusterInfo(Etalme_Pvalue,Etalme_TStats,threshold);
     permutedT_LRSD_LC_late(permt)      = clusterInfo(LRSD_LC_latelm_Pvalue,LRSD_LC_latelm_TStats,threshold);

     permutedT_Pcorr2MFB(permt)         = clusterInfo(Pcorr2MFB_LC_Pvalue,Pcorr2MFB_LC_TStats,threshold);
     permutedT_SNR(permt)               = clusterInfo(SNR_Pvalue,SNR_TStats,threshold);

end

save("Data/H0_ClusterMass.mat","permutedT_Points","permutedT_Pcorr_LClate","permutedT_Eta","permutedT_LRSD_LC_late","permutedT_Pcorr2MFB","permutedT_SNR")

permutedT_Points = sort(permutedT_Points);

