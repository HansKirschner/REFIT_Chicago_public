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

OrientationDone                = ismember(ID,Shortname,'rows');

SessionIndex_MPH1st_1  = find(Session1==1);
SessionIndex_MPH1st_2  = SessionIndex_MPH1st_1+109;

SessionIndex_PLA1st_1  = find(Session1==0);
SessionIndex_PLA1st_2  = SessionIndex_PLA1st_1+109;

%%
ttestout(InvTDrug,InvTPLS,1);
ttestout(PlayBiasDrug,PlayBiasPLS,1);
ttestout(EtaDrug,EtaPLS,1);
ttestout(LRIntcptDrug,LRIntcptPLS,1);
ttestout(LRFeedConfDrug,LRFeedConfPLS,1);


group = repmat("Gr_A",109,1);
group(Session1==1) = "Gr_B";    

% ANOVA eta
t_DrugEffect_eta = table(group,EtaPLS,EtaDrug,...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_eta,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);

ranovatbl_Eta = ranova(rm,'WithinModel','TimePoints'); 

% Control 1
t_DrugEffect_eta_SC1 = table(OrientationDone,EtaPLS,EtaDrug,...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_eta_SC1,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);

ranovatbl_Eta_SC1 = ranova(rm,'WithinModel','TimePoints'); 


% Control 2
OrientationGroup = repmat("Gr_A",109,1);
OrientationGroup(OrientationDone==1) = "Gr_B"; 

t_DrugEffect_eta_SC2 = table(group,OrientationGroup,EtaPLS,EtaDrug,...
    'VariableNames',{'Group','Session','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_eta_SC2,'PointsSession1-PointsSession2 ~ Group:Session','WithinDesign',Session);

ranovatbl_Eta_SC2 = ranova(rm,'WithinModel','TimePoints'); 


% P correct choice
ttestout(RawInfoPLSession.CorrChoice_earlyLearning_HighProb,RawInfoDrugSession.CorrChoice_earlyLearning_HighProb,1);
ttestout(RawInfoPLSession.CorrChoice_lateLearning_HighProb,RawInfoDrugSession.CorrChoice_lateLearning_HighProb,1);

ttestout(RawInfoPLSession.CorrChoice_earlyLearning_LowProb,RawInfoDrugSession.CorrChoice_earlyLearning_LowProb,1);
ttestout(RawInfoPLSession.CorrChoice_lateLearning_LowProb,RawInfoDrugSession.CorrChoice_lateLearning_LowProb,1);

ttestout(RawInfoPLSession.CorrChoice_earlyLearning_HighProb(indexLowScoreO),RawInfoDrugSession.CorrChoice_earlyLearning_HighProb(indexLowScoreO),1);
ttestout(RawInfoPLSession.CorrChoice_lateLearning_HighProb(indexLowScoreO),RawInfoDrugSession.CorrChoice_lateLearning_HighProb(indexLowScoreO),1);

ttestout(RawInfoPLSession.CorrChoice_earlyLearning_LowProb(indexLowScoreO),RawInfoDrugSession.CorrChoice_earlyLearning_LowProb(indexLowScoreO),1);
ttestout(RawInfoPLSession.CorrChoice_lateLearning_LowProb(indexLowScoreO),RawInfoDrugSession.CorrChoice_lateLearning_LowProb(indexLowScoreO),1);


% correct choices after misleading FB
ttestout(RawInfoPLSession.AccAfterMisleadingFB_earlyLearing_LowProb,RawInfoDrugSession.AccAfterMisleadingFB_earlyLearing_LowProb,1);


% ANOVA ACC a MF
t_DrugEffect_ACC_MF = table(group,RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb,RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb,...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_ACC_MF,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);

ranovatbl__ACC_MF = ranova(rm,'WithinModel','TimePoints'); 


t_DrugEffect_ACC_MF_SC = table(group,OrientationGroup,RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb,RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb,...
    'VariableNames',{'Group','Session','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_ACC_MF_SC,'PointsSession1-PointsSession2 ~ Group:Session','WithinDesign',Session);

ranovatbl__ACC_MF_SC = ranova(rm,'WithinModel','TimePoints'); 


% SD LR
ttestout(RawInfoPLSession.SD_LR_earlyLearning_all,RawInfoDrugSession.SD_LR_earlyLearning_all,1);
ttestout(RawInfoPLSession.SD_LR_lateLearning_all,RawInfoDrugSession.SD_LR_lateLearning_all,1);

ttestout(RawInfoPLSession.SD_LR_earlyLearning_HighProb,RawInfoDrugSession.SD_LR_earlyLearning_HighProb,1);
ttestout(RawInfoPLSession.SD_LR_lateLearning_HighProb,RawInfoDrugSession.SD_LR_lateLearning_HighProb,1);

ttestout(RawInfoPLSession.SD_LR_earlyLearning_LowProb,RawInfoDrugSession.SD_LR_earlyLearning_LowProb,1);
ttestout(RawInfoPLSession.SD_LR_lateLearning_LowProb,RawInfoDrugSession.SD_LR_lateLearning_LowProb,1);


% ANOVA SD LR all
t_DrugEffect_LR_all = table(group,RawInfoPLSession.SD_LR_earlyLearning_all,RawInfoDrugSession.SD_LR_earlyLearning_all,...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_LR_all ,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);

ranovatbl_LR_all = ranova(rm,'WithinModel','TimePoints'); 

ttestout(RawInfoPLSession.SD_LR_earlyLearning_all(indexLowScoreO),RawInfoDrugSession.SD_LR_earlyLearning_all(indexLowScoreO),1);
ttestout(RawInfoPLSession.SD_LR_lateLearning_all(indexLowScoreO),RawInfoDrugSession.SD_LR_lateLearning_all(indexLowScoreO),1);

ttestout(RawInfoPLSession.SD_LR_earlyLearning_all(indexHighScoreO),RawInfoDrugSession.SD_LR_earlyLearning_all(indexHighScoreO),1);
ttestout(RawInfoPLSession.SD_LR_lateLearning_all(indexHighScoreO),RawInfoDrugSession.SD_LR_lateLearning_all(indexHighScoreO),1);

t_DrugEffect_LR_all_SC = table(group,OrientationGroup,RawInfoPLSession.SD_LR_earlyLearning_all,RawInfoDrugSession.SD_LR_earlyLearning_all,...
    'VariableNames',{'Group','Session','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_LR_all_SC ,'PointsSession1-PointsSession2 ~ Group:Session','WithinDesign',Session);

ranovatbl_LR_all_SC = ranova(rm,'WithinModel','TimePoints'); 


% ANOVA SD LR high prob
t_DrugEffect_LR_HighProb = table(group,RawInfoPLSession.SD_LR_earlyLearning_HighProb,RawInfoDrugSession.SD_LR_earlyLearning_HighProb,...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_LR_HighProb ,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);

ranovatbl_LR_HighProb = ranova(rm,'WithinModel','TimePoints'); 

ttestout(RawInfoPLSession.SD_LR_earlyLearning_HighProb(indexLowScoreO),RawInfoDrugSession.SD_LR_earlyLearning_HighProb(indexLowScoreO),1);
ttestout(RawInfoPLSession.SD_LR_lateLearning_HighProb(indexLowScoreO),RawInfoDrugSession.SD_LR_lateLearning_HighProb(indexLowScoreO),1);

ttestout(RawInfoPLSession.SD_LR_earlyLearning_HighProb(indexHighScoreO),RawInfoDrugSession.SD_LR_earlyLearning_HighProb(indexHighScoreO),1);
ttestout(RawInfoPLSession.SD_LR_lateLearning_HighProb(indexHighScoreO),RawInfoDrugSession.SD_LR_lateLearning_HighProb(indexHighScoreO),1);

t_DrugEffect_LR_HighProb_SC = table(group,OrientationGroup,RawInfoPLSession.SD_LR_earlyLearning_HighProb,RawInfoDrugSession.SD_LR_earlyLearning_HighProb,...
    'VariableNames',{'Group','Session','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_LR_HighProb_SC ,'PointsSession1-PointsSession2 ~ Group:Session','WithinDesign',Session);

ranovatbl_LR_HighProb_SC = ranova(rm,'WithinModel','TimePoints'); 

% ANOVA SD LR low prob
t_DrugEffect_LR_LowProb = table(group,RawInfoPLSession.SD_LR_earlyLearning_LowProb,RawInfoDrugSession.SD_LR_earlyLearning_LowProb,...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_LR_LowProb ,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);

ranovatbl_LR_LowProb = ranova(rm,'WithinModel','TimePoints');

ttestout(RawInfoPLSession.SD_LR_earlyLearning_LowProb(indexLowScoreO),RawInfoDrugSession.SD_LR_earlyLearning_LowProb(indexLowScoreO),1);
ttestout(RawInfoPLSession.SD_LR_lateLearning_LowProb(indexLowScoreO),RawInfoDrugSession.SD_LR_lateLearning_LowProb(indexLowScoreO),1);

ttestout(RawInfoPLSession.SD_LR_earlyLearning_LowProb(indexHighScoreO),RawInfoDrugSession.SD_LR_earlyLearning_LowProb(indexHighScoreO),1);
ttestout(RawInfoPLSession.SD_LR_lateLearning_LowProb(indexHighScoreO),RawInfoDrugSession.SD_LR_lateLearning_LowProb(indexHighScoreO),1);

t_DrugEffect_LR_LowProb_SC = table(group,OrientationGroup,RawInfoPLSession.SD_LR_earlyLearning_LowProb,RawInfoDrugSession.SD_LR_earlyLearning_LowProb,...
    'VariableNames',{'Group','Session','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_LR_LowProb_SC ,'PointsSession1-PointsSession2 ~ Group:Session','WithinDesign',Session);

ranovatbl_LR_LowProb_SC = ranova(rm,'WithinModel','TimePoints');

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
print2pdf(fullfile(pwd,'FIgures',['ParamComparison_fullSample.pdf']),h,300)


