clear
rootDir = pwd;
addpath(genpath(rootDir));

load('data/DrugS_wPrior_Data_111110.mat')
load('data/fminconResults/DrugS_wGenPrior_fminconResult_111110.mat')

InvTDrug        = fminconResult.fitParams(:,1);
PlayBiasDrug    = fminconResult.fitParams(:,2);
EtaDrug         = fminconResult.fitParams(:,3);
LRIntcptDrug    = fminconResult.fitParams(:,4);
LRFeedConfDrug  = fminconResult.fitParams(:,5);


load('data/PLS_wPriors_Data_111110.mat')
load('data/fminconResults/PLS_wGenPriors_fminconResult_111110.mat')
InvTPLS        = fminconResult.fitParams(:,1);
PlayBiasPLS    = fminconResult.fitParams(:,2);
EtaPLS         = fminconResult.fitParams(:,3);
LRIntcptPLS    = fminconResult.fitParams(:,4);
LRFeedConfPLS  = fminconResult.fitParams(:,5);

load('data/fminconResults/fminconResult_wPrior_111110.mat')
InvTOS        = fminconResult.fitParams(:,1);
PlayBiasOS    = fminconResult.fitParams(:,2);
EtaOS         = fminconResult.fitParams(:,3);
LRIntcptOS    = fminconResult.fitParams(:,4);
LRFeedConfOS  = fminconResult.fitParams(:,5);

load('data/RawInfoDrugSession_V2.mat')
load('data/RawInfoPLSession_V2.mat')

load('data/all_EndPOints_PLS.mat')
load('data/all_EndPOints_DS.mat')

%% exclusion of subjects
load('data/InfoSubjects.mat')
load('Data/SessionInfo.mat')
load('data/all_EndPOints_Orientation.mat')

% Orientation
excluda_O                           = [26,79,86];
excluda_expSession                  = [30,60,90,97];
ID(excluda_expSession)              = [];
Session1(excluda_expSession)        = [];

InvTPLS(excluda_expSession)         = [];
PlayBiasPLS(excluda_expSession)     = [];
EtaPLS(excluda_expSession)          = [];
LRIntcptPLS(excluda_expSession)     = [];
LRFeedConfPLS(excluda_expSession)   = [];

InvTDrug(excluda_expSession)         = [];
PlayBiasDrug(excluda_expSession)     = [];
EtaDrug(excluda_expSession)          = [];
LRIntcptDrug(excluda_expSession)     = [];
LRFeedConfDrug(excluda_expSession)   = [];

%P correct choices
RawInfoPLSession.CorrChoice_earlyLearning_HighProb(excluda_expSession)  = [];
RawInfoPLSession.CorrChoice_lateLearning_HighProb(excluda_expSession)   = [];
RawInfoPLSession.CorrChoice_earlyLearning_LowProb(excluda_expSession)   = [];
RawInfoPLSession.CorrChoice_lateLearning_LowProb(excluda_expSession)    = [];

RawInfoDrugSession.CorrChoice_earlyLearning_HighProb(excluda_expSession)    = [];
RawInfoDrugSession.CorrChoice_lateLearning_HighProb(excluda_expSession)      = [];
RawInfoDrugSession.CorrChoice_earlyLearning_LowProb(excluda_expSession)     = [];
RawInfoDrugSession.CorrChoice_lateLearning_LowProb(excluda_expSession)      = [];


%SD LR
RawInfoPLSession.SD_LR_earlyLearning_all(excluda_expSession)  = [];
RawInfoPLSession.SD_LR_lateLearning_all(excluda_expSession)  = [];

RawInfoPLSession.SD_LR_earlyLearning_HighProb(excluda_expSession)  = [];
RawInfoPLSession.SD_LR_lateLearning_HighProb(excluda_expSession)  = [];

RawInfoPLSession.SD_LR_earlyLearning_LowProb(excluda_expSession)  = [];
RawInfoPLSession.SD_LR_lateLearning_LowProb(excluda_expSession)  = [];

RawInfoDrugSession.SD_LR_earlyLearning_all(excluda_expSession)  = [];
RawInfoDrugSession.SD_LR_lateLearning_all(excluda_expSession)  = [];

RawInfoDrugSession.SD_LR_earlyLearning_HighProb(excluda_expSession)  = [];
RawInfoDrugSession.SD_LR_lateLearning_HighProb(excluda_expSession)  = [];

RawInfoDrugSession.SD_LR_earlyLearning_LowProb(excluda_expSession)  = [];
RawInfoDrugSession.SD_LR_lateLearning_LowProb(excluda_expSession)  = [];

% response switches
RawInfoPLSession.RS_earlyLearning_HighProb(excluda_expSession)  = [];
RawInfoPLSession.RS_lateLearning_HighProb(excluda_expSession)   = [];
RawInfoPLSession.RS_earlyLearning_LowProb(excluda_expSession)   = [];
RawInfoPLSession.RS_lateLearning_LowProb(excluda_expSession)    = [];

RawInfoDrugSession.RS_earlyLearning_HighProb(excluda_expSession)    = [];
RawInfoDrugSession.RS_lateLearning_HighProb(excluda_expSession)      = [];
RawInfoDrugSession.RS_earlyLearning_LowProb(excluda_expSession)     = [];
RawInfoDrugSession.RS_lateLearning_LowProb(excluda_expSession)      = [];

% response switches to error
RawInfoPLSession.RS_Err_earlyLearning_HighProb(excluda_expSession)   = [];
RawInfoPLSession.RS_Err_lateLearning_HighProb(excluda_expSession)   = [];
RawInfoPLSession.RS_Err_earlyLearning_LowProb(excluda_expSession)   = [];
RawInfoPLSession.RS_Err_lateLearning_LowProb(excluda_expSession)    = [];

RawInfoDrugSession.RS_Err_earlyLearning_HighProb(excluda_expSession)    = [];
RawInfoDrugSession.RS_Err_lateLearning_HighProb(excluda_expSession)      = [];
RawInfoDrugSession.RS_Err_earlyLearning_LowProb(excluda_expSession)     = [];
RawInfoDrugSession.RS_Err_lateLearning_LowProb(excluda_expSession)      = [];


% correct choices after misleading FB
RawInfoPLSession.AccAfterMisleadingFB_earlyLearing_LowProb(excluda_expSession)    = [];
RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb(excluda_expSession)    = [];    
RawInfoPLSession.AccAfterMisleadingFB_lateLearning_HighProb(excluda_expSession)    = [];

RawInfoDrugSession.AccAfterMisleadingFB_earlyLearing_LowProb(excluda_expSession)    = [];
RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb(excluda_expSession)    = [];    
RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_HighProb(excluda_expSession)    = [];


EndPOints_PLS(excluda_expSession)   = [];
EndPOints_DS(excluda_expSession)    = [];

Shortname(excluda_O)            = [];
EndPOints_O(excluda_O)          = [];

InvTOS(excluda_O)           = [];
PlayBiasOS(excluda_O)       = [];
EtaOS(excluda_O)            = [];
LRIntcptOS(excluda_O)       = [];
LRFeedConfOS(excluda_O)     = [];

LIA                             = ismember(ID,Shortname,'rows');
indexExclude_missingO           = find(LIA==0)';

Session1(indexExclude_missingO)        = [];

InvTPLS(indexExclude_missingO)         = [];
PlayBiasPLS(indexExclude_missingO)     = [];
EtaPLS(indexExclude_missingO)          = [];
LRIntcptPLS(indexExclude_missingO)     = [];
LRFeedConfPLS(indexExclude_missingO)   = [];

InvTDrug(indexExclude_missingO)         = [];
PlayBiasDrug(indexExclude_missingO)     = [];
EtaDrug(indexExclude_missingO)          = [];
LRIntcptDrug(indexExclude_missingO)     = [];
LRFeedConfDrug(indexExclude_missingO)   = [];

% P correct choices
RawInfoPLSession.CorrChoice_earlyLearning_HighProb(indexExclude_missingO)  = [];
RawInfoPLSession.CorrChoice_lateLearning_HighProb(indexExclude_missingO)   = [];
RawInfoPLSession.CorrChoice_earlyLearning_LowProb(indexExclude_missingO)   = [];
RawInfoPLSession.CorrChoice_lateLearning_LowProb(indexExclude_missingO)    = [];

RawInfoDrugSession.CorrChoice_earlyLearning_HighProb(indexExclude_missingO)    = [];
RawInfoDrugSession.CorrChoice_lateLearning_HighProb(indexExclude_missingO)      = [];
RawInfoDrugSession.CorrChoice_earlyLearning_LowProb(indexExclude_missingO)     = [];
RawInfoDrugSession.CorrChoice_lateLearning_LowProb(indexExclude_missingO)      = [];


%SD LR
RawInfoPLSession.SD_LR_earlyLearning_all(indexExclude_missingO)  = [];
RawInfoPLSession.SD_LR_lateLearning_all(indexExclude_missingO)  = [];

RawInfoPLSession.SD_LR_earlyLearning_HighProb(indexExclude_missingO)  = [];
RawInfoPLSession.SD_LR_lateLearning_HighProb(indexExclude_missingO)  = [];

RawInfoPLSession.SD_LR_earlyLearning_LowProb(indexExclude_missingO)  = [];
RawInfoPLSession.SD_LR_lateLearning_LowProb(indexExclude_missingO)  = [];

RawInfoDrugSession.SD_LR_earlyLearning_all(indexExclude_missingO)  = [];
RawInfoDrugSession.SD_LR_lateLearning_all(indexExclude_missingO)  = [];

RawInfoDrugSession.SD_LR_earlyLearning_HighProb(indexExclude_missingO)  = [];
RawInfoDrugSession.SD_LR_lateLearning_HighProb(indexExclude_missingO)  = [];

RawInfoDrugSession.SD_LR_earlyLearning_LowProb(indexExclude_missingO)  = [];
RawInfoDrugSession.SD_LR_lateLearning_LowProb(indexExclude_missingO)  = [];

% responses switches
RawInfoPLSession.RS_earlyLearning_HighProb(indexExclude_missingO)  = [];
RawInfoPLSession.RS_lateLearning_HighProb(indexExclude_missingO)   = [];
RawInfoPLSession.RS_earlyLearning_LowProb(indexExclude_missingO)   = [];
RawInfoPLSession.RS_lateLearning_LowProb(indexExclude_missingO)    = [];

RawInfoDrugSession.RS_earlyLearning_HighProb(indexExclude_missingO)     = [];
RawInfoDrugSession.RS_lateLearning_HighProb(indexExclude_missingO)      = [];
RawInfoDrugSession.RS_earlyLearning_LowProb(indexExclude_missingO)      = [];
RawInfoDrugSession.RS_lateLearning_LowProb(indexExclude_missingO)       = [];

% response switches to error

RawInfoPLSession.RS_Err_earlyLearning_HighProb(indexExclude_missingO)       = [];
RawInfoPLSession.RS_Err_lateLearning_HighProb(indexExclude_missingO)        = [];
RawInfoPLSession.RS_Err_earlyLearning_LowProb(indexExclude_missingO)        = [];
RawInfoPLSession.RS_Err_lateLearning_LowProb(indexExclude_missingO)         = [];

RawInfoDrugSession.RS_Err_earlyLearning_HighProb(indexExclude_missingO)     = [];
RawInfoDrugSession.RS_Err_lateLearning_HighProb(indexExclude_missingO)      = [];
RawInfoDrugSession.RS_Err_earlyLearning_LowProb(indexExclude_missingO)      = [];
RawInfoDrugSession.RS_Err_lateLearning_LowProb(indexExclude_missingO)       = [];


% correct choices after misleading FB
RawInfoPLSession.AccAfterMisleadingFB_earlyLearing_LowProb(indexExclude_missingO)       = [];
RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb(indexExclude_missingO)       = [];
RawInfoPLSession.AccAfterMisleadingFB_lateLearning_HighProb(indexExclude_missingO)       = [];

RawInfoDrugSession.AccAfterMisleadingFB_earlyLearing_LowProb(indexExclude_missingO)       = [];
RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb(indexExclude_missingO)       = [];
RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_HighProb(indexExclude_missingO)       = [];


% endpoints
EndPOints_PLS(indexExclude_missingO)    = [];
EndPOints_DS(indexExclude_missingO)     = [];

split = median(EndPOints_O);

indexLowScoreO  = find(EndPOints_O<=split);
indexHighScoreO = find(EndPOints_O>split);


%% Check eta stuff - use GLM to see how parmams affect switching behaviour
Eta_all          = [EtaDrug;EtaPLS];

CorrChoice_early_HighProb   = [RawInfoDrugSession.CorrChoice_earlyLearning_HighProb;RawInfoPLSession.CorrChoice_earlyLearning_HighProb];
CorrChoice_late_HighProb    = [RawInfoDrugSession.CorrChoice_lateLearning_HighProb;RawInfoPLSession.CorrChoice_lateLearning_HighProb];

CorrChoice_early_LowProb   = [RawInfoDrugSession.CorrChoice_earlyLearning_LowProb;RawInfoPLSession.CorrChoice_earlyLearning_LowProb];
CorrChoice_late_LowProb    = [RawInfoDrugSession.CorrChoice_lateLearning_LowProb;RawInfoPLSession.CorrChoice_lateLearning_LowProb];


ACCMisFEED_late_LowProb    = [RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb;RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb];


[r,p]=corr(Eta_all,CorrChoice_early_HighProb);
[r,p]=corr(Eta_all,CorrChoice_late_HighProb);

[r,p]=corr(Eta_all,CorrChoice_early_LowProb);
[r,p]=corr(Eta_all,CorrChoice_late_LowProb);


[r,p]=corr(Eta_all,ACCMisFEED_late_LowProb);

color    = get(groot,'DefaultAxesColorOrder');

figure(2);clf;
subplot(1,3,1)
scatter(Eta_all,ACCMisFEED_late_LowProb);hold on
hline = refline;
hline.LineWidth=3;
plot(EtaDrug,RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb, 'o', 'markerSize', 12, 'markerFaceColor', color(3,:), 'markerEdgeColor', 'k', 'lineWidth', 1)
plot(EtaPLS, RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb, 'o', 'markerSize', 12, 'markerFaceColor', color(1,:), 'markerEdgeColor', 'k', 'lineWidth', 1)
ylabel('P(correct after double MFB)')
xlabel('Eta')
title('r = .29, p < 0.001')
ylim([0.2 1.05])
%h = gcf;
%h.Position=[-2217         538         560         420];
%print2pdf(fullfile(pwd,'FIgures',['Corr_EtaAccMisFB_newColors.pdf']),h,300)


%figure(3),clf;
subplot(1,3,2)
[x,y1,~,IQR] = violinplotHK(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb);
patch([y1 -y1(end:-1:1)] , [x x(end:-1:1)], color(1,:),'facealpha',.7)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb);
patch([y1 -y1(end:-1:1)]+3 , [x x(end:-1:1)], color(3,:),'facealpha',.7)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb),'ko','markerfacecolor','g','markersize',10)
set(gca,'xlim',[-2.5 5.5],'xtick',[],'ylim',[0.4 1.05])
box off

subplot(1,3,3)
[x,y1,~,IQR] = violinplotHK(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb(indexLowScoreO));
patch([y1 -y1(end:-1:1)] , [x x(end:-1:1)], color(1,:),'facealpha',.5)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb(indexLowScoreO));
patch([y1 -y1(end:-1:1)]+3 , [x x(end:-1:1)], color(3,:),'facealpha',.5)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

box off
%high performer 
[x,y1,~,IQR] = violinplotHK(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb(indexHighScoreO));
patch([y1 -y1(end:-1:1)]+6, [x x(end:-1:1)], color(1,:),'facealpha',.9)
hold on
plot([6 6],IQR,'k','linew',3)
plot(6,nanmean(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(6,nanmedian(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb(indexHighScoreO));
patch([y1 -y1(end:-1:1)]+9 , [x x(end:-1:1)], color(3,:),'facealpha',.9)
plot([9 9],IQR,'k','linew',3)
plot(9,nanmean(RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(9,nanmedian(RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)
set(gca,'xlim',[-2.5 11.5],'xtick',[],'ylim',[0.4 1.05])
box off

h = gcf;
h.Position=[86         582        1452         419];
print2pdf(fullfile(pwd,'FIgures',['EtaAccMisFB_newColor.pdf']),h,300)



% p       = polyfit(EtaDrug,RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb,2);
% x1      = linspace(min(Eta_all),max(Eta_all),1000);
% y1      = polyval(p,x1);
% figure(2);clf;
% plot(Eta_all,ACCMisFEED_late_LowProb,'o')
% hold on
% plot(x1,y1,LineWidth=2)

%% plotting split by orientation performance

figure(1),clf;
subplot(2,3,1)
[x,y1,~,IQR] = violinplotHK(InvTPLS(indexLowScoreO));
patch([y1 -y1(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.5)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(InvTPLS(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(InvTPLS(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(InvTDrug(indexLowScoreO));
patch([y1 -y1(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.5)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(InvTDrug(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(InvTDrug(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)
set(gca,'xlim',[-2.5 5.5],'xtick',[],'ylim',[0 6])
box off
title('InvT')

%high performer 
[x,y1,~,IQR] = violinplotHK(InvTPLS(indexHighScoreO));
patch([y1 -y1(end:-1:1)]+6, [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.9)
hold on
plot([6 6],IQR,'k','linew',3)
plot(6,nanmean(InvTPLS(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(6,nanmedian(InvTPLS(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(InvTDrug(indexHighScoreO));
patch([y1 -y1(end:-1:1)]+9 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.9)
plot([9 9],IQR,'k','linew',3)
plot(9,nanmean(InvTDrug(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(9,nanmedian(InvTDrug(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)

set(gca,'xlim',[-2.5 11.5],'xtick',[],'ylim',[0 6])
box off
title('InvT')

subplot(2,3,2)
[x,y1,~,IQR] = violinplotHK(PlayBiasPLS(indexLowScoreO));
patch([y1 -y1(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.5)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(PlayBiasPLS(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(PlayBiasPLS(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(PlayBiasDrug(indexLowScoreO));
patch([y1 -y1(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.5)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(PlayBiasDrug(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(PlayBiasDrug(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

%HP
[x,y1,~,IQR] = violinplotHK(PlayBiasPLS(indexHighScoreO));
patch([y1 -y1(end:-1:1)]+6, [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.9)
hold on
plot([6 6],IQR,'k','linew',3)
plot(6,nanmean(PlayBiasPLS(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(6,nanmedian(PlayBiasPLS(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(PlayBiasDrug(indexHighScoreO));
patch([y1 -y1(end:-1:1)]+9 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.9)
plot([9 9],IQR,'k','linew',3)
plot(9,nanmean(PlayBiasDrug(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(9,nanmedian(PlayBiasDrug(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)

set(gca,'xlim',[-2.5 11.5],'xtick',[],'ylim',[-1 1])
box off
title('Play bias')

subplot(2,3,3)
[x,y1,~,IQR] = violinplotHK(EtaPLS(indexLowScoreO));
patch([y1 -y1(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.5)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(EtaPLS(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(EtaPLS(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(EtaDrug(indexLowScoreO));
patch([y1 -y1(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.5)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(EtaDrug(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(EtaDrug(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

%HP
[x,y1,~,IQR] = violinplotHK(EtaPLS(indexHighScoreO));
patch([y1 -y1(end:-1:1)]+6 , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.9)
hold on
plot([6 6],IQR,'k','linew',3)
plot(6,nanmean(EtaPLS(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(6,nanmedian(EtaPLS(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(EtaDrug(indexHighScoreO));
patch([y1 -y1(end:-1:1)]+9 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.9)
plot([9 9],IQR,'k','linew',3)
plot(9,nanmean(EtaDrug(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(9,nanmedian(EtaDrug(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)


set(gca,'xlim',[-2.5 11.5],'xtick',[],'ylim',[0 1])
box off
title('Eta')

subplot(2,3,4)
[x,y1,~,IQR] = violinplotHK(LRIntcptPLS(indexLowScoreO));
patch([y1 -y1(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.5)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(LRIntcptPLS(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(LRIntcptPLS(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(LRIntcptDrug(indexLowScoreO));
patch([y1 -y1(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.5)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(LRIntcptDrug(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(LRIntcptDrug(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

% HP
[x,y1,~,IQR] = violinplotHK(LRIntcptPLS(indexHighScoreO));
patch([y1 -y1(end:-1:1)]+6 , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.9)
hold on
plot([6 6],IQR,'k','linew',3)
plot(6,nanmean(LRIntcptPLS(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(6,nanmedian(LRIntcptPLS(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(LRIntcptDrug(indexHighScoreO));
patch([y1 -y1(end:-1:1)]+9 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.9)
plot([9 9],IQR,'k','linew',3)
plot(9,nanmean(LRIntcptDrug(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(9,nanmedian(LRIntcptDrug(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)

set(gca,'xlim',[-2.5 11.5],'xtick',[],'ylim',[-30 10])
box off
title('LRIntcpt')

subplot(2,3,5)
[x,y1,~,IQR] = violinplotHK(LRFeedConfPLS(indexLowScoreO));
patch([y1 -y1(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.5)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(LRFeedConfPLS(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(LRFeedConfPLS(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(LRFeedConfDrug(indexLowScoreO));
patch([y1 -y1(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.5)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(LRFeedConfDrug(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(LRFeedConfDrug(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

%HP
[x,y1,~,IQR] = violinplotHK(LRFeedConfPLS(indexHighScoreO));
patch([y1 -y1(end:-1:1)]+6, [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.9)
hold on
plot([6 6],IQR,'k','linew',3)
plot(6,nanmean(LRFeedConfPLS(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(6,nanmedian(LRFeedConfPLS(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(LRFeedConfDrug(indexHighScoreO));
patch([y1 -y1(end:-1:1)]+9 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.9)
plot([9 9],IQR,'k','linew',3)
plot(9,nanmean(LRFeedConfDrug(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(9,nanmedian(LRFeedConfDrug(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)


set(gca,'xlim',[-2.5 11.5],'xtick',[],'ylim',[-10 30])
box off
title('LRFeedConf')

h = gcf;
h.Position = [-2441         202         833         661];
print2pdf(fullfile(pwd,'FIgures',['ParamComparison_split.pdf']),h,300)

%% plot all 
figure(1),clf;
subplot(2,3,1)
[x,y1,~,IQR] = violinplotHK(InvTPLS);
patch([y1 -y1(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.7)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(InvTPLS),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(InvTPLS),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(InvTDrug);
patch([y1 -y1(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.7)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(InvTDrug),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(InvTDrug),'ko','markerfacecolor','g','markersize',10)
set(gca,'xlim',[-2.5 5.5],'xtick',[],'ylim',[0 6])
box off
title('InvT')

subplot(2,3,2)
[x,y1,~,IQR] = violinplotHK(PlayBiasPLS);
patch([y1 -y1(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.7)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(PlayBiasPLS),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(PlayBiasPLS),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(PlayBiasDrug);
patch([y1 -y1(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.7)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(PlayBiasDrug),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(PlayBiasDrug),'ko','markerfacecolor','g','markersize',10)
set(gca,'xlim',[-2.5 5.5],'xtick',[],'ylim',[-1 1])
box off
title('Play bias')

subplot(2,3,3)
[x,y1,~,IQR] = violinplotHK(EtaPLS);
patch([y1 -y1(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.7)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(EtaPLS),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(EtaPLS),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(EtaDrug);
patch([y1 -y1(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.7)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(EtaDrug),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(EtaDrug),'ko','markerfacecolor','g','markersize',10)
set(gca,'xlim',[-2.5 5.5],'xtick',[],'ylim',[0 1])
box off
title('Eta')

subplot(2,3,4)
[x,y1,~,IQR] = violinplotHK(LRIntcptPLS);
patch([y1 -y1(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.7)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(LRIntcptPLS),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(LRIntcptPLS),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(LRIntcptDrug);
patch([y1 -y1(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.7)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(LRIntcptDrug),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(LRIntcptDrug),'ko','markerfacecolor','g','markersize',10)
set(gca,'xlim',[-2.5 5.5],'xtick',[],'ylim',[-30 10])
box off
title('LRIntcpt')

subplot(2,3,5)
[x,y1,~,IQR] = violinplotHK(LRFeedConfPLS);
patch([y1 -y1(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.7)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(LRFeedConfPLS),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(LRFeedConfPLS),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(LRFeedConfDrug);
patch([y1 -y1(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.7)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(LRFeedConfDrug),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(LRFeedConfDrug),'ko','markerfacecolor','g','markersize',10)
set(gca,'xlim',[-2.5 5.5],'xtick',[],'ylim',[-10 30])
box off
title('LRFeedConf')

h = gcf;
h.Position = [-2441         202         833         661];
print2pdf(fullfile(pwd,'FIgures',['ParamComparison.pdf']),h,300)



%% ploting
data =  EtaOS;
n = size(EtaDrug,1);

% get data distribution based on histogram
[y1,x] = histcounts(data,'BinMethod','fd');
x = (x(1:end-1)+x(2:end))/2';
y1 = y1./max(y1);


% inter-quartile range
dataR = tiedrank(data)./n;
IQR = data([dsearchn(dataR,.25) dsearchn(dataR,.75)]);

% show the violin plot

% first show the histogram
figure(1), clf
subplot(411)
histogram(data,30)
xlabel('Eta Orientation'), ylabel('Count')
box off

% main plot is a patch
subplot(4,1,2:4)
patch([y1 -y1(end:-1:1)] , [x x(end:-1:1)], 'b','facealpha',.5)
hold on

% plot other descriptive stats
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(data),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(data),'ko','markerfacecolor','g','markersize',10)

legend({'Distribution';'IQR';'Mean';'Median'},'box','off')
set(gca,'xlim',[-1 1]*5,'xtick',[],'ylim',[0 1])

%title('Violin plot')
ylabel('Eta Orientation')

h = gcf;
h.Position = [-2106         243         446         660];
print2pdf(fullfile(pwd,'FIgures',['EtaOrientation.pdf']),h,300)


%% plot LR differences 

EtaDiffernece = EtaPLS-EtaDrug;
[BigEtaDelta,BigEtaDeltaindex] = max(EtaDiffernece);

load('data/PLS_wGenPriors_Data_111110.mat')
LR_PL = dstruct(BigEtaDeltaindex).RL_LR;


%% 

clear
load('data/DrugS_wGenPrior_Data_111110.mat')
%load('data/PLS_wGenPriors_Data_111110.mat')
D = dstruct;

SymStage = [];
n = size(D,2);
for c =  1 : n
    US = D(c).SymStage'; If = 1; AllI = [];
    for c2 = 2 : length(US)
        if US(c2)<=US(c2-1) %end of stage
            if US(c2-1)>25
                
                AllI = [AllI If:c2-1];
            end
            If = c2;
        end
    end
    length(AllI);
    AllIAll(c) = {AllI};
    SymStage = [SymStage D(c).SymStage(AllI)'];
end
SymStage

% Change all fieldnames into equally size arrays
FN = fieldnames(D); FN(1) = [];
for c = 2 : length(FN)
    eval([FN{c} ' = [];'])
    for c2 = 1 : n
        eval([FN{c} ' = [' FN{c} ' D(c2).(FN{c})(AllIAll{c2})''];'])
    end
end


% PLS_choice       = choice;
% PLS_Prob         = Prob;
% PLS_ChoiceProb   = ChoiceProb;
% PLS_LR           = RL_LR;
% save('data/PLS_BehavSum.mat',"PLS_LR","PLS_ChoiceProb","PLS_Prob","PLS_choice")


DrugS_choice       = choice;
DrugS_Prob         = Prob;
DrugS_ChoiceProb   = ChoiceProb;
DrugS_LR           = RL_LR;
DrugS_Stimno       = Stimno;
DrugS_ProbChange   = ProbChange;
DrugS_EV           = EV;
DrugS_RPE          = RPE;

save('data/DrugS_BehavSum.mat',"DrugS_LR","DrugS_ChoiceProb","DrugS_Prob","DrugS_choice","DrugS_Stimno","DrugS_ProbChange","DrugS_EV","DrugS_RPE")

%%
%% exclusion of subjects
clear
load('data/DrugS_BehavSum.mat')
load('data/PLS_BehavSum.mat')

load('data/InfoSubjects.mat')
load('data/all_EndPOints_Orientation.mat')


% Orientation
excluda_O                           = [26,79,86];
excluda_expSession                  = [30,60,90,97];
ID(excluda_expSession)              = [];

PLS_choice(:,excluda_expSession)          = [];
PLS_Prob(:,excluda_expSession)            = [];
PLS_ChoiceProb(:,excluda_expSession)      = [];
PLS_LR(:,excluda_expSession)              = [];
PLS_Stimno(:,excluda_expSession)          = [];
PLS_ProbChange(:,excluda_expSession)      = [];
PLS_EV(:,excluda_expSession)              = [];
PLS_RPE(:,excluda_expSession)             = [];

DrugS_choice(:,excluda_expSession)          = [];
DrugS_Prob(:,excluda_expSession)            = [];
DrugS_ChoiceProb(:,excluda_expSession)      = [];
DrugS_LR(:,excluda_expSession)              = [];
DrugS_Stimno(:,excluda_expSession)          = [];
DrugS_ProbChange(:,excluda_expSession)      = [];
DrugS_EV(:,excluda_expSession)              = [];
DrugS_RPE(:,excluda_expSession)             = [];

Shortname(excluda_O)            = [];
EndPOints_O(excluda_O)          = [];


LIA                             = ismember(ID,Shortname,'rows');
indexExclude_missingO           = find(LIA==0)';


PLS_choice(:,indexExclude_missingO)          = [];
PLS_Prob(:,indexExclude_missingO)            = [];
PLS_ChoiceProb(:,indexExclude_missingO)      = [];
PLS_LR(:,indexExclude_missingO)              = [];
PLS_Stimno(:,indexExclude_missingO)          = [];
PLS_ProbChange(:,indexExclude_missingO)      = [];
PLS_EV(:,indexExclude_missingO)              = [];
PLS_RPE(:,indexExclude_missingO)             = [];

DrugS_choice(:,indexExclude_missingO)          = [];
DrugS_Prob(:,indexExclude_missingO)            = [];
DrugS_ChoiceProb(:,indexExclude_missingO)      = [];
DrugS_LR(:,indexExclude_missingO)              = [];
DrugS_Stimno(:,indexExclude_missingO)          = [];
DrugS_ProbChange(:,indexExclude_missingO)      = [];
DrugS_EV(:,indexExclude_missingO)              = [];
DrugS_RPE(:,indexExclude_missingO)             = [];

split = median(EndPOints_O);

indexLowScoreO  = find(EndPOints_O<=split);
indexHighScoreO = find(EndPOints_O>split);


ProbTask = DrugS_Prob(:,1);

ProbTask(ProbTask==20) = -.8;
ProbTask(ProbTask==30) = -.7;
ProbTask(ProbTask==50) = 0;
ProbTask(ProbTask==70) = .7;
ProbTask(ProbTask==80) = .8;

figure(3);clf;
subplot(4,1,1)
shadedErrBar([], AGF_running_average(mean(DrugS_choice(:,indexLowScoreO),2),1,1), AGF_running_average(se(DrugS_choice(:,indexLowScoreO)',0.99),1,1),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 2, 'lineWidth', 1}); hold on;
%plot(AGF_running_average(mean(DrugS_ChoiceProb(:,indexLowScoreO),2),1,1),'linewidth',3,'Color','m');
shadedErrBar([], AGF_running_average(mean(PLS_choice(:,indexLowScoreO),2),1,1), AGF_running_average(se(PLS_choice(:,indexLowScoreO)',0.99),1,1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 2, 'lineWidth', 1}); hold on;
%plot(AGF_running_average(mean(PLS_ChoiceProb(:,indexLowScoreO),2),1,1),'linewidth',3,'Color','g');
plot(mean(DrugS_Prob,2)/100,'LineWidth',2,'Color','k')
xlim([1 length(DrugS_choice)])
set(gca,'xtick',[])
legend({'MPH' 'PL'},'FontSize',14);
set(0,'DefaultLegendAutoUpdate','off')
ylabel('P(choice)','FontSize',14, 'FontWeight', 'bold')
gridxy(find([DrugS_ProbChange(:,1)==1]))
gridxy([find(DrugS_Stimno(:,1) == 2, 1 ) find(DrugS_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');
title({'Probability to select'})

subplot(4,1,2)
shadedErrBar([], AGF_running_average(mean(DrugS_RPE(:,indexLowScoreO),2),1,1), AGF_running_average(se(DrugS_RPE(:,indexLowScoreO)',0.99),1,1),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 2, 'lineWidth', 1}); hold on;
shadedErrBar([], AGF_running_average(mean(PLS_RPE(:,indexLowScoreO),2),1,1), AGF_running_average(se(PLS_RPE(:,indexLowScoreO)',0.99),1,1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 2, 'lineWidth', 1}); hold on;
xlim([1 length(DrugS_choice)])
%plot(mean(PLS_Prob,2)/100,'LineWidth',2,'Color','k')
legend({'MPH' 'PL'},'FontSize',14)
set(0,'DefaultLegendAutoUpdate','off')
ylabel('RPE','FontSize',14, 'FontWeight', 'bold')
gridxy(find([DrugS_ProbChange(:,1)==1]))
gridxy([find(DrugS_Stimno(:,1) == 2, 1 ) find(DrugS_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');
title({'RPE'})

subplot(4,1,3)
shadedErrBar([], AGF_running_average(mean(DrugS_LR(:,indexLowScoreO),2),2,2), AGF_running_average(se(DrugS_LR(:,indexLowScoreO)',0.99),2,2),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 2, 'lineWidth', 1}); hold on;
shadedErrBar([], AGF_running_average(mean(PLS_LR(:,indexLowScoreO),2),2,2), AGF_running_average(se(PLS_LR(:,indexLowScoreO)',0.99),2,2),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 2, 'lineWidth', 1});
plot(mean(DrugS_Prob,2)/100,'LineWidth',2,'Color','k')
xlim([1 length(DrugS_choice)])
ylim([0 1])
set(gca,'xtick',[])
legend({'MPH' 'PL'},'FontSize',14)
set(0,'DefaultLegendAutoUpdate','off')
ylabel('LR','FontSize',14, 'FontWeight', 'bold')
gridxy(find([DrugS_ProbChange(:,1)==1]))
gridxy([find(DrugS_Stimno(:,1) == 2, 1 ) find(DrugS_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');
title({'Learning rate'})

subplot(4,1,4)
shadedErrBar([], AGF_running_average(mean(DrugS_EV(:,indexLowScoreO),2),2,2), AGF_running_average(se(DrugS_EV(:,indexLowScoreO)',0.99),2,2),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 2, 'lineWidth', 1}); hold on;
shadedErrBar([], AGF_running_average(mean(PLS_EV(:,indexLowScoreO),2),2,2), AGF_running_average(se(PLS_EV(:,indexLowScoreO)',0.99),2,2),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 2, 'lineWidth', 1});
plot(ProbTask,'LineWidth',2,'Color','k')
xlim([1 length(DrugS_choice)])
ylim([-1 1])
set(gca,'xtick',[])
legend({'MPH' 'PL'},'FontSize',14)
title({'Expected Value'})
set(0,'DefaultLegendAutoUpdate','off')
ylabel('EV','FontSize',14, 'FontWeight', 'bold')
gridxy(find([DrugS_ProbChange(:,1)==1]))
gridxy([find(DrugS_Stimno(:,1) == 2, 1 ) find(DrugS_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');

h=gcf;
h.Position=[-2362        -155        2363        1166];
print2pdf(fullfile(pwd,'FIgures',['ModelBehavior_lowOrientationPerformance.pdf']),h,300)

%%
figure(3);clf;
subplot(4,1,1)
shadedErrBar([], AGF_running_average(mean(DrugS_choice(:,indexHighScoreO),2),1,1), AGF_running_average(se(DrugS_choice(:,indexHighScoreO)',0.99),1,1),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 2, 'lineWidth', 1}); hold on;
%plot(AGF_running_average(mean(DrugS_ChoiceProb(:,indexLowScoreO),2),1,1),'linewidth',3,'Color','m');
shadedErrBar([], AGF_running_average(mean(PLS_choice(:,indexHighScoreO),2),1,1), AGF_running_average(se(PLS_choice(:,indexHighScoreO)',0.99),1,1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 2, 'lineWidth', 1}); hold on;
%plot(AGF_running_average(mean(PLS_ChoiceProb(:,indexLowScoreO),2),1,1),'linewidth',3,'Color','g');
plot(mean(DrugS_Prob,2)/100,'LineWidth',2,'Color','k')
xlim([1 length(DrugS_choice)])
set(gca,'xtick',[])
legend({'MPH' 'PL'},'FontSize',14);
set(0,'DefaultLegendAutoUpdate','off')
ylabel('P(choice)','FontSize',14, 'FontWeight', 'bold')
gridxy(find([DrugS_ProbChange(:,1)==1]))
gridxy([find(DrugS_Stimno(:,1) == 2, 1 ) find(DrugS_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');
title({'Probability to select'})

subplot(4,1,2)
shadedErrBar([], AGF_running_average(mean(DrugS_RPE(:,indexHighScoreO),2),1,1), AGF_running_average(se(DrugS_RPE(:,indexHighScoreO)',0.99),1,1),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 2, 'lineWidth', 1}); hold on;
shadedErrBar([], AGF_running_average(mean(PLS_RPE(:,indexHighScoreO),2),1,1), AGF_running_average(se(PLS_RPE(:,indexHighScoreO)',0.99),1,1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 2, 'lineWidth', 1}); hold on;
xlim([1 length(DrugS_choice)])
%plot(mean(PLS_Prob,2)/100,'LineWidth',2,'Color','k')
legend({'MPH' 'PL'},'FontSize',14)
set(0,'DefaultLegendAutoUpdate','off')
ylabel('RPE','FontSize',14, 'FontWeight', 'bold')
gridxy(find([DrugS_ProbChange(:,1)==1]))
gridxy([find(DrugS_Stimno(:,1) == 2, 1 ) find(DrugS_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');
title({'RPE'})

subplot(4,1,3)
shadedErrBar([], AGF_running_average(mean(DrugS_LR(:,indexHighScoreO),2),2,2), AGF_running_average(se(DrugS_LR(:,indexHighScoreO)',0.99),2,2),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 2, 'lineWidth', 1}); hold on;
shadedErrBar([], AGF_running_average(mean(PLS_LR(:,indexHighScoreO),2),2,2), AGF_running_average(se(PLS_LR(:,indexHighScoreO)',0.99),2,2),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 2, 'lineWidth', 1});
plot(mean(DrugS_Prob,2)/100,'LineWidth',2,'Color','k')
xlim([1 length(DrugS_choice)])
ylim([0 1])
set(gca,'xtick',[])
legend({'MPH' 'PL'},'FontSize',14)
set(0,'DefaultLegendAutoUpdate','off')
ylabel('LR','FontSize',14, 'FontWeight', 'bold')
gridxy(find([DrugS_ProbChange(:,1)==1]))
gridxy([find(DrugS_Stimno(:,1) == 2, 1 ) find(DrugS_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');
title({'Learning rate'})

subplot(4,1,4)
shadedErrBar([], AGF_running_average(mean(DrugS_EV(:,indexHighScoreO),2),2,2), AGF_running_average(se(DrugS_EV(:,indexHighScoreO)',0.99),2,2),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 2, 'lineWidth', 1}); hold on;
shadedErrBar([], AGF_running_average(mean(PLS_EV(:,indexHighScoreO),2),2,2), AGF_running_average(se(PLS_EV(:,indexHighScoreO)',0.99),2,2),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 2, 'lineWidth', 1});
plot(ProbTask,'LineWidth',2,'Color','k')
xlim([1 length(DrugS_choice)])
ylim([-1 1])
set(gca,'xtick',[])
legend({'MPH' 'PL'},'FontSize',14)
title({'Expected Value'})
set(0,'DefaultLegendAutoUpdate','off')
ylabel('EV','FontSize',14, 'FontWeight', 'bold')
gridxy(find([DrugS_ProbChange(:,1)==1]))
gridxy([find(DrugS_Stimno(:,1) == 2, 1 ) find(DrugS_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');

h=gcf;
h.Position=[-2362        -155        2363        1166];
print2pdf(fullfile(pwd,'FIgures',['ModelBehavior_HighOrientationPerformance.pdf']),h,300)

%%
figure(3);clf;
subplot(4,1,1)
shadedErrBar([], AGF_running_average(mean(DrugS_choice,2),1,1), AGF_running_average(se(DrugS_choice',0.99),1,1),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 2, 'lineWidth', 1}); hold on;
%plot(AGF_running_average(mean(DrugS_ChoiceProb(:,indexLowScoreO),2),1,1),'linewidth',3,'Color','m');
shadedErrBar([], AGF_running_average(mean(PLS_choice,2),1,1), AGF_running_average(se(PLS_choice',0.99),1,1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 2, 'lineWidth', 1}); hold on;
%plot(AGF_running_average(mean(PLS_ChoiceProb(:,indexLowScoreO),2),1,1),'linewidth',3,'Color','g');
plot(mean(DrugS_Prob,2)/100,'LineWidth',2,'Color','k')
xlim([1 length(DrugS_choice)])
set(gca,'xtick',[])
legend({'MPH' 'PL'},'FontSize',14);
set(0,'DefaultLegendAutoUpdate','off')
ylabel('P(choice)','FontSize',14, 'FontWeight', 'bold')
gridxy(find([DrugS_ProbChange(:,1)==1]))
gridxy([find(DrugS_Stimno(:,1) == 2, 1 ) find(DrugS_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');
title({'Probability to select'})

subplot(4,1,2)
shadedErrBar([], AGF_running_average(mean(DrugS_RPE,2),1,1), AGF_running_average(se(DrugS_RPE',0.99),1,1),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 2, 'lineWidth', 1}); hold on;
shadedErrBar([], AGF_running_average(mean(PLS_RPE,2),1,1), AGF_running_average(se(PLS_RPE',0.99),1,1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 2, 'lineWidth', 1}); hold on;
xlim([1 length(DrugS_choice)])
%plot(mean(PLS_Prob,2)/100,'LineWidth',2,'Color','k')
legend({'MPH' 'PL'},'FontSize',14)
set(0,'DefaultLegendAutoUpdate','off')
ylabel('RPE','FontSize',14, 'FontWeight', 'bold')
gridxy(find([DrugS_ProbChange(:,1)==1]))
gridxy([find(DrugS_Stimno(:,1) == 2, 1 ) find(DrugS_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');
title({'RPE'})

subplot(4,1,3)
shadedErrBar([], AGF_running_average(mean(DrugS_LR,2),2,2), AGF_running_average(se(DrugS_LR',0.99),2,2),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 2, 'lineWidth', 1}); hold on;
shadedErrBar([], AGF_running_average(mean(PLS_LR,2),2,2), AGF_running_average(se(PLS_LR',0.99),2,2),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 2, 'lineWidth', 1});
plot(mean(DrugS_Prob,2)/100,'LineWidth',2,'Color','k')
xlim([1 length(DrugS_choice)])
ylim([0 1])
set(gca,'xtick',[])
legend({'MPH' 'PL'},'FontSize',14)
set(0,'DefaultLegendAutoUpdate','off')
ylabel('LR','FontSize',14, 'FontWeight', 'bold')
gridxy(find([DrugS_ProbChange(:,1)==1]))
gridxy([find(DrugS_Stimno(:,1) == 2, 1 ) find(DrugS_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');
title({'Learning rate'})

subplot(4,1,4)
shadedErrBar([], AGF_running_average(mean(DrugS_EV,2),2,2), AGF_running_average(se(DrugS_EV',0.99),2,2),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 2, 'lineWidth', 1}); hold on;
shadedErrBar([], AGF_running_average(mean(PLS_EV,2),2,2), AGF_running_average(se(PLS_EV',0.99),2,2),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 2, 'lineWidth', 1});
plot(ProbTask,'LineWidth',2,'Color','k')
xlim([1 length(DrugS_choice)])
ylim([-1 1])
set(gca,'xtick',[])
legend({'MPH' 'PL'},'FontSize',14)
title({'Expected Value'})
set(0,'DefaultLegendAutoUpdate','off')
ylabel('EV','FontSize',14, 'FontWeight', 'bold')
gridxy(find([DrugS_ProbChange(:,1)==1]))
gridxy([find(DrugS_Stimno(:,1) == 2, 1 ) find(DrugS_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');

h=gcf;
h.Position=[-2362        -155        2363        1166];
print2pdf(fullfile(pwd,'FIgures',['ModelBehavior_all.pdf']),h,300)




%% Make the first plot and look at the data
clear
load('data/DrugS_BehavSum.mat')
load('data/PLS_BehavSum.mat')
load('data/O_BehavSum.mat')



figure(3);clf;
subplot(4,1,1)
shadedErrBar([], AGF_running_average(mean(DrugS_choice,2),2,2), AGF_running_average(se(DrugS_choice',0.99),2,2),'m'); hold on;
plot(AGF_running_average(mean(DrugS_ChoiceProb,2),2,2),'linewidth',3,'Color','m');
plot(mean(DrugS_Prob,2)/100,'LineWidth',2,'Color','k')
xlim([1 length(DrugS_choice)])
set(gca,'xtick',[])
legend({'choice' 'GT' 'CP'},'FontSize',14);
set(0,'DefaultLegendAutoUpdate','off')
ylabel('P(choice)','FontSize',14, 'FontWeight', 'bold')
gridxy(find([DrugS_ProbChange(:,1)==1]))
gridxy([find(DrugS_Stimno(:,1) == 2, 1 ) find(DrugS_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');
title({'Drug Session'})

subplot(4,1,2)
shadedErrBar([], AGF_running_average(mean(PLS_choice,2),2,2), AGF_running_average(se(PLS_choice',0.99),2,2),'g');hold on;
plot(AGF_running_average(mean(PLS_ChoiceProb,2),2,2),'linewidth',3,'Color','g');
plot(mean(PLS_Prob,2)/100,'LineWidth',2,'Color','k')
legend({'choice' 'GT' 'CP'},'FontSize',14);
set(0,'DefaultLegendAutoUpdate','off')
ylabel('P(choice)','FontSize',14, 'FontWeight', 'bold')
gridxy(find([DrugS_ProbChange(:,1)==1]))
gridxy([find(DrugS_Stimno(:,1) == 2, 1 ) find(DrugS_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');
title({'PL Session'})

subplot(4,1,3)
shadedErrBar([], AGF_running_average(mean(DrugS_LR,2),2,2), AGF_running_average(se(DrugS_LR',0.99),2,2),'m'); hold on;
shadedErrBar([], AGF_running_average(mean(PLS_LR,2),2,2), AGF_running_average(se(PLS_LR',0.99),2,2),'g');
plot(mean(DrugS_Prob,2)/100,'LineWidth',2,'Color','k')
xlim([1 length(DrugS_choice)])
ylim([0 1])
set(gca,'xtick',[])
legend({'Drug' 'PL'},'FontSize',14);
set(0,'DefaultLegendAutoUpdate','off')
ylabel('LR','FontSize',14, 'FontWeight', 'bold')
gridxy(find([DrugS_ProbChange(:,1)==1]))
gridxy([find(DrugS_Stimno(:,1) == 2, 1 ) find(DrugS_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');


subplot(4,1,4)
plot(DrugS_LR(:,54),'m',LineWidth=2); hold on;
plot(PLS_LR(:,54),'g',LineWidth=2);
plot(mean(DrugS_Prob,2)/100,'LineWidth',2,'Color','k')
xlim([1 length(DrugS_choice)])
ylim([0 1])
set(gca,'xtick',[])
legend({'Drug' 'PL'},'FontSize',14);
set(0,'DefaultLegendAutoUpdate','off')
ylabel('LR','FontSize',14, 'FontWeight', 'bold')
gridxy(find([DrugS_ProbChange(:,1)==1]))
gridxy([find(DrugS_Stimno(:,1) == 2, 1 ) find(DrugS_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');

set(gca,'FontSize',15);
h=gcf;
h.Position=[-2318          95        2014         807];
print2pdf(fullfile(pwd,'FIgures',['ChoiceBehaviour_LR_All.pdf']),h,300)



%%

figure(4);clf;
subplot(3,1,1)
shadedErrBar([], AGF_running_average(mean(O_choice,2),2,2), AGF_running_average(se(O_choice',0.99),2,2),'k');hold on;
plot(AGF_running_average(mean(O_ChoiceProb,2),2,2),'linewidth',3,'Color','k');
plot(mean(PLS_Prob,2)/100,'LineWidth',2,'Color','k')
legend({'choice' 'GT' 'CP'},'FontSize',14);
set(0,'DefaultLegendAutoUpdate','off')
ylabel('P(choice)','FontSize',14, 'FontWeight', 'bold')
gridxy(find([DrugS_ProbChange(:,1)==1]))
gridxy([find(DrugS_Stimno(:,1) == 2, 1 ) find(DrugS_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');
title({'Orientation Session'})

subplot(3,1,2)
shadedErrBar([], AGF_running_average(mean(DrugS_choice,2),2,2), AGF_running_average(se(DrugS_choice',0.99),2,2),'m'); hold on;
plot(AGF_running_average(mean(DrugS_ChoiceProb,2),2,2),'linewidth',3,'Color','m');
plot(mean(DrugS_Prob,2)/100,'LineWidth',2,'Color','k')
xlim([1 length(DrugS_choice)])
set(gca,'xtick',[])
legend({'choice' 'GT' 'CP'},'FontSize',14);
set(0,'DefaultLegendAutoUpdate','off')
ylabel('P(choice)','FontSize',14, 'FontWeight', 'bold')
gridxy(find([DrugS_ProbChange(:,1)==1]))
gridxy([find(DrugS_Stimno(:,1) == 2, 1 ) find(DrugS_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');
title({'MPH Session'})

subplot(3,1,3)
shadedErrBar([], AGF_running_average(mean(PLS_choice,2),2,2), AGF_running_average(se(PLS_choice',0.99),2,2),'g');hold on;
plot(AGF_running_average(mean(PLS_ChoiceProb,2),2,2),'linewidth',3,'Color','g');
plot(mean(PLS_Prob,2)/100,'LineWidth',2,'Color','k')
legend({'choice' 'GT' 'CP'},'FontSize',14);
set(0,'DefaultLegendAutoUpdate','off')
ylabel('P(choice)','FontSize',14, 'FontWeight', 'bold')
gridxy(find([DrugS_ProbChange(:,1)==1]))
gridxy([find(DrugS_Stimno(:,1) == 2, 1 ) find(DrugS_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');
title({'PL Session'})
h=gcf;
h.Position=[-2348         153        2002         787];
print2pdf(fullfile(pwd,'FIgures',['ChoiceBehaviour_AllSessions.pdf']),h,300)

%% 

load('data/RawInfoOrientationSession.mat')

load('Data/InfoStuff.mat')

[LIA,LOCB] = ismember(ID,RawInfoOrientationSession.Shortname,'rows');
indexID    = find(LIA==1);

InvT_O            = nan(113,1);
InvT_O(indexID)   = InvTOS;
InvT_PL           = InvTPLS;
InvT_D            = InvTDrug;

PlayBias_O            = nan(113,1);
PlayBias_O(indexID)   = PlayBiasOS;
PlayBias_PL           = PlayBiasPLS;
PlayBias_D            = PlayBiasDrug;

Eta_O            = nan(113,1);
Eta_O(indexID)   = EtaOS;
Eta_PL           = EtaPLS;
Eta_D            = EtaDrug;

LRIntcpt_O            = nan(113,1);
LRIntcpt_O(indexID)   = LRIntcptOS;
LRIntcpt_PL           = LRIntcptPLS;
LRIntcpt_D            = LRIntcptDrug;

LRFeedConf_O            = nan(113,1);
LRFeedConf_O(indexID)   = LRFeedConfOS;
LRFeedConf_PL           = LRFeedConfPLS;
LRFeedConf_D            = LRFeedConfDrug;

EXL = table(ID,Session1,Session2,InvT_O,InvT_PL,InvT_D,...
    PlayBias_O, PlayBias_PL, PlayBias_D,...
    Eta_O, Eta_PL, Eta_D,...
    LRIntcpt_O,LRIntcpt_PL,LRIntcpt_D,...
    LRFeedConf_O,LRFeedConf_PL,LRFeedConf_D);

writetable(EXL, 'data/REFIT_Chicago_ModelParams.xlsx')


