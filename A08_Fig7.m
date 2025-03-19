clear
rootDir = pwd;

load('Data/MA_wGenPrior_Data_111110.mat')
load('Data/fminconResults/MA_wGenPrior_fminconResult_111110.mat')

InvTDrug        = fminconResult.fitParams(:,1);
PlayBiasDrug    = fminconResult.fitParams(:,2);
EtaDrug         = fminconResult.fitParams(:,3);
LRIntcptDrug    = fminconResult.fitParams(:,4);
LRFeedConfDrug  = fminconResult.fitParams(:,5);


load('Data/PL_wGenPriors_Data_111110.mat')
load('Data/fminconResults/PL_wGenPriors_fminconResult_111110.mat')
InvTPLS        = fminconResult.fitParams(:,1);
PlayBiasPLS    = fminconResult.fitParams(:,2);
EtaPLS         = fminconResult.fitParams(:,3);
LRIntcptPLS    = fminconResult.fitParams(:,4);
LRFeedConfPLS  = fminconResult.fitParams(:,5);

load('Data/fminconResults/fminconResult_wPrior_111110.mat')
InvTOS        = fminconResult.fitParams(:,1);
PlayBiasOS    = fminconResult.fitParams(:,2);
EtaOS         = fminconResult.fitParams(:,3);
LRIntcptOS    = fminconResult.fitParams(:,4);
LRFeedConfOS  = fminconResult.fitParams(:,5);

load('Data/RawInfoMA_V2.mat')
load('Data/RawInfoPL_V2.mat')

load('Data/all_EndPOints_PL.mat')
load('Data/all_EndPOints_MA.mat')

%% exclusion of subjects 
% (exclusion criteria: no participantion in the 
% orientation session and high proportion of misses (see data extraction 
% scripts in the data folder))

load('Data/InfoSubjects.mat')
load('Data/SessionInfo.mat')
load('Data/all_EndPOints_Orientation.mat')

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
title('r = -.29, p < 0.001')
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
print2pdf(fullfile(pwd,'Figures',['Fig7.pdf']),h,300)
