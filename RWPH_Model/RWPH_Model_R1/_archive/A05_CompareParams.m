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

EtaOS(excluda_O)                    = [];

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

%%
ttestout(InvTDrug,InvTPLS,1);
ttestout(PlayBiasDrug,PlayBiasPLS,1);
ttestout(EtaDrug,EtaPLS,1);
ttestout(LRIntcptDrug,LRIntcptPLS,1);
ttestout(LRFeedConfDrug,LRFeedConfPLS,1);


ttestout(PlayBiasPLS(indexLowScoreO),PlayBiasPLS(indexHighScoreO),1);
ttestout(InvTPLS(indexLowScoreO),InvTPLS(indexHighScoreO),1);
ttestout(LRIntcptPLS(indexLowScoreO),LRIntcptPLS(indexHighScoreO),1);
ttestout(EtaPLS(indexLowScoreO),EtaPLS(indexHighScoreO),1);
ttestout(LRFeedConfDrug(indexLowScoreO),LRFeedConfDrug(indexHighScoreO),1);


group = repmat("Gr_A",94,1);
group(indexHighScoreO) = "Gr_B";    

% ANOVA eta
t_DrugEffect_eta = table(group,EtaPLS,EtaDrug,...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_eta,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);

ranovatbl_Eta = ranova(rm,'WithinModel','TimePoints'); 


% Session Control eta

SessionGroup = repmat("Gr_A",94,1);
SessionGroup(Session1==1) = "Gr_B"; 

t_DrugEffect_eta_SC = table(group,SessionGroup,EtaPLS,EtaDrug,...
    'VariableNames',{'Group','Session','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_eta_SC,'PointsSession1-PointsSession2 ~ Group:Session','WithinDesign',Session);

ranovatbl_Eta_SC = ranova(rm,'WithinModel','TimePoints'); 


ttestout(InvTDrug(indexLowScoreO),InvTPLS(indexLowScoreO),1);


% Session Control beta

SessionGroup = repmat("Gr_A",94,1);
SessionGroup(Session1==1) = "Gr_B"; 

t_DrugEffect_beta_SC = table(group,SessionGroup,InvTPLS,InvTDrug,...
    'VariableNames',{'Group','Session','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_beta_SC,'PointsSession1-PointsSession2 ~ Group:Session','WithinDesign',Session);

ranovatbl_beta_SC = ranova(rm,'WithinModel','TimePoints'); 


ttestout(PlayBiasDrug(indexLowScoreO),PlayBiasPLS(indexLowScoreO),1);
ttestout(EtaDrug(indexLowScoreO),EtaPLS(indexLowScoreO),1);
ttestout(LRIntcptDrug(indexLowScoreO),LRIntcptPLS(indexLowScoreO),1);
ttestout(LRFeedConfDrug(indexLowScoreO),LRFeedConfPLS(indexLowScoreO),1);

ttestout(InvTDrug(indexHighScoreO),InvTPLS(indexHighScoreO),1);
ttestout(PlayBiasDrug(indexHighScoreO),PlayBiasPLS(indexHighScoreO),1);
ttestout(EtaDrug(indexHighScoreO),EtaPLS(indexHighScoreO),1);
ttestout(LRIntcptDrug(indexHighScoreO),LRIntcptPLS(indexHighScoreO),1);
ttestout(LRFeedConfDrug(indexHighScoreO),LRFeedConfPLS(indexHighScoreO),1);

% P correct choice
ttestout(RawInfoPLSession.CorrChoice_earlyLearning_HighProb,RawInfoDrugSession.CorrChoice_earlyLearning_HighProb,1);
ttestout(RawInfoPLSession.CorrChoice_lateLearning_HighProb,RawInfoDrugSession.CorrChoice_lateLearning_HighProb,1);

ttestout(RawInfoPLSession.CorrChoice_earlyLearning_LowProb,RawInfoDrugSession.CorrChoice_earlyLearning_LowProb,1);
ttestout(RawInfoPLSession.CorrChoice_lateLearning_LowProb,RawInfoDrugSession.CorrChoice_lateLearning_LowProb,1);

ttestout(RawInfoPLSession.CorrChoice_earlyLearning_HighProb(indexLowScoreO),RawInfoDrugSession.CorrChoice_earlyLearning_HighProb(indexLowScoreO),1);
ttestout(RawInfoPLSession.CorrChoice_lateLearning_HighProb(indexLowScoreO),RawInfoDrugSession.CorrChoice_lateLearning_HighProb(indexLowScoreO),1);

ttestout(RawInfoPLSession.CorrChoice_earlyLearning_LowProb(indexLowScoreO),RawInfoDrugSession.CorrChoice_earlyLearning_LowProb(indexLowScoreO),1);
ttestout(RawInfoPLSession.CorrChoice_lateLearning_LowProb(indexLowScoreO),RawInfoDrugSession.CorrChoice_lateLearning_LowProb(indexLowScoreO),1);

% response switches
ttestout(RawInfoPLSession.RS_earlyLearning_HighProb,RawInfoDrugSession.RS_earlyLearning_HighProb,1);
ttestout(RawInfoPLSession.RS_lateLearning_HighProb,RawInfoDrugSession.RS_lateLearning_HighProb,1);

ttestout(RawInfoPLSession.RS_earlyLearning_LowProb,RawInfoDrugSession.RS_earlyLearning_LowProb,1);
ttestout(RawInfoPLSession.RS_lateLearning_LowProb,RawInfoDrugSession.RS_lateLearning_LowProb,1);

ttestout(RawInfoPLSession.RS_earlyLearning_HighProb(indexLowScoreO),RawInfoDrugSession.RS_earlyLearning_HighProb(indexLowScoreO),1);
ttestout(RawInfoPLSession.RS_lateLearning_HighProb(indexLowScoreO),RawInfoDrugSession.RS_lateLearning_HighProb(indexLowScoreO),1);

ttestout(RawInfoPLSession.RS_earlyLearning_LowProb(indexLowScoreO),RawInfoDrugSession.RS_earlyLearning_LowProb(indexLowScoreO),1);
ttestout(RawInfoPLSession.RS_lateLearning_LowProb(indexLowScoreO),RawInfoDrugSession.RS_lateLearning_LowProb(indexLowScoreO),1);

% % response switches to error
% ttestout(RawInfoPLSession.RS_Err_earlyLearning_HighProb,RawInfoDrugSession.RS_Err_earlyLearning_HighProb,1);
% ttestout(RawInfoPLSession.RS_Err_lateLearning_HighProb,RawInfoDrugSession.RS_Err_lateLearning_HighProb,1);
% 
% ttestout(RawInfoPLSession.RS_Err_earlyLearning_LowProb,RawInfoDrugSession.RS_Err_earlyLearning_LowProb,1);
% ttestout(RawInfoPLSession.RS_Err_lateLearning_LowProb,RawInfoDrugSession.RS_Err_lateLearning_LowProb,1);
% 
% ttestout(RawInfoPLSession.RS_Err_earlyLearning_HighProb(indexLowScoreO),RawInfoDrugSession.RS_Err_earlyLearning_HighProb(indexLowScoreO),1);
% ttestout(RawInfoPLSession.RS_Err_lateLearning_HighProb(indexLowScoreO),RawInfoDrugSession.RS_Err_lateLearning_HighProb(indexLowScoreO),1);
% 
% ttestout(RawInfoPLSession.RS_Err_earlyLearning_LowProb(indexLowScoreO),RawInfoDrugSession.RS_Err_earlyLearning_LowProb(indexLowScoreO),1);
% ttestout(RawInfoPLSession.RS_Err_lateLearning_LowProb(indexLowScoreO),RawInfoDrugSession.RS_Err_lateLearning_LowProb(indexLowScoreO),1);

% correct choices after misleading FB
ttestout(RawInfoPLSession.AccAfterMisleadingFB_earlyLearing_LowProb,RawInfoDrugSession.AccAfterMisleadingFB_earlyLearing_LowProb,1);
ttestout(RawInfoPLSession.AccAfterMisleadingFB_earlyLearing_LowProb(indexLowScoreO),RawInfoDrugSession.AccAfterMisleadingFB_earlyLearing_LowProb(indexLowScoreO),1);


% ANOVA ACC a MF
t_DrugEffect_ACC_MF = table(group,RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb,RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb,...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_ACC_MF,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);

ranovatbl__ACC_MF = ranova(rm,'WithinModel','TimePoints'); 

ttestout(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb,RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb,1);
ttestout(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb(indexLowScoreO),RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb(indexLowScoreO),1);
ttestout(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb(indexHighScoreO),RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb(indexHighScoreO),1);


ttestout(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_HighProb,RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_HighProb,1);
ttestout(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_HighProb(indexLowScoreO),RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_HighProb(indexLowScoreO),1);

t_DrugEffect_ACC_MF_SC = table(group,SessionGroup,RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb,RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb,...
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

t_DrugEffect_LR_all_SC = table(group,SessionGroup,RawInfoPLSession.SD_LR_earlyLearning_all,RawInfoDrugSession.SD_LR_earlyLearning_all,...
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

t_DrugEffect_LR_HighProb_SC = table(group,SessionGroup,RawInfoPLSession.SD_LR_earlyLearning_HighProb,RawInfoDrugSession.SD_LR_earlyLearning_HighProb,...
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


t_DrugEffect_LR_LowProb_SC = table(group,SessionGroup,RawInfoPLSession.SD_LR_earlyLearning_LowProb,RawInfoDrugSession.SD_LR_earlyLearning_LowProb,...
    'VariableNames',{'Group','Session','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_LR_LowProb_SC ,'PointsSession1-PointsSession2 ~ Group:Session','WithinDesign',Session);

ranovatbl_LR_LowProb_SC = ranova(rm,'WithinModel','TimePoints');


%% Check how task performance maps on model parameters

% setup indecies

all     = 1:188;
MPH     = 1:94;
PLA     = 95:188;

SessionOrderInfo    = [Session1;Session1];
firstSession        = find(SessionOrderInfo==1);

MPH_LPO  = indexLowScoreO;
PLA_LPO  = indexLowScoreO+94;

MPH_HPO  = indexHighScoreO;
PLA_HPO  = indexHighScoreO+94;

HighPerformer = [MPH_HPO;PLA_HPO];
LowPerformer  = [MPH_LPO;PLA_LPO];

index  = PLA;

% define IV's and DV's 
Endpoints_all  = [EndPOints_DS;EndPOints_PLS];

ttestout(Endpoints_all(MPH),Endpoints_all(PLA),1);

Points = nanzscore(CorrChoice_late_all(index));

OrientationPerfromance = [EndPOints_O;EndPOints_O];

Eta_all          = [EtaDrug;EtaPLS];
invT_all         = [InvTDrug;InvTPLS];
PlayBias_all     = [PlayBiasDrug;PlayBiasPLS];
LRItcpt_all      = [LRIntcptDrug;LRIntcptPLS];
LRFeedConf_all   = [LRFeedConfDrug;LRFeedConfPLS];

% Latent learning biases from model
Eta_Reg         = nanzscore(Eta_all(index));
invT_Reg        = nanzscore(invT_all(index));
PlayBias_Reg    = nanzscore(PlayBias_all(index));
LRItcpt_Reg     = nanzscore(LRItcpt_all(index));
LRFeedConf_Reg  = nanzscore(LRFeedConf_all(index));

OrientationPerformance_Reg = nanzscore(OrientationPerfromance(index));

% 1. model

% ModN = 'Points';
% M.DesignM = nanrem(table(Eta_Reg,invT_Reg,PlayBias_Reg,LRItcpt_Reg,LRFeedConf_Reg, Points));
% % M.DesignM.RT  = normalise(M.DesignM.RT);
% 
% M.labels    = { {'low' 'high'} {'low' 'high'} {'low' 'high'} {'low' 'high'} {'low' 'high'} };
% M.CatVars   = [                                                                     ];
% M.modelspec = 'Points ~ Eta_Reg + invT_Reg + PlayBias_Reg + LRItcpt_Reg + LRFeedConf_Reg';
% M.modelspec = [M.modelspec  ' + Eta_Reg:LRItcpt_Reg + Eta_Reg:LRFeedConf_Reg'];
% LF          = 'normal';
% 
% 
% RegModall   = fitglm(M.DesignM, M.modelspec, 'CategoricalVars', M.CatVars,'Distribution', LF,'Options',statset('MaxIter',1000));
% CI          = coefCI(RegModall);
% 
% RegModall.Rsquared.Ordinary
% RegModall.Rsquared.Adjusted


% 2. Model with 3way interaction (orienation perforamnce
ModN = 'Points';
M.DesignM = nanrem(table(Eta_Reg,invT_Reg,PlayBias_Reg,LRItcpt_Reg,LRFeedConf_Reg,OrientationPerformance_Reg, Points));
% M.DesignM.RT  = normalise(M.DesignM.RT);

M.labels    = { {'low' 'high'} {'low' 'high'} {'low' 'high'} {'low' 'high'} {'low' 'high'} {'low' 'high'}};
M.CatVars   = [                                                                     ];
M.modelspec = 'Points ~ Eta_Reg + invT_Reg + PlayBias_Reg + LRItcpt_Reg + LRFeedConf_Reg + OrientationPerformance_Reg';
M.modelspec = [M.modelspec  ' + Eta_Reg:LRItcpt_Reg + Eta_Reg:LRFeedConf_Reg'];
M.modelspec = [M.modelspec  ' + Eta_Reg:LRItcpt_Reg:OrientationPerformance_Reg + Eta_Reg:LRFeedConf_Reg:OrientationPerformance_Reg'];
LF          = 'normal';


RegModall   = fitglm(M.DesignM, M.modelspec, 'CategoricalVars', M.CatVars,'Distribution', LF,'Options',statset('MaxIter',1000));
CI          = coefCI(RegModall);

RegModall.Rsquared.Ordinary
RegModall.Rsquared.Adjusted


% check correlation of IV's

% plot 
paramLabels = {'Eta' 'invT' 'PlayBias' 'LRItcpt' 'LRFeedConf' 'OP' 'Eta*LRItcpt'  'Eta*LRFeedConf' 'Eta*LRItcpt*OP'  'Eta*LRFeedConf*OP'};
figure(1);clf;
subplot(1,3,1)
set(gca, 'box', 'off')
nP=length(CI)-1;
hold on

[~, I]=sort(RegModall.Coefficients.Estimate(2:end));
sortWeights = RegModall.Coefficients.Estimate(I+1);

used=RegModall.Coefficients.Estimate(2:end);
Scale=max(max(abs(CI(2:end,:))));
xline(0, '--k',LineWidth=1)
plot( CI(I+1,:)', [1:nP; 1:nP],'-k',LineWidth=2)
plot(sortWeights, 1:nP,  'o', 'markerFaceColor', 'r','markerEdgeColor', 'k', 'lineWidth', 1, 'markerSize', 15)
ylim([0, nP+1])
xlabel('Predictor weight')

set(gca, 'ytick', 1:nP, 'yticklabels', paramLabels(I), 'box', 'off')
fig = gcf;
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 12 24];
set(gca, 'FontSize', 20)
ytickangle(30)


% raw data bins
subplot(2,3,2)

medianEta = median(Eta_Reg);
medianLRItcpt = median(LRItcpt_Reg);
split_OP = median(OrientationPerformance_Reg);

iLowEtaLowLRIcpt_LOP    = find(Eta_Reg < medianEta & LRItcpt_Reg < medianLRItcpt & OrientationPerformance_Reg < split_OP);
iLowEtaHighLRIcpt_LOP   = find(Eta_Reg < medianEta & LRItcpt_Reg > medianLRItcpt & OrientationPerformance_Reg < split_OP);

iHighEtaLowLRIcpt_LOP    = find(Eta_Reg > medianEta & LRItcpt_Reg < medianLRItcpt & OrientationPerformance_Reg < split_OP);
iHighEtaHighLRIcpt_LOP   = find(Eta_Reg > medianEta & LRItcpt_Reg > medianLRItcpt & OrientationPerformance_Reg < split_OP);

y1 = [mean(Endpoints_all(iLowEtaLowLRIcpt_LOP)) mean(Endpoints_all(iLowEtaHighLRIcpt_LOP)); ...
    mean(Endpoints_all(iHighEtaLowLRIcpt_LOP)) mean(Endpoints_all(iHighEtaHighLRIcpt_LOP))];

bar(y1)
ylim([0 1100])
title('Low orientation performance')
xticklabels({'low eta' 'high eta'})
legend({'low LR Icpt' 'high LR Icpt'})
ylabel('Points')


subplot(2,3,3)

iLowEtaLowLRIcpt_HOP    = find(Eta_Reg < medianEta & LRItcpt_Reg < medianLRItcpt & OrientationPerformance_Reg > split_OP);
iLowEtaHighLRIcpt_HOP   = find(Eta_Reg < medianEta & LRItcpt_Reg > medianLRItcpt & OrientationPerformance_Reg > split_OP);

iHighEtaLowLRIcpt_HOP    = find(Eta_Reg > medianEta & LRItcpt_Reg < medianLRItcpt & OrientationPerformance_Reg > split_OP);
iHighEtaHighLRIcpt_HOP   = find(Eta_Reg > medianEta & LRItcpt_Reg > medianLRItcpt & OrientationPerformance_Reg > split_OP);

y2 = [mean(Endpoints_all(iLowEtaLowLRIcpt_HOP)) mean(Endpoints_all(iLowEtaHighLRIcpt_HOP)); ...
    mean(Endpoints_all(iHighEtaLowLRIcpt_HOP)) mean(Endpoints_all(iHighEtaHighLRIcpt_HOP))];
bar(y2)
ylim([0 1100])
title('High orientation performance')
xticklabels({'low eta' 'high eta'})
ylabel('Points')

subplot(2,3,5)

medianLR_FC = median(LRFeedConf_Reg);

iLowEtaLowLR_FC_LOP    = find(Eta_Reg < medianEta & LRFeedConf_Reg  < medianLR_FC & OrientationPerformance_Reg < split_OP);
iLowEtaHighLR_FC_LOP   = find(Eta_Reg < medianEta & LRFeedConf_Reg  > medianLR_FC & OrientationPerformance_Reg < split_OP);

iHighEtaLowLR_FC_LOP    = find(Eta_Reg > medianEta & LRFeedConf_Reg  < medianLR_FC & OrientationPerformance_Reg < split_OP);
iHighEtaHighLR_FC_LOP   = find(Eta_Reg > medianEta & LRFeedConf_Reg  > medianLR_FC & OrientationPerformance_Reg < split_OP);

y3 = [mean(Endpoints_all(iLowEtaLowLR_FC_LOP)) mean(Endpoints_all(iLowEtaHighLR_FC_LOP));...
mean(Endpoints_all(iHighEtaLowLR_FC_LOP)) mean(Endpoints_all(iHighEtaHighLR_FC_LOP))];

bar(y3)
ylim([0 1100])
title('Low orientation performance')
xticklabels({'low eta' 'high eta'})

legend({'low FeedConf LR' 'high FeedConf FB'})
ylabel('Points')


subplot(2,3,6)

medianLR_FC = median(LRFeedConf_Reg);

iLowEtaLowLR_FC_HOP    = find(Eta_Reg < medianEta & LRFeedConf_Reg  < medianLR_FC & OrientationPerformance_Reg > split_OP);
iLowEtaHighLR_FC_HOP   = find(Eta_Reg < medianEta & LRFeedConf_Reg  > medianLR_FC & OrientationPerformance_Reg > split_OP);

iHighEtaLowLR_FC_HOP    = find(Eta_Reg > medianEta & LRFeedConf_Reg  < medianLR_FC & OrientationPerformance_Reg > split_OP);
iHighEtaHighLR_FC_HOP   = find(Eta_Reg > medianEta & LRFeedConf_Reg  > medianLR_FC & OrientationPerformance_Reg > split_OP);

y4 = [mean(Endpoints_all(iLowEtaLowLR_FC_HOP)) mean(Endpoints_all(iLowEtaHighLR_FC_HOP));...
mean(Endpoints_all(iHighEtaLowLR_FC_HOP)) mean(Endpoints_all(iHighEtaHighLR_FC_HOP))];

bar(y4)
ylim([0 1100])
title('High orientation performance')
xticklabels({'low eta' 'high eta'})
ylabel('Points')


h = gcf;
h.Position=[7         111        1728         890];
print2pdf(fullfile(pwd,'FIgures',['GLM_Points_PLA.pdf']),h,300)

%% GLM overall points
% setup indecies


% define IV's and DV's 
Points       = [EndPOints_DS;EndPOints_PLS];

SessionOrderInfo    = [Session1;Session1];

Drug                = zeros(188,1);
Drug(MPH)           = 1;

OrientationPerfromance = [EndPOints_O;EndPOints_O];

% 1. model

ModN = 'Points';
M.DesignM = nanrem(table(Drug,SessionOrderInfo,OrientationPerfromance, Points));

M.labels    = { {'low' 'high'} {'low' 'high'} {'low' 'high'} };
M.CatVars   = [ 1               2                            ];
M.modelspec = 'Points ~ Drug + SessionOrderInfo + OrientationPerfromance';
M.modelspec = [M.modelspec  ' + Drug:OrientationPerfromance'];
LF          = 'normal';


RegModall   = fitglm(M.DesignM, M.modelspec, 'CategoricalVars', M.CatVars,'Distribution', LF,'Options',statset('MaxIter',1000));
CI          = coefCI(RegModall);

RegModall.Rsquared.Ordinary
RegModall.Rsquared.Adjusted


% check correlation of IV's
corr(table2array(M.DesignM))


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

figure(2);clf;
scatter(Eta_all,ACCMisFEED_late_LowProb);hold on
hline = refline;
hline.LineWidth=3;
plot(EtaDrug,RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb, 'o', 'markerSize', 10, 'markerFaceColor', [0.6350 0.0780 0.1840], 'markerEdgeColor', 'k', 'lineWidth', 1)
plot(EtaPLS, RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb, 'o', 'markerSize', 10, 'markerFaceColor', [0.4940 0.1840 0.5560], 'markerEdgeColor', 'k', 'lineWidth', 1)
ylabel('P(correct after double MFB)')
xlabel('Eta')
title('r = .29, p < 0.001')
ylim([0.2 1.05])
h = gcf;
h.Position=[-2217         538         560         420];
print2pdf(fullfile(pwd,'FIgures',['Corr_EtaAccMisFB.pdf']),h,300)


figure(3),clf;
subplot(2,1,1)
[x,y1,~,IQR] = violinplotHK(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb);
patch([y1 -y1(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.7)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb);
patch([y1 -y1(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.7)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb),'ko','markerfacecolor','g','markersize',10)
set(gca,'xlim',[-2.5 5.5],'xtick',[],'ylim',[0.4 1.05])
box off

subplot(2,1,2)
[x,y1,~,IQR] = violinplotHK(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb(indexLowScoreO));
patch([y1 -y1(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.5)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb(indexLowScoreO));
patch([y1 -y1(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.5)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

box off
%high performer 
[x,y1,~,IQR] = violinplotHK(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb(indexHighScoreO));
patch([y1 -y1(end:-1:1)]+6, [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.9)
hold on
plot([6 6],IQR,'k','linew',3)
plot(6,nanmean(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(6,nanmedian(RawInfoPLSession.AccAfterMisleadingFB_lateLearning_LowProb(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb(indexHighScoreO));
patch([y1 -y1(end:-1:1)]+9 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.9)
plot([9 9],IQR,'k','linew',3)
plot(9,nanmean(RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(9,nanmedian(RawInfoDrugSession.AccAfterMisleadingFB_lateLearning_LowProb(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)
set(gca,'xlim',[-2.5 11.5],'xtick',[],'ylim',[0.4 1.05])
box off

h = gcf;
h.Position=[584   405   342   596];
print2pdf(fullfile(pwd,'FIgures',['EtaAccMisFB.pdf']),h,300)



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


