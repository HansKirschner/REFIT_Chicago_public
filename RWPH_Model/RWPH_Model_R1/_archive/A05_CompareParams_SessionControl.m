clear
rootDir = pwd;
addpath(genpath(rootDir));

load('data/Session1_wGenPrior_Data_111110.mat')
load('data/fminconResults/Session1_wGenPrior_fminconResult_111110.mat')

InvTSession1        = fminconResult.fitParams(:,1);
PlayBiasSession1    = fminconResult.fitParams(:,2);
EtaSession1         = fminconResult.fitParams(:,3);
LRIntcptSession1    = fminconResult.fitParams(:,4);
LRFeedConfSession1  = fminconResult.fitParams(:,5);


load('data/Session2_wGenPrior_Data_111110.mat')
load('data/fminconResults/Session2_wGenPrior_fminconResult_111110.mat')

InvTSession2        = fminconResult.fitParams(:,1);
PlayBiasSession2    = fminconResult.fitParams(:,2);
EtaSession2         = fminconResult.fitParams(:,3);
LRIntcptSession2    = fminconResult.fitParams(:,4);
LRFeedConfSession2  = fminconResult.fitParams(:,5);

load('data/fminconResults/fminconResult_wPrior_111110.mat')
InvTOS        = fminconResult.fitParams(:,1);
PlayBiasOS    = fminconResult.fitParams(:,2);
EtaOS         = fminconResult.fitParams(:,3);
LRIntcptOS    = fminconResult.fitParams(:,4);
LRFeedConfOS  = fminconResult.fitParams(:,5);

load('data/RawInfoSession1.mat')
load('data/RawInfoSession2.mat')

load('data/all_EndPOints_Session1.mat')
load('data/all_EndPOints_Session2.mat')

%% exclusion of subjects
load('data/InfoSubjects.mat')
load('data/all_EndPOints_Orientation.mat')
% Orientation
excluda_O                           = [26,79,86];
excluda_expSession                  = [30,60,90,97];
ID(excluda_expSession)              = [];

InvTSession2(excluda_expSession)         = [];
PlayBiasSession2(excluda_expSession)     = [];
EtaSession2(excluda_expSession)          = [];
LRIntcptSession2(excluda_expSession)     = [];
LRFeedConfSession2(excluda_expSession)   = [];

InvTSession1(excluda_expSession)         = [];
PlayBiasSession1(excluda_expSession)     = [];
EtaSession1(excluda_expSession)          = [];
LRIntcptSession1(excluda_expSession)     = [];
LRFeedConfSession1(excluda_expSession)   = [];

% endpoints
EndPOints_Session1(excluda_expSession)   = [];
EndPOints_Session2(excluda_expSession)   = [];


%P correct choices
RawInfoSession1.CorrChoice_earlyLearning_HighProb(excluda_expSession)  = [];
RawInfoSession1.CorrChoice_lateLearning_HighProb(excluda_expSession)   = [];
RawInfoSession1.CorrChoice_earlyLearning_LowProb(excluda_expSession)   = [];
RawInfoSession1.CorrChoice_lateLearning_LowProb(excluda_expSession)    = [];

RawInfoSession2.CorrChoice_earlyLearning_HighProb(excluda_expSession)    = [];
RawInfoSession2.CorrChoice_lateLearning_HighProb(excluda_expSession)      = [];
RawInfoSession2.CorrChoice_earlyLearning_LowProb(excluda_expSession)     = [];
RawInfoSession2.CorrChoice_lateLearning_LowProb(excluda_expSession)      = [];

% response switches
RawInfoSession1.RS_earlyLearning_HighProb(excluda_expSession)  = [];
RawInfoSession1.RS_lateLearning_HighProb(excluda_expSession)   = [];
RawInfoSession1.RS_earlyLearning_LowProb(excluda_expSession)   = [];
RawInfoSession1.RS_lateLearning_LowProb(excluda_expSession)    = [];

RawInfoSession2.RS_earlyLearning_HighProb(excluda_expSession)    = [];
RawInfoSession2.RS_lateLearning_HighProb(excluda_expSession)      = [];
RawInfoSession2.RS_earlyLearning_LowProb(excluda_expSession)     = [];
RawInfoSession2.RS_lateLearning_LowProb(excluda_expSession)      = [];

% response switches to error
RawInfoSession1.RS_Err_earlyLearning_HighProb(excluda_expSession)   = [];
RawInfoSession1.RS_Err_lateLearning_HighProb(excluda_expSession)   = [];
RawInfoSession1.RS_Err_earlyLearning_LowProb(excluda_expSession)   = [];
RawInfoSession1.RS_Err_lateLearning_LowProb(excluda_expSession)    = [];

RawInfoSession2.RS_Err_earlyLearning_HighProb(excluda_expSession)    = [];
RawInfoSession2.RS_Err_lateLearning_HighProb(excluda_expSession)      = [];
RawInfoSession2.RS_Err_earlyLearning_LowProb(excluda_expSession)     = [];
RawInfoSession2.RS_Err_lateLearning_LowProb(excluda_expSession)      = [];


% correct choices after misleading FB
RawInfoSession1.AccAfterMisleadingFB_earlyLearing_LowProb(excluda_expSession)    = [];
RawInfoSession1.AccAfterMisleadingFB_lateLearning_LowProb(excluda_expSession)    = [];    
RawInfoSession1.AccAfterMisleadingFB_lateLearning_HighProb(excluda_expSession)    = [];

RawInfoSession2.AccAfterMisleadingFB_earlyLearing_LowProb(excluda_expSession)    = [];
RawInfoSession2.AccAfterMisleadingFB_lateLearning_LowProb(excluda_expSession)    = [];    
RawInfoSession2.AccAfterMisleadingFB_lateLearning_HighProb(excluda_expSession)    = [];


Shortname(excluda_O)            = [];
EndPOints_O(excluda_O)          = [];

InvTOS(excluda_O)           = [];
PlayBiasOS(excluda_O)       = [];
EtaOS(excluda_O)            = [];
LRIntcptOS(excluda_O)       = [];
LRFeedConfOS(excluda_O)     = [];

LIA                             = ismember(ID,Shortname,'rows');
indexExclude_missingO           = find(LIA==0)';

InvTSession2(indexExclude_missingO)         = [];
PlayBiasSession2(indexExclude_missingO)     = [];
EtaSession2(indexExclude_missingO)          = [];
LRIntcptSession2(indexExclude_missingO)     = [];
LRFeedConfSession2(indexExclude_missingO)   = [];

InvTSession1(indexExclude_missingO)         = [];
PlayBiasSession1(indexExclude_missingO)     = [];
EtaSession1(indexExclude_missingO)          = [];
LRIntcptSession1(indexExclude_missingO)     = [];
LRFeedConfSession1(indexExclude_missingO)   = [];

% P correct choices
RawInfoSession1.CorrChoice_earlyLearning_HighProb(indexExclude_missingO)  = [];
RawInfoSession1.CorrChoice_lateLearning_HighProb(indexExclude_missingO)   = [];
RawInfoSession1.CorrChoice_earlyLearning_LowProb(indexExclude_missingO)   = [];
RawInfoSession1.CorrChoice_lateLearning_LowProb(indexExclude_missingO)    = [];

RawInfoSession2.CorrChoice_earlyLearning_HighProb(indexExclude_missingO)    = [];
RawInfoSession2.CorrChoice_lateLearning_HighProb(indexExclude_missingO)      = [];
RawInfoSession2.CorrChoice_earlyLearning_LowProb(indexExclude_missingO)     = [];
RawInfoSession2.CorrChoice_lateLearning_LowProb(indexExclude_missingO)      = [];

% responses switches
RawInfoSession1.RS_earlyLearning_HighProb(indexExclude_missingO)  = [];
RawInfoSession1.RS_lateLearning_HighProb(indexExclude_missingO)   = [];
RawInfoSession1.RS_earlyLearning_LowProb(indexExclude_missingO)   = [];
RawInfoSession1.RS_lateLearning_LowProb(indexExclude_missingO)    = [];

RawInfoSession2.RS_earlyLearning_HighProb(indexExclude_missingO)     = [];
RawInfoSession2.RS_lateLearning_HighProb(indexExclude_missingO)      = [];
RawInfoSession2.RS_earlyLearning_LowProb(indexExclude_missingO)      = [];
RawInfoSession2.RS_lateLearning_LowProb(indexExclude_missingO)       = [];

% response switches to error

RawInfoSession1.RS_Err_earlyLearning_HighProb(indexExclude_missingO)       = [];
RawInfoSession1.RS_Err_lateLearning_HighProb(indexExclude_missingO)        = [];
RawInfoSession1.RS_Err_earlyLearning_LowProb(indexExclude_missingO)        = [];
RawInfoSession1.RS_Err_lateLearning_LowProb(indexExclude_missingO)         = [];

RawInfoSession2.RS_Err_earlyLearning_HighProb(indexExclude_missingO)     = [];
RawInfoSession2.RS_Err_lateLearning_HighProb(indexExclude_missingO)      = [];
RawInfoSession2.RS_Err_earlyLearning_LowProb(indexExclude_missingO)      = [];
RawInfoSession2.RS_Err_lateLearning_LowProb(indexExclude_missingO)       = [];


% correct choices after misleading FB
RawInfoSession1.AccAfterMisleadingFB_earlyLearing_LowProb(indexExclude_missingO)       = [];
RawInfoSession1.AccAfterMisleadingFB_lateLearning_LowProb(indexExclude_missingO)       = [];
RawInfoSession1.AccAfterMisleadingFB_lateLearning_HighProb(indexExclude_missingO)       = [];

RawInfoSession2.AccAfterMisleadingFB_earlyLearing_LowProb(indexExclude_missingO)       = [];
RawInfoSession2.AccAfterMisleadingFB_lateLearning_LowProb(indexExclude_missingO)       = [];
RawInfoSession2.AccAfterMisleadingFB_lateLearning_HighProb(indexExclude_missingO)       = [];


% endpoints
EndPOints_Session1(indexExclude_missingO)    = [];
EndPOints_Session2(indexExclude_missingO)     = [];

split = median(EndPOints_O);

indexLowScoreO  = find(EndPOints_O<=split);
indexHighScoreO = find(EndPOints_O>split);

%%
ttestout(InvTSession1,InvTSession2,1);
ttestout(PlayBiasSession1,PlayBiasSession2,1);
ttestout(EtaSession1,EtaSession2,1);
ttestout(LRIntcptSession1,LRIntcptSession2,1);
ttestout(LRFeedConfSession1,LRFeedConfSession2,1);

ttestout(InvTSession1(indexLowScoreO),InvTSession2(indexLowScoreO),1);
ttestout(PlayBiasSession1(indexLowScoreO),PlayBiasSession2(indexLowScoreO),1);
ttestout(EtaSession1(indexLowScoreO),EtaSession2(indexLowScoreO),1);
ttestout(LRIntcptSession1(indexLowScoreO),LRIntcptSession2(indexLowScoreO),1);
ttestout(LRFeedConfSession1(indexLowScoreO),LRFeedConfSession2(indexLowScoreO),1);

ttestout(InvTSession1(indexHighScoreO),InvTSession2(indexHighScoreO),1);
ttestout(PlayBiasSession1(indexHighScoreO),PlayBiasSession2(indexHighScoreO),1);
ttestout(EtaSession1(indexHighScoreO),EtaSession2(indexHighScoreO),1);
ttestout(LRIntcptSession1(indexHighScoreO),LRIntcptSession2(indexHighScoreO),1);
ttestout(LRFeedConfSession1(indexHighScoreO),LRFeedConfSession2(indexHighScoreO),1);

% P correct choice
ttestout(RawInfoSession1.CorrChoice_earlyLearning_HighProb,RawInfoSession2.CorrChoice_earlyLearning_HighProb,1);
ttestout(RawInfoSession1.CorrChoice_lateLearning_HighProb,RawInfoSession2.CorrChoice_lateLearning_HighProb,1);

ttestout(RawInfoSession1.CorrChoice_earlyLearning_LowProb,RawInfoSession2.CorrChoice_earlyLearning_LowProb,1);
ttestout(RawInfoSession1.CorrChoice_lateLearning_LowProb,RawInfoSession2.CorrChoice_lateLearning_LowProb,1);

ttestout(RawInfoSession1.CorrChoice_earlyLearning_HighProb(indexLowScoreO),RawInfoSession2.CorrChoice_earlyLearning_HighProb(indexLowScoreO),1);
ttestout(RawInfoSession1.CorrChoice_lateLearning_HighProb(indexLowScoreO),RawInfoSession2.CorrChoice_lateLearning_HighProb(indexLowScoreO),1);

ttestout(RawInfoSession1.CorrChoice_earlyLearning_LowProb(indexLowScoreO),RawInfoSession2.CorrChoice_earlyLearning_LowProb(indexLowScoreO),1);
ttestout(RawInfoSession1.CorrChoice_lateLearning_LowProb(indexLowScoreO),RawInfoSession2.CorrChoice_lateLearning_LowProb(indexLowScoreO),1);

% % response switches
% ttestout(RawInfoPLSession.RS_earlyLearning_HighProb,RawInfoDrugSession.RS_earlyLearning_HighProb,1);
% ttestout(RawInfoPLSession.RS_lateLearning_HighProb,RawInfoDrugSession.RS_lateLearning_HighProb,1);
% 
% ttestout(RawInfoPLSession.RS_earlyLearning_LowProb,RawInfoDrugSession.RS_earlyLearning_LowProb,1);
% ttestout(RawInfoPLSession.RS_lateLearning_LowProb,RawInfoDrugSession.RS_lateLearning_LowProb,1);
% 
% ttestout(RawInfoPLSession.RS_earlyLearning_HighProb(indexLowScoreO),RawInfoDrugSession.RS_earlyLearning_HighProb(indexLowScoreO),1);
% ttestout(RawInfoPLSession.RS_lateLearning_HighProb(indexLowScoreO),RawInfoDrugSession.RS_lateLearning_HighProb(indexLowScoreO),1);
% 
% ttestout(RawInfoPLSession.RS_earlyLearning_LowProb(indexLowScoreO),RawInfoDrugSession.RS_earlyLearning_LowProb(indexLowScoreO),1);
% ttestout(RawInfoPLSession.RS_lateLearning_LowProb(indexLowScoreO),RawInfoDrugSession.RS_lateLearning_LowProb(indexLowScoreO),1);

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
ttestout(RawInfoSession1.AccAfterMisleadingFB_earlyLearing_LowProb,RawInfoSession2.AccAfterMisleadingFB_earlyLearing_LowProb,1);
ttestout(RawInfoSession1.AccAfterMisleadingFB_earlyLearing_LowProb(indexLowScoreO),RawInfoSession2.AccAfterMisleadingFB_earlyLearing_LowProb(indexLowScoreO),1);

ttestout(RawInfoSession1.AccAfterMisleadingFB_lateLearning_LowProb,RawInfoSession2.AccAfterMisleadingFB_lateLearning_LowProb,1);
ttestout(RawInfoSession1.AccAfterMisleadingFB_lateLearning_LowProb(indexLowScoreO),RawInfoSession2.AccAfterMisleadingFB_lateLearning_LowProb(indexLowScoreO),1);

ttestout(RawInfoSession1.AccAfterMisleadingFB_lateLearning_HighProb,RawInfoSession2.AccAfterMisleadingFB_lateLearning_HighProb,1);
ttestout(RawInfoSession1.AccAfterMisleadingFB_lateLearning_HighProb(indexLowScoreO),RawInfoSession2.AccAfterMisleadingFB_lateLearning_HighProb(indexLowScoreO),1);


%% Check how task performance maps on model parameters
all     = 1:188;
Drug    = 1:94;
PL      = 95:188;

Drug_LPO = indexLowScoreO;
PLS_LPO  = indexLowScoreO+94;

index   = all;

Endpoints_all           = [EndPOints_Session2;EndPOints_Session1];
RS_late_all             = [RawInfoSession2.RS_Err_lateLearning_LowProb;RawInfoSession1.RS_Err_lateLearning_LowProb];
CorrChoice_late_all     = [RawInfoSession2.CorrChoice_lateLearning_LowProb;RawInfoSession1.CorrChoice_lateLearning_LowProb];


ttestout(Endpoints_all(Drug),Endpoints_all(PL),1);
%ttestout(CorrChoice_all(Drug),CorrChoice_all(PL),1);

Points = nanzscore(CorrChoice_late_all(index));
%Points = nanzscore(RS_late_all(index));

Eta_all          = [EtaSession1;EtaSession2];
invT_all         = [InvTSession1;InvTSession2];
PlayBias_all     = [PlayBiasSession1;PlayBiasSession2];
LRItcpt_all      = [LRIntcptSession1;LRIntcptSession2];
LRFeedConf_all   = [LRFeedConfSession1;LRFeedConfSession2];

% Latent learning biases from model
Eta_Reg         = nanzscore(Eta_all(index));
invT_Reg        = nanzscore(invT_all(index));
PlayBias_Reg    = nanzscore(PlayBias_all(index));
LRItcpt_Reg     = nanzscore(LRItcpt_all(index));
LRFeedConf_Reg  = nanzscore(LRFeedConf_all(index));


ModN = 'Points';
M.DesignM = nanrem(table(Eta_Reg,invT_Reg,PlayBias_Reg,LRItcpt_Reg,LRFeedConf_Reg, Points));
% M.DesignM.RT  = normalise(M.DesignM.RT);

M.labels    = { {'low' 'high'} {'low' 'high'} {'low' 'high'} {'low' 'high'} {'low' 'high'} };
M.CatVars   = [                                                                     ];
M.modelspec = 'Points ~ Eta_Reg + invT_Reg + PlayBias_Reg + LRItcpt_Reg + LRFeedConf_Reg';
%M.modelspec = 'Points ~ Eta_Reg:LRFeedConf_Reg';
LF          = 'normal';

RegModall   = fitglm(M.DesignM, M.modelspec, 'CategoricalVars', M.CatVars,'Distribution', LF,'Options',statset('MaxIter',1000));
CI          = coefCI(RegModall);

RegModall.Rsquared.Ordinary
RegModall.Rsquared.Adjusted

% plot 
paramLabels = {'Eta' 'invT' 'PlayBias' 'LRItcpt' 'LRFeedConf' };
figure(1);clf;
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


%% Check eta stuff - use GLM to see how parmams affect switching behaviour
Eta_all          = [EtaSession1;EtaSession2];

CorrChoice_early_HighProb   = [RawInfoSession2.CorrChoice_earlyLearning_HighProb;RawInfoSession1.CorrChoice_earlyLearning_HighProb];
CorrChoice_late_HighProb    = [RawInfoSession2.CorrChoice_lateLearning_HighProb;RawInfoSession1.CorrChoice_lateLearning_HighProb];

CorrChoice_early_LowProb   = [RawInfoSession2.CorrChoice_earlyLearning_LowProb;RawInfoSession1.CorrChoice_earlyLearning_LowProb];
CorrChoice_late_LowProb    = [RawInfoSession2.CorrChoice_lateLearning_LowProb;RawInfoSession1.CorrChoice_lateLearning_LowProb];

RS_early_HighProb   = [RawInfoSession2.RS_earlyLearning_HighProb;RawInfoSession1.RS_earlyLearning_HighProb];
RS_late_HighProb    = [RawInfoSession2.RS_lateLearning_HighProb;RawInfoSession1.RS_lateLearning_HighProb];

RS_early_LowProb   = [RawInfoSession2.RS_earlyLearning_LowProb;RawInfoSession1.RS_earlyLearning_LowProb];
RS_late_LowProb    = [RawInfoSession2.RS_lateLearning_LowProb;RawInfoSession1.RS_lateLearning_LowProb];


corr(EtaSession1,RawInfoSession2.CorrChoice_earlyLearning_HighProb)
corr(EtaSession1,RawInfoSession2.CorrChoice_lateLearning_HighProb)
corr(EtaSession1,RawInfoSession2.CorrChoice_earlyLearning_LowProb)
corr(EtaSession1,RawInfoSession2.CorrChoice_lateLearning_LowProb)


corr(EtaSession2,RawInfoSession1.CorrChoice_earlyLearning_HighProb)
corr(EtaSession2,RawInfoSession1.CorrChoice_lateLearning_HighProb)
corr(EtaSession2,RawInfoSession1.CorrChoice_earlyLearning_LowProb)
corr(EtaSession2,RawInfoSession1.CorrChoice_lateLearning_LowProb)


[r,p]=corr(Eta_all,CorrChoice_early_HighProb);
[r,p]=corr(Eta_all,CorrChoice_late_HighProb);

[r,p]=corr(Eta_all,CorrChoice_early_LowProb);
[r,p]=corr(Eta_all,CorrChoice_late_LowProb);


[r,p]=corr(Eta_all,RS_early_HighProb);
[r,p]=corr(Eta_all,RS_late_HighProb);

[r,p]=corr(Eta_all,RS_early_LowProb);
[r,p]=corr(Eta_all,RS_late_LowProb);


cols = get(groot,'DefaultAxesColorOrder');
color(1,:) = cols(5,:);
color(2,:) = cols(2,:);
color(3,:) = cols(7,:);

figure(2);clf;
scatter(Eta_all,ShiftBehav);hold on
hline = refline;
hline.LineWidth=3;
plot(EtaSession1,RawInfoSession2.LoseShift_all, 'o', 'markerSize', 10, 'markerFaceColor', color(1,:), 'markerEdgeColor', 'k', 'lineWidth', 1)
plot(EtaSession2, RawInfoSession1.LoseShift_all, 'o', 'markerSize', 10, 'markerFaceColor', color(2,:), 'markerEdgeColor', 'k', 'lineWidth', 1)
ylabel('P(Disconfirmation Shift)')


ShiftBehavMF = [RawInfoSession2.P_SW_AfterMisleadingFeedback;RawInfoSession1.P_SW_AfterMisleadingFeedback];

corr(EtaSession1,RawInfoSession2.P_SW_AfterMisleadingFeedback)
corr(EtaSession2,RawInfoSession1.P_SW_AfterMisleadingFeedback)

ttestout(RawInfoSession1.P_SW_AfterMisleadingFeedback,RawInfoSession2.P_SW_AfterMisleadingFeedback,1)

[r,p]=corr(Eta_all,ShiftBehavMF);


figure(2);clf;
scatter(Eta_all,ShiftBehavMF);hold on
hline = refline;
hline.LineWidth=3;
plot(EtaSession1,RawInfoSession2.P_SW_AfterMisleadingFeedback, 'o', 'markerSize', 10, 'markerFaceColor', color(1,:), 'markerEdgeColor', 'k', 'lineWidth', 1)
plot(EtaSession2, RawInfoSession1.P_SW_AfterMisleadingFeedback, 'o', 'markerSize', 10, 'markerFaceColor', color(2,:), 'markerEdgeColor', 'k', 'lineWidth', 1)
ylabel('P(switch after MF)')
xlabel('Eta')
title('r = .2, p = 0.005')
h = gcf;
print2pdf(fullfile(pwd,'FIgures',['Corr_EtaSwitch.pdf']),h,300)


%% plotting split by orientation performance

figure(1),clf;
subplot(2,3,1)
[x,y,~,IQR] = violinplotHK(InvTSession2(indexLowScoreO));
patch([y -y(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.5)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(InvTSession2(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(InvTSession2(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y,~,IQR] = violinplotHK(InvTSession1(indexLowScoreO));
patch([y -y(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.5)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(InvTSession1(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(InvTSession1(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)
set(gca,'xlim',[-2.5 5.5],'xtick',[],'ylim',[0 6])
box off
title('InvT')

%high performer 
[x,y,~,IQR] = violinplotHK(InvTSession2(indexHighScoreO));
patch([y -y(end:-1:1)]+6, [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.9)
hold on
plot([6 6],IQR,'k','linew',3)
plot(6,nanmean(InvTSession2(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(6,nanmedian(InvTSession2(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y,~,IQR] = violinplotHK(InvTSession1(indexHighScoreO));
patch([y -y(end:-1:1)]+9 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.9)
plot([9 9],IQR,'k','linew',3)
plot(9,nanmean(InvTSession1(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(9,nanmedian(InvTSession1(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)

set(gca,'xlim',[-2.5 11.5],'xtick',[],'ylim',[0 6])
box off
title('InvT')

subplot(2,3,2)
[x,y,~,IQR] = violinplotHK(PlayBiasSession2(indexLowScoreO));
patch([y -y(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.5)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(PlayBiasSession2(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(PlayBiasSession2(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y,~,IQR] = violinplotHK(PlayBiasSession1(indexLowScoreO));
patch([y -y(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.5)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(PlayBiasSession1(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(PlayBiasSession1(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

%HP
[x,y,~,IQR] = violinplotHK(PlayBiasSession2(indexHighScoreO));
patch([y -y(end:-1:1)]+6, [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.9)
hold on
plot([6 6],IQR,'k','linew',3)
plot(6,nanmean(PlayBiasSession2(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(6,nanmedian(PlayBiasSession2(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y,~,IQR] = violinplotHK(PlayBiasSession1(indexHighScoreO));
patch([y -y(end:-1:1)]+9 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.9)
plot([9 9],IQR,'k','linew',3)
plot(9,nanmean(PlayBiasSession1(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(9,nanmedian(PlayBiasSession1(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)

set(gca,'xlim',[-2.5 11.5],'xtick',[],'ylim',[-1 1])
box off
title('Play bias')

subplot(2,3,3)
[x,y,~,IQR] = violinplotHK(EtaSession2(indexLowScoreO));
patch([y -y(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.5)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(EtaSession2(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(EtaSession2(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y,~,IQR] = violinplotHK(EtaSession1(indexLowScoreO));
patch([y -y(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.5)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(EtaSession1(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(EtaSession1(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

%HP
[x,y,~,IQR] = violinplotHK(EtaSession2(indexHighScoreO));
patch([y -y(end:-1:1)]+6 , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.9)
hold on
plot([6 6],IQR,'k','linew',3)
plot(6,nanmean(EtaSession2(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(6,nanmedian(EtaSession2(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y,~,IQR] = violinplotHK(EtaSession1(indexHighScoreO));
patch([y -y(end:-1:1)]+9 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.9)
plot([9 9],IQR,'k','linew',3)
plot(9,nanmean(EtaSession1(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(9,nanmedian(EtaSession1(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)


set(gca,'xlim',[-2.5 11.5],'xtick',[],'ylim',[0 1])
box off
title('Eta')

subplot(2,3,4)
[x,y,~,IQR] = violinplotHK(LRIntcptSession2(indexLowScoreO));
patch([y -y(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.5)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(LRIntcptSession2(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(LRIntcptSession2(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y,~,IQR] = violinplotHK(LRIntcptSession1(indexLowScoreO));
patch([y -y(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.5)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(LRIntcptSession1(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(LRIntcptSession1(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

% HP
[x,y,~,IQR] = violinplotHK(LRIntcptSession2(indexHighScoreO));
patch([y -y(end:-1:1)]+6 , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.9)
hold on
plot([6 6],IQR,'k','linew',3)
plot(6,nanmean(LRIntcptSession2(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(6,nanmedian(LRIntcptSession2(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y,~,IQR] = violinplotHK(LRIntcptSession1(indexHighScoreO));
patch([y -y(end:-1:1)]+9 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.9)
plot([9 9],IQR,'k','linew',3)
plot(9,nanmean(LRIntcptSession1(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(9,nanmedian(LRIntcptSession1(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)

set(gca,'xlim',[-2.5 11.5],'xtick',[],'ylim',[-30 10])
box off
title('LRIntcpt')

subplot(2,3,5)
[x,y,~,IQR] = violinplotHK(LRFeedConfSession2(indexLowScoreO));
patch([y -y(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.5)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(LRFeedConfSession2(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(LRFeedConfSession2(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y,~,IQR] = violinplotHK(LRFeedConfSession1(indexLowScoreO));
patch([y -y(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.5)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(LRFeedConfSession1(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(LRFeedConfSession1(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

%HP
[x,y,~,IQR] = violinplotHK(LRFeedConfSession2(indexHighScoreO));
patch([y -y(end:-1:1)]+6, [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.9)
hold on
plot([6 6],IQR,'k','linew',3)
plot(6,nanmean(LRFeedConfSession2(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(6,nanmedian(LRFeedConfSession2(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y,~,IQR] = violinplotHK(LRFeedConfSession1(indexHighScoreO));
patch([y -y(end:-1:1)]+9 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.9)
plot([9 9],IQR,'k','linew',3)
plot(9,nanmean(LRFeedConfSession1(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(9,nanmedian(LRFeedConfSession1(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)


set(gca,'xlim',[-2.5 11.5],'xtick',[],'ylim',[-10 30])
box off
title('LRFeedConf')

h = gcf;
h.Position = [-2441         202         833         661];
print2pdf(fullfile(pwd,'FIgures',['ParamComparison_split_SessionControl.pdf']),h,300)

%% plot all 
figure(1),clf;
subplot(2,3,1)
[x,y,~,IQR] = violinplotHK(InvTSession2);
patch([y -y(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.7)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(InvTSession2),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(InvTSession2),'ko','markerfacecolor','g','markersize',10)

[x,y,~,IQR] = violinplotHK(InvTSession1);
patch([y -y(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.7)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(InvTSession1),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(InvTSession1),'ko','markerfacecolor','g','markersize',10)
set(gca,'xlim',[-2.5 5.5],'xtick',[],'ylim',[0 6])
box off
title('InvT')

subplot(2,3,2)
[x,y,~,IQR] = violinplotHK(PlayBiasSession2);
patch([y -y(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.7)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(PlayBiasSession2),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(PlayBiasSession2),'ko','markerfacecolor','g','markersize',10)

[x,y,~,IQR] = violinplotHK(PlayBiasSession1);
patch([y -y(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.7)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(PlayBiasSession1),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(PlayBiasSession1),'ko','markerfacecolor','g','markersize',10)
set(gca,'xlim',[-2.5 5.5],'xtick',[],'ylim',[-1 1])
box off
title('Play bias')

subplot(2,3,3)
[x,y,~,IQR] = violinplotHK(EtaSession2);
patch([y -y(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.7)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(EtaSession2),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(EtaSession2),'ko','markerfacecolor','g','markersize',10)

[x,y,~,IQR] = violinplotHK(EtaSession1);
patch([y -y(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.7)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(EtaSession1),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(EtaSession1),'ko','markerfacecolor','g','markersize',10)
set(gca,'xlim',[-2.5 5.5],'xtick',[],'ylim',[0 1])
box off
title('Eta')

subplot(2,3,4)
[x,y,~,IQR] = violinplotHK(LRIntcptSession2);
patch([y -y(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.7)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(LRIntcptSession2),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(LRIntcptSession2),'ko','markerfacecolor','g','markersize',10)

[x,y,~,IQR] = violinplotHK(LRIntcptSession1);
patch([y -y(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.7)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(LRIntcptSession1),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(LRIntcptSession1),'ko','markerfacecolor','g','markersize',10)
set(gca,'xlim',[-2.5 5.5],'xtick',[],'ylim',[-30 10])
box off
title('LRIntcpt')

subplot(2,3,5)
[x,y,~,IQR] = violinplotHK(LRFeedConfSession2);
patch([y -y(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.7)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(LRFeedConfSession2),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(LRFeedConfSession2),'ko','markerfacecolor','g','markersize',10)

[x,y,~,IQR] = violinplotHK(LRFeedConfSession1);
patch([y -y(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.7)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(LRFeedConfSession1),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(LRFeedConfSession1),'ko','markerfacecolor','g','markersize',10)
set(gca,'xlim',[-2.5 5.5],'xtick',[],'ylim',[-10 30])
box off
title('LRFeedConf')

h = gcf;
h.Position = [-2441         202         833         661];
print2pdf(fullfile(pwd,'FIgures',['ParamComparison_SessionControl.pdf']),h,300)



%% ploting
data =  EtaOS;
n = size(EtaSession1,1);

% get data distribution based on histogram
[y,x] = histcounts(data,'BinMethod','fd');
x = (x(1:end-1)+x(2:end))/2';
y = y./max(y);


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
patch([y -y(end:-1:1)] , [x x(end:-1:1)], 'b','facealpha',.5)
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

EtaDiffernece = EtaSession2-EtaSession1;
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
InvT_PL           = InvTSession2;
InvT_D            = InvTSession1;

PlayBias_O            = nan(113,1);
PlayBias_O(indexID)   = PlayBiasOS;
PlayBias_PL           = PlayBiasSession2;
PlayBias_D            = PlayBiasSession1;

Eta_O            = nan(113,1);
Eta_O(indexID)   = EtaOS;
Eta_PL           = EtaSession2;
Eta_D            = EtaSession1;

LRIntcpt_O            = nan(113,1);
LRIntcpt_O(indexID)   = LRIntcptOS;
LRIntcpt_PL           = LRIntcptSession2;
LRIntcpt_D            = LRIntcptSession1;

LRFeedConf_O            = nan(113,1);
LRFeedConf_O(indexID)   = LRFeedConfOS;
LRFeedConf_PL           = LRFeedConfSession2;
LRFeedConf_D            = LRFeedConfSession1;

EXL = table(ID,Session1,Session2,InvT_O,InvT_PL,InvT_D,...
    PlayBias_O, PlayBias_PL, PlayBias_D,...
    Eta_O, Eta_PL, Eta_D,...
    LRIntcpt_O,LRIntcpt_PL,LRIntcpt_D,...
    LRFeedConf_O,LRFeedConf_PL,LRFeedConf_D);

writetable(EXL, 'data/REFIT_Chicago_ModelParams.xlsx')


