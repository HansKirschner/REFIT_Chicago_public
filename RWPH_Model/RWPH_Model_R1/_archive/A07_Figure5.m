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

index  = all;

% define IV's and DV's 
Points  = [EndPOints_DS;EndPOints_PLS];


Eta_all          = [EtaDrug;EtaPLS];

EtaBig    = length(find(Eta_all>.13))/length(Eta_all);


invT_all         = [InvTDrug;InvTPLS];
PlayBias_all     = [PlayBiasDrug;PlayBiasPLS];
LRItcpt_all      = [LRIntcptDrug;LRIntcptPLS];
LRFeedConf_all   = [LRFeedConfDrug;LRFeedConfPLS];

ttestout(Eta_all(HighPerformer),Eta_all(LowPerformer),1);
ttestout(invT_all(HighPerformer),invT_all(LowPerformer),1);
ttestout(PlayBias_all(HighPerformer),PlayBias_all(LowPerformer),1);
ttestout(LRItcpt_all(HighPerformer),LRItcpt_all(LowPerformer),1);
ttestout(LRFeedConf_all (HighPerformer),LRFeedConf_all (LowPerformer),1);

% Latent learning biases from model
Eta_Reg         = nanzscore(Eta_all(index));
invT_Reg        = nanzscore(invT_all(index));
PlayBias_Reg    = nanzscore(PlayBias_all(index));
LRItcpt_Reg     = nanzscore(LRItcpt_all(index));
LRFeedConf_Reg  = nanzscore(LRFeedConf_all(index));

Points          = Points(index);

% 1. model

ModN = 'Points';
M.DesignM = nanrem(table(Eta_Reg,invT_Reg,PlayBias_Reg,LRItcpt_Reg,LRFeedConf_Reg, Points));
% M.DesignM.RT  = normalise(M.DesignM.RT);

M.labels    = { {'low' 'high'} {'low' 'high'} {'low' 'high'} {'low' 'high'} {'low' 'high'} };
M.CatVars   = [                                                                     ];
M.modelspec = 'Points ~ Eta_Reg + invT_Reg + PlayBias_Reg + LRItcpt_Reg + LRFeedConf_Reg';
% M.modelspec = [M.modelspec  ' + Eta_Reg:LRItcpt_Reg + Eta_Reg:LRFeedConf_Reg'];
LF          = 'normal';


RegModall   = fitglm(M.DesignM, M.modelspec, 'CategoricalVars', M.CatVars,'Distribution', LF,'Options',statset('MaxIter',1000));
CI          = coefCI(RegModall);

RegModall.Rsquared.Ordinary
RegModall.Rsquared.Adjusted

% check correlation of IV's
figure(1);clf;
imagesc(corr(table2array(M.DesignM)))
colorbar


% difference paramse PL - MH

delta_Eta          = Eta_Reg(PLA)-Eta_Reg(MPH);
delta_invT         = invT_Reg(PLA)-invT_Reg(MPH);
delta_PlayBias     = PlayBias_Reg(PLA)-PlayBias_Reg(MPH);
delta_LRItcpt      = LRItcpt_Reg(PLA) -LRItcpt_Reg(MPH);
delta_LRFeedConf   = LRFeedConf_Reg(PLA)-LRFeedConf_Reg(MPH);


% high BL performance
Diff_HP    = nan(5,1);
Diff_HP(1) = mean(Eta_Reg(PLA_HPO))-mean(Eta_Reg(MPH_HPO));
Diff_HP(2) = mean(invT_Reg(PLA_HPO))-mean(invT_Reg(MPH_HPO));
Diff_HP(3) = mean(PlayBias_Reg(PLA_HPO))-mean(PlayBias_Reg(MPH_HPO));
Diff_HP(4) = median(LRItcpt_Reg(PLA_HPO))-median(LRItcpt_Reg(MPH_HPO));
Diff_HP(5) = median(LRFeedConf_Reg(PLA_HPO))-median(LRFeedConf_Reg(MPH_HPO));

CI_Diff_HP    = nan(5,2);

SEM = std(delta_Eta(indexHighScoreO))/sqrt(size(delta_Eta(indexHighScoreO),1));     % Standard Error
ts = tinv([0.05  0.95],size(delta_Eta(indexHighScoreO),1)-1);      % T-Score
CI_Diff_HP(1,:) = mean(delta_Eta(indexHighScoreO))' + ts.*SEM';            % Confidence Intervals

SEM = std(delta_invT(indexHighScoreO))/sqrt(size(delta_invT(indexHighScoreO),1));     % Standard Error
ts = tinv([0.05  0.95],size(delta_invT(indexHighScoreO),1)-1);      % T-Score
CI_Diff_HP(2,:) = mean(delta_invT(indexHighScoreO))' + ts.*SEM';            % Confidence Intervals

SEM = std(delta_PlayBias(indexHighScoreO))/sqrt(size(delta_PlayBias(indexHighScoreO),1));     % Standard Error
ts = tinv([0.05  0.95],size(delta_PlayBias(indexHighScoreO),1)-1);      % T-Score
CI_Diff_HP(3,:) = mean(delta_PlayBias(indexHighScoreO))' + ts.*SEM';            % Confidence Intervals

SEM = std(delta_LRItcpt(indexHighScoreO))/sqrt(size(delta_LRItcpt(indexHighScoreO),1));     % Standard Error
ts = tinv([0.05  0.95],size(delta_LRItcpt(indexHighScoreO),1)-1);      % T-Score
CI_Diff_HP(4,:) = median(delta_LRItcpt(indexHighScoreO))' + ts.*SEM';            % Confidence Intervals

SEM = std(delta_LRFeedConf(indexHighScoreO))/sqrt(size(delta_LRFeedConf(indexHighScoreO),1));     % Standard Error
ts = tinv([0.05  0.95],size(delta_LRFeedConf(indexHighScoreO),1)-1);      % T-Score
CI_Diff_HP(5,:) = median(delta_LRFeedConf(indexHighScoreO))' + ts.*SEM';            % Confidence Intervals

nP = 5;
% high BL performance
Diff_LP    = nan(nP,1);
Diff_LP(1) = mean(Eta_Reg(PLA_LPO))-mean(Eta_Reg(MPH_LPO));
Diff_LP(2) = mean(invT_Reg(PLA_LPO))-mean(invT_Reg(MPH_LPO));
Diff_LP(3) = mean(PlayBias_Reg(PLA_LPO))-mean(PlayBias_Reg(MPH_LPO));
Diff_LP(4) = median(LRItcpt_Reg(PLA_LPO))-median(LRItcpt_Reg(MPH_LPO));
Diff_LP(5) = median(LRFeedConf_Reg(PLA_LPO))-median(LRFeedConf_Reg(MPH_LPO));

CI_Diff_LP    = nan(nP,2);

SEM = std(delta_Eta(indexLowScoreO ))/sqrt(size(delta_Eta(indexLowScoreO ),1));     % Standard Error
ts = tinv([0.05  0.95],size(delta_Eta(indexLowScoreO ),1)-1);      % T-Score
CI_Diff_LP(1,:) = mean(delta_Eta(indexLowScoreO ))' + ts.*SEM';            % Confidence Intervals

SEM = std(delta_invT(indexLowScoreO ))/sqrt(size(delta_invT(indexLowScoreO ),1));     % Standard Error
ts = tinv([0.05  0.95],size(delta_invT(indexLowScoreO ),1)-1);      % T-Score
CI_Diff_LP(2,:) = mean(delta_invT(indexLowScoreO ))' + ts.*SEM';            % Confidence Intervals

SEM = std(delta_PlayBias(indexLowScoreO ))/sqrt(size(delta_PlayBias(indexLowScoreO ),1));     % Standard Error
ts = tinv([0.05  0.95],size(delta_PlayBias(indexLowScoreO ),1)-1);      % T-Score
CI_Diff_LP(3,:) = mean(delta_PlayBias(indexLowScoreO ))' + ts.*SEM';            % Confidence Intervals

SEM = std(delta_LRItcpt(indexLowScoreO ))/sqrt(size(delta_LRItcpt(indexLowScoreO ),1));     % Standard Error
ts = tinv([0.05  0.95],size(delta_LRItcpt(indexLowScoreO ),1)-1);      % T-Score
CI_Diff_LP(4,:) = median(delta_LRItcpt(indexLowScoreO ))' + ts.*SEM';            % Confidence Intervals

SEM = std(delta_LRFeedConf(indexLowScoreO ))/sqrt(size(delta_LRFeedConf(indexLowScoreO ),1));     % Standard Error
ts = tinv([0.05  0.95],size(delta_LRFeedConf(indexLowScoreO ),1)-1);      % T-Score
CI_Diff_LP(5,:) = median(delta_LRFeedConf(indexLowScoreO ))' + ts.*SEM';            % Confidence Intervals


%% plot 

color    = get(groot,'DefaultAxesColorOrder');


paramLabels = {'Eta' 'invT' 'PlayBias' 'LRItcpt' 'LRFeedConf'};
figure(2);clf;
subplot(1,2,1)
set(gca, 'box', 'off')
nP=length(CI)-1;
hold on

[~, I]=sort(RegModall.Coefficients.Estimate(2:end));
sortWeights = RegModall.Coefficients.Estimate(I+1);

used=RegModall.Coefficients.Estimate(2:end);
Scale=max(max(abs(CI(2:end,:))));
xline(0, '--k',LineWidth=1)
plot( CI(I+1,:)', [1:nP; 1:nP],'-k',LineWidth=2)
plot(sortWeights, 1:nP,  'o', 'markerFaceColor', color(1,:),'markerEdgeColor', 'k', 'lineWidth', 1, 'markerSize', 15)
ylim([0, nP+1])
xlabel('Predictor weight')

set(gca, 'ytick', 1:nP, 'yticklabels', paramLabels(I), 'box', 'off')
fig = gcf;
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 12 24];
set(gca, 'FontSize', 20)
ytickangle(30)

subplot(1,2,2)
set(gca, 'box', 'off')
nP=length(CI)-1;
hold on

used=RegModall.Coefficients.Estimate(2:end);
Scale=max(max(abs(CI_Diff_HP)));
xline(0, '--k',LineWidth=1)
plot(CI_Diff_HP(I,:)', [(.95:nP-.05); (.95:nP-.05)],'-k',LineWidth=2)
plot(Diff_HP(I), (.95:nP-.05),  'o', 'markerFaceColor', color(3,:),'markerEdgeColor', 'k', 'lineWidth', 1, 'markerSize', 15)

plot(CI_Diff_LP(I,:)', [(1.05:nP+.05); (1.05:nP+.05)],'-k',LineWidth=2)
plot(Diff_LP(I), (1.05:nP+.05),  'o', 'markerFaceColor', color(7,:),'markerEdgeColor', 'k', 'lineWidth', 1, 'markerSize', 15)
ylim([0, nP+1])
xlabel('\Delta PL / MH')

set(gca, 'ytick', 1:nP, 'yticklabels', paramLabels(I), 'box', 'off')
fig = gcf;
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 12 24];
set(gca, 'FontSize', 20)
ytickangle(30)
h = gcf;
h.Position = [47         494        1104         507];
print2pdf(fullfile(pwd,'FIgures',['GLM_overallPoints.pdf']),h,300)


%%

load('data/EtaSim_orginvT.mat')
%load('data/EtaSim.mat')
deltaPoints_deltaEta  = EndPOints_DS-EndPOints_PLS;

%high BL performer: 13  66 77

%index = [13 47 52 66 77 79];

index = [13 47 52 66];
deltaPoints_deltaEta(index)

EtaStuff(1,:) = EtaPLS;
EtaStuff(2,:) = EtaDrug;

EtaPLBigger_all = length(find(EtaStuff(1,:)>EtaStuff(2,:)))/94;
EtaPLBigger_LBP = length(find(EtaStuff(1,indexLowScoreO)>EtaStuff(2,indexLowScoreO)))/length(indexLowScoreO);
EtaPLBigger_HBP = length(find(EtaStuff(1,indexHighScoreO)>EtaStuff(2,indexHighScoreO)))/length(indexHighScoreO);


color    = get(groot,'DefaultAxesColorOrder');

figure(3);clf;
subplot(1,3,1)
Scale=[ min(EtaStuff(:)),max(EtaStuff(:))];
hold on
plot(Scale, Scale, '--k',LineWidth=2); hold on
plot(EtaStuff(1,indexLowScoreO), EtaStuff(2,indexLowScoreO), 'o', 'markerSize', 15, 'markerFaceColor', color(7,:), 'markerEdgeColor', 'k', 'lineWidth', 1)
plot(EtaStuff(1,indexHighScoreO), EtaStuff(2,indexHighScoreO), 'o', 'markerSize', 15, 'markerFaceColor', color(3,:), 'markerEdgeColor', 'k', 'lineWidth', 1)
plot(EtaStuff(1,index), EtaStuff(2,index), 'x', 'markerSize', 25, 'markerFaceColor', "None", 'markerEdgeColor', 'r', 'lineWidth', 5)
ylim(Scale)
xlim(Scale)
ylabel('Eta MH')
xlabel('Eta PL')

subplot(1,3,2)
p       = polyfit(etaValue,Points,4);
x1      = linspace(0,1,1000);
y1      = polyval(p,x1);
highscore = max(y1);

plot(etaValue,Points,'o')
hold on
plot(x1,y1,LineWidth=3)
xline(x1(y1==highscore),LineWidth=2)
xline(.24,LineWidth=3,Color=[0.6350 0.0780 0.1840])% low orientation MPH
xline(.33,LineWidth=3,Color=[0.4940 0.1840 0.5560])% low orientation PLA
%xline(.33,LineWidth=3,Color=[0.4940 0.1840 0.5560])% low orientation PLA
plot(EtaStuff(2,index(1)),320, 'o', 'markerSize', 15, 'markerFaceColor', color(3,:), 'markerEdgeColor', 'k', 'lineWidth', 3)
plot(EtaStuff(1,index(1)),320, 'o', 'markerSize', 15, 'markerFaceColor', color(3,:), 'markerEdgeColor', 'r', 'lineWidth', 3)
plot(EtaStuff(2,index(2)),380, 'o', 'markerSize', 15, 'markerFaceColor', color(7,:), 'markerEdgeColor', 'k', 'lineWidth', 3)
plot(EtaStuff(1,index(2)),380, 'o', 'markerSize', 15, 'markerFaceColor', color(7,:), 'markerEdgeColor', 'r', 'lineWidth', 3)
plot(EtaStuff(2,index(3)),440, 'o', 'markerSize', 15, 'markerFaceColor', color(7,:), 'markerEdgeColor', 'k', 'lineWidth', 3)
plot(EtaStuff(1,index(3)),440, 'o', 'markerSize', 15, 'markerFaceColor', color(7,:), 'markerEdgeColor', 'r', 'lineWidth', 3)
plot(EtaStuff(2,index(4)),500, 'o', 'markerSize', 15, 'markerFaceColor', color(3,:), 'markerEdgeColor', 'k', 'lineWidth', 3)
plot(EtaStuff(1,index(4)),500, 'o', 'markerSize', 15, 'markerFaceColor', color(3,:), 'markerEdgeColor', 'r', 'lineWidth', 3)
ylabel('Points');xlabel('Eta')


% RegCoef_PL  = [702.0213  -54.1537  118.4083 -117.8429  233.0931  131.5619];
% RegCoef_MPH = [736.5957  -35.3403  118.4915  -60.8042  288.9191  148.1168];
% 
% 
% %delta_RegCoef = RegCoef_PL-RegCoef_MPH;
% 
% delta_RegCoef = RegCoef_MPH-RegCoef_PL;
% 
% 
% DeltaPoints_all     = nan(94,1);
% DeltaPoints_Eta     = nan(94,1);
% DeltaPoints_invT    = nan(94,1);
% DeltaPoints_LRItcpt = nan(94,1);
% DeltaPoints_PlayBias = nan(94,1);
% DeltaPoints_LRFeedConf= nan(94,1);
% 
% for i = 1:94 
% 
%     DeltaPoints_all(i) = delta_RegCoef(1) + delta_RegCoef(2)*delta_Eta(i) + ...
%         delta_RegCoef(3)*delta_invT(i) + delta_RegCoef(4)*delta_PlayBias(i) + ...
%          delta_RegCoef(4)*delta_LRItcpt(i) + delta_RegCoef(5)*delta_LRFeedConf(i);
% 
%     DeltaPoints_Eta(i)          = delta_RegCoef(1) + delta_RegCoef(2)*delta_Eta(i);
%     DeltaPoints_LRItcpt(i)      = delta_RegCoef(4)*delta_LRItcpt(i);
%     DeltaPoints_invT(i)         = delta_RegCoef(3)*delta_invT(i);
%     DeltaPoints_PlayBias(i)     = delta_RegCoef(4)*delta_PlayBias(i);
%     DeltaPoints_LRFeedConf(i)   = delta_RegCoef(5)*delta_LRFeedConf(i);
% 
% end
% 
% deltaPoints  = EndPOints_DS-EndPOints_PLS;
% 
% [rall,pall]    = corr(deltaPoints(indexHighScoreO),DeltaPoints_all(indexHighScoreO));
% [rall2,pall2]  = corr(deltaPoints(indexLowScoreO),DeltaPoints_all(indexLowScoreO));
% 
% [r3,p3]        = corr(deltaPoints,DeltaPoints_Eta);
% [r4,p4]        = corr(deltaPoints(indexLowScoreO),DeltaPoints_Eta(indexLowScoreO));
% 
% [r5,p5]        = corr(deltaPoints,DeltaPoints_LRItcpt);
% [r6,p6]        = corr(deltaPoints(indexLowScoreO),DeltaPoints_LRItcpt(indexLowScoreO));
% 
% [r7,p7]        = corr(deltaPoints,DeltaPoints_PlayBias);
% [r8,p8]        = corr(deltaPoints(indexLowScoreO),DeltaPoints_PlayBias(indexLowScoreO));
% 
% [r9,p9]        = corr(deltaPoints,DeltaPoints_LRFeedConf);
% [r10,p10]      = corr(deltaPoints(indexLowScoreO),DeltaPoints_LRFeedConf(indexLowScoreO));
% 
% [r11,p11]      = corr(deltaPoints,DeltaPoints_invT);
% [r12,p12]      = corr(deltaPoints(indexLowScoreO),DeltaPoints_invT(indexLowScoreO));
% 
% mean(DeltaPoints_all)
% mean(deltaPoints)
% mean(DeltaPoints_Eta)
indexLowScoreO_noOut = indexLowScoreO;
indexLowScoreO_noOut(5) = [];
load("data/DeltaPoints_Eta_orgInvT.mat");
[r_poly1_HP,p_poly1_HP]         = corr(DeltaPoints(:,indexHighScoreO)');
[r_poly1_LP_all,p_poly1_LP_all] = corr(DeltaPoints(:,indexLowScoreO)','type','Spearman');

subplot(1,3,3)
load("data/DeltaPoints_Eta_orgInvT.mat");
scatter(DeltaPoints(2,indexLowScoreO),DeltaPoints(1,indexLowScoreO));hold on
%Fit1 = polyfit(DeltaPoints(2,indexLowScoreO_noOut),DeltaPoints(1,indexLowScoreO_noOut),1);
Fit1 = polyfit(DeltaPoints(2,indexLowScoreO),DeltaPoints(1,indexLowScoreO),1);

rl(1) = refline(Fit1(1),Fit1(2));   
rl(1).LineWidth = 2;rl(1).Color=color(7,:);

scatter(DeltaPoints(2,indexHighScoreO),DeltaPoints(1,indexHighScoreO));hold on
Fit2 = polyfit(DeltaPoints(2,indexHighScoreO),DeltaPoints(1,indexHighScoreO),1);
rl(2) = refline(Fit2(1),Fit2(2));   
rl(2).LineWidth = 2;rl(2).Color=color(3,:);

plot(DeltaPoints(2,indexLowScoreO),DeltaPoints(1,indexLowScoreO), 'o', 'markerSize', 15, 'markerFaceColor', color(7,:), 'markerEdgeColor', 'k', 'lineWidth', 1)
plot(DeltaPoints(2,indexHighScoreO),DeltaPoints(1,indexHighScoreO), 'o', 'markerSize', 15, 'markerFaceColor', color(3,:), 'markerEdgeColor', 'k', 'lineWidth', 1)

% scatter(deltaPoints(indexLowScoreO),DeltaPoints_all(indexLowScoreO));hold on
% Fit1 = polyfit(deltaPoints(indexLowScoreO),DeltaPoints_all(indexLowScoreO),1);
% rl(1) = refline(Fit1(1),Fit1(2));   
% rl(1).LineWidth = 2;rl(1).Color=color(7,:);
% 
% scatter(deltaPoints(indexHighScoreO),DeltaPoints_all(indexHighScoreO));hold on
% Fit2 = polyfit(deltaPoints(indexHighScoreO),DeltaPoints_all(indexHighScoreO),1);
% rl(2) = refline(Fit2(1),Fit2(2));   
% rl(2).LineWidth = 2;rl(2).Color=color(3,:);
% 
% plot(deltaPoints(indexLowScoreO), DeltaPoints_all(indexLowScoreO), 'o', 'markerSize', 15, 'markerFaceColor', color(7,:), 'markerEdgeColor', 'k', 'lineWidth', 1)
% plot(deltaPoints(indexHighScoreO), DeltaPoints_all(indexHighScoreO), 'o', 'markerSize', 15, 'markerFaceColor', color(3,:), 'markerEdgeColor', 'k', 'lineWidth', 1)
 
xlabel('Predicted performance difference')
ylabel('\Delta Points off-drug to on-drug')

h = gcf;
h.Position = [ 125         449        1604         504];
print2pdf(fullfile(pwd,'FIgures',['Eta_Points_Stuff.pdf']),h,300)
ert

%%

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

index  = MPH;

% define IV's and DV's 
Points  = [EndPOints_DS;EndPOints_PLS];

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

Points  = nanzscore(Points(index));


% 1. model

ModN = 'Points';
M.DesignM = nanrem(table(Eta_Reg,invT_Reg,PlayBias_Reg,LRItcpt_Reg,LRFeedConf_Reg, Points));
M.labels    = { {'low' 'high'} {'low' 'high'} {'low' 'high'} {'low' 'high'} {'low' 'high'} };
M.CatVars   = [                                                                     ];
M.modelspec = 'Points ~ Eta_Reg + invT_Reg + PlayBias_Reg + LRItcpt_Reg + LRFeedConf_Reg';
LF          = 'normal';

RegModall   = fitglm(M.DesignM, M.modelspec, 'CategoricalVars', M.CatVars,'Distribution', LF,'Options',statset('MaxIter',1000));
CI          = coefCI(RegModall);

RegModall.Rsquared.Ordinary
RegModall.Rsquared.Adjusted

RegModall.Coefficients.Estimate'

%%

RegCoef_PL  = [702.0213  -54.1537  118.4083 -117.8429  233.0931  131.5619];
RegCoef_MPH = [736.5957  -35.3403  118.4915  -60.8042  288.9191  148.1168];


%delta_RegCoef = RegCoef_PL-RegCoef_MPH;

delta_RegCoef = RegCoef_MPH-RegCoef_PL;


DeltaPoints_all         = nan(94,1);
DeltaPoints_Eta         = nan(94,1);
DeltaPoints_LRItcpt     = nan(94,1);

color    = get(groot,'DefaultAxesColorOrder');
for i = 1:94 

    DeltaPoints_all(i) = delta_RegCoef(1) + delta_RegCoef(2)*delta_Eta(i) + ...
        delta_RegCoef(3)*delta_invT(i) + delta_RegCoef(4)*delta_PlayBias(i) + ...
         delta_RegCoef(4)*delta_LRItcpt(i) + delta_RegCoef(5)*delta_LRFeedConf(i);

    DeltaPoints_Eta(i) = delta_RegCoef(1) + delta_RegCoef(2)*delta_Eta(i);

    DeltaPoints_LRItcpt(i) = delta_RegCoef(1) + delta_RegCoef(4)*delta_LRItcpt(i);

end

deltaPoints  = EndPOints_DS-EndPOints_PLS;

[r1,p1]        = corr(deltaPoints(indexHighScoreO),DeltaPoints_all(indexHighScoreO));
[r2,p2]        = corr(deltaPoints(indexLowScoreO),DeltaPoints_all(indexLowScoreO));

mean(DeltaPoints_all)
mean(deltaPoints)
mean(DeltaPoints_Eta)


subplot(1,3,3)
scatter(deltaPoints(indexLowScoreO),DeltaPoints_all(indexLowScoreO));hold on
Fit1 = polyfit(deltaPoints(indexLowScoreO),DeltaPoints_all(indexLowScoreO),1);
rl(1) = refline(Fit1(1),Fit1(2));   
rl(1).LineWidth = 2;rl(1).Color=color(7,:);

scatter(deltaPoints(indexHighScoreO),DeltaPoints_all(indexHighScoreO));hold on
Fit2 = polyfit(deltaPoints(indexHighScoreO),DeltaPoints_all(indexHighScoreO),1);
rl(2) = refline(Fit2(1),Fit2(2));   
rl(2).LineWidth = 2;rl(2).Color=color(3,:);

plot(deltaPoints(indexLowScoreO), DeltaPoints_all(indexLowScoreO), 'o', 'markerSize', 15, 'markerFaceColor', color(7,:), 'markerEdgeColor', 'k', 'lineWidth', 1)
plot(deltaPoints(indexHighScoreO), DeltaPoints_all(indexHighScoreO), 'o', 'markerSize', 15, 'markerFaceColor', color(3,:), 'markerEdgeColor', 'k', 'lineWidth', 1)


index = indexLowScoreO;

DeltaPoints_all_reg = DeltaPoints_all(index);
deltaPoints_reg     = deltaPoints(index);

ModN = 'DeltaPoints';
M.DesignM = nanrem(table(DeltaPoints_all_reg,deltaPoints_reg));
M.labels    = { {'low' 'high'} };
M.CatVars   = [                                                                     ];
M.modelspec = 'deltaPoints_reg ~ DeltaPoints_all_reg';
LF          = 'normal';

RegModall   = fitglm(M.DesignM, M.modelspec, 'CategoricalVars', M.CatVars,'Distribution', LF,'Options',statset('MaxIter',1000));
CI          = coefCI(RegModall);

RegModall.Rsquared.Ordinary
RegModall.Rsquared.Adjusted

ert
% try this a different way using predictions from ployfit on simulation
Points  = [EndPOints_DS;EndPOints_PLS];
Eta_all = [EtaDrug;EtaPLS];

corr(Points,Eta_all)

corr(EndPOints_DS,EtaDrug)
corr(EndPOints_PLS,EtaPLS)

p_all    = polyfit(Points,Eta_all,4);

PredPoints_PL   =nan(length(EtaPLS),1);
PredPoints_MH   =nan(length(EtaPLS),1);

for i = 1:length(EtaPLS)
    PredPoints_PL(i) = polyval(p_all,EtaPLS(i));
    PredPoints_MH(i) = polyval(p_all,EtaDrug(i));
end


DeltaPoints_Poly  = PredPoints_MH-PredPoints_PL;

mean(DeltaPoints_Poly)

[r_poly1,p_poly1] = corr(zscore(deltaPoints),DeltaPoints_Poly);




%% Summary Figure
color    = get(groot,'DefaultAxesColorOrder');

Points_HBP(1)       = mean(EndPOints_PLS(indexHighScoreO));
Points_HBP(2)       = mean(EndPOints_DS(indexHighScoreO));
sePoints_HBP(1,1)   = mean(EndPOints_PLS(indexHighScoreO))-se(EndPOints_PLS(indexHighScoreO));
sePoints_HBP(1,2)   = mean(EndPOints_PLS(indexHighScoreO))+se(EndPOints_PLS(indexHighScoreO));
sePoints_HBP(2,1)   = mean(EndPOints_DS(indexHighScoreO))-se(EndPOints_DS(indexHighScoreO));
sePoints_HBP(2,2)   = mean(EndPOints_DS(indexHighScoreO))+se(EndPOints_DS(indexHighScoreO));


Points_LBP(1) = mean(EndPOints_PLS(indexLowScoreO));
Points_LBP(2) = mean(EndPOints_DS(indexLowScoreO));
sePoints_LBP(1,1)   = mean(EndPOints_PLS(indexLowScoreO))-se(EndPOints_PLS(indexLowScoreO));
sePoints_LBP(1,2)   = mean(EndPOints_PLS(indexLowScoreO))+se(EndPOints_PLS(indexLowScoreO));
sePoints_LBP(2,1)   = mean(EndPOints_DS(indexLowScoreO))-se(EndPOints_DS(indexLowScoreO));
sePoints_LBP(2,2)   = mean(EndPOints_DS(indexLowScoreO))+se(EndPOints_DS(indexLowScoreO));


% correct choice late learning less predictable rewards

CorCh_HBP(1)       = .91; 
CorCh_HBP(2)       = .91;
seCorCh_HBP(1,1)   = .91-.01;
seCorCh_HBP(1,2)   = .91+.01;
seCorCh_HBP(2,1)   = .91-.01;
seCorCh_HBP(2,2)   = .91+.01;

CorCh_LBP(1)       = .69;
CorCh_LBP(2)       = .74;
seCorCh_LBP(1,1)   = .69-.02;
seCorCh_LBP(1,2)   = .69+.02;
seCorCh_LBP(2,1)   = .74+.02;
seCorCh_LBP(2,2)   = .74-.02;

% eta 

Eta_HBP(1)       = mean(EtaPLS(indexHighScoreO));
Eta_HBP(2)       = mean(EtaDrug(indexHighScoreO));
seEta_HBP(1,1)   = mean(EtaPLS(indexHighScoreO))-se(EtaPLS(indexHighScoreO));
seEta_HBP(1,2)   = mean(EtaPLS(indexHighScoreO))+se(EtaPLS(indexHighScoreO));
seEta_HBP(2,1)   = mean(EtaDrug(indexHighScoreO))-se(EtaDrug(indexHighScoreO));
seEta_HBP(2,2)   = mean(EtaDrug(indexHighScoreO))+se(EtaDrug(indexHighScoreO));


Eta_LBP(1) = mean(EtaPLS(indexLowScoreO));
Eta_LBP(2) = mean(EtaDrug(indexLowScoreO));
seEta_LBP(1,1)   = mean(EtaPLS(indexLowScoreO))-se(EtaPLS(indexLowScoreO));
seEta_LBP(1,2)   = mean(EtaPLS(indexLowScoreO))+se(EtaPLS(indexLowScoreO));
seEta_LBP(2,1)   = mean(EtaDrug(indexLowScoreO))-se(EtaDrug(indexLowScoreO));
seEta_LBP(2,2)   = mean(EtaDrug(indexLowScoreO))+se(EtaDrug(indexLowScoreO));


figure(4);clf;
subplot(1,3,1)
plot([1:2; 1:2],sePoints_HBP','-k',LineWidth=2);hold on
plot((1:2),Points_HBP,  'o', 'markerFaceColor', color(3,:),'markerEdgeColor', 'k', 'lineWidth', 1, 'markerSize', 15)
plot((1:2),Points_HBP,  '-', 'Color', color(3,:), 'lineWidth', 3, 'markerSize', 15)

plot([1:2; 1:2],sePoints_LBP','-k',LineWidth=2);hold on
plot((1:2),Points_LBP,  'o', 'markerFaceColor', color(7,:),'markerEdgeColor', 'k', 'lineWidth', 1, 'markerSize', 15)
plot((1:2),Points_LBP,  '-', 'Color', color(7,:), 'lineWidth', 3, 'markerSize', 15)
ylim([350,1050]);xlim([.5,2.5]);
ylabel('Points')

subplot(1,3,2)
plot([1:2; 1:2],seCorCh_HBP','-k',LineWidth=2);hold on
plot((1:2),CorCh_HBP,  'o', 'markerFaceColor', color(3,:),'markerEdgeColor', 'k', 'lineWidth', 1, 'markerSize', 15)
plot((1:2),CorCh_HBP,  '-', 'Color', color(3,:), 'lineWidth', 3, 'markerSize', 15)

plot([1:2; 1:2],seCorCh_LBP','-k',LineWidth=2);hold on
plot((1:2),CorCh_LBP,  'o', 'markerFaceColor', color(7,:),'markerEdgeColor', 'k', 'lineWidth', 1, 'markerSize', 15)
plot((1:2),CorCh_LBP,  '-', 'Color', color(7,:), 'lineWidth', 3, 'markerSize', 15)
ylim([.6,1]);xlim([.5,2.5]);
ylabel('p(correct choice)')

subplot(1,3,3)
plot([1 2.05; 1 2.05],seEta_HBP','-k',LineWidth=2);hold on
plot([1 2.05],Eta_HBP,  'o', 'markerFaceColor', color(3,:),'markerEdgeColor', 'k', 'lineWidth', 1, 'markerSize', 15)
plot([1 2.05],Eta_HBP,  '-', 'Color', color(3,:), 'lineWidth', 3, 'markerSize', 15)

plot([1 1.95; 1 1.95],seEta_LBP','-k',LineWidth=2);hold on
plot([1 1.95],Eta_LBP,  'o', 'markerFaceColor', color(7,:),'markerEdgeColor', 'k', 'lineWidth', 1, 'markerSize', 15)
plot([1 1.95],Eta_LBP,  '-', 'Color', color(7,:), 'lineWidth', 3, 'markerSize', 15)
ylim([.2,.4]);xlim([.5,2.5]);
ylabel('Eta')

h=gcf;
h.Position=[152         499        1049         495];
print2pdf(fullfile(pwd,'FIgures',['SummaryFig.pdf']),h,300)


%% Delta other Params and points

figure(5);clf;
subplot(2,4,1)
load('data/invT_Sim_orginvT.mat')
p       = polyfit(invT_Value,Points,4);

x1      = linspace(min(invT_Value),max(invT_Value),1000);
y1      = polyval(p,x1);
highscore = max(y1);
plot(invT_Value,Points,'o')
hold on
plot(x1,y1,LineWidth=3)
ylabel('Points');xlabel('invT')

subplot(2,4,2)
PredPoints_PL = polyval(p,InvTPLS);
PredPoints_MH = polyval(p,InvTDrug);
DeltaPoints_Poly  = PredPoints_MH-PredPoints_PL;
load("data/DeltaPoints_Eta_orgInvT.mat");
DeltaPoints(2,:) = DeltaPoints_Poly;
scatter(DeltaPoints(1,:),DeltaPoints(2,:));hold on
refline
plot(DeltaPoints(1,:), DeltaPoints(2,:), 'o', 'markerSize', 8, 'markerFaceColor', color(2,:), 'markerEdgeColor', 'k', 'lineWidth', 1)
ylabel('Predicted \Delta points')
xlabel('\Delta Points off- / on-drug')
[r_invT,p_invT] = corr(DeltaPoints');


subplot(2,4,3)
load('data/playBias_Sim_orginvT.mat')
p       = polyfit(playBias_Value,Points,4);

x1      = linspace(min(playBias_Value),max(playBias_Value),1000);
y1      = polyval(p,x1);
highscore = max(y1);
plot(playBias_Value,Points,'o')
hold on
plot(x1,y1,LineWidth=3)
ylabel('Points');xlabel('Play Bias')

subplot(2,4,4)
PredPoints_PL = polyval(p,PlayBiasPLS);
PredPoints_MH = polyval(p,PlayBiasDrug);
DeltaPoints_Poly  = PredPoints_MH-PredPoints_PL;
load("data/DeltaPoints_Eta_orgInvT.mat");
DeltaPoints(2,:) = DeltaPoints_Poly;
DeltaPoints_2 =  DeltaPoints;
DeltaPoints_2(:,12) = [];

scatter(DeltaPoints_2(1,:),DeltaPoints_2(2,:));hold on
refline
plot(DeltaPoints(1,:), DeltaPoints(2,:), 'o', 'markerSize', 8, 'markerFaceColor', color(2,:), 'markerEdgeColor', 'k', 'lineWidth', 1)
ylabel('Predicted \Delta points')
xlabel('\Delta Points off- / on-drug')
[r_PlayBias,p_PlayBias] = corr(DeltaPoints_2');

subplot(2,4,5)
load('data/intcpt_Sim_orginvT.mat')
p       = polyfit(intcpt_Value,Points,4);

x1      = linspace(min(intcpt_Value),max(intcpt_Value),1000);
y1      = polyval(p,x1);
highscore = max(y1);
plot(intcpt_Value,Points,'o')
hold on
plot(x1,y1,LineWidth=3)
ylabel('Points');xlabel('LR intcpt')

subplot(2,4,6)
PredPoints_PL = polyval(p,LRIntcptPLS);
PredPoints_MH = polyval(p,LRIntcptDrug);
DeltaPoints_Poly  = PredPoints_MH-PredPoints_PL;
load("data/DeltaPoints_Eta_orgInvT.mat");
DeltaPoints(2,:) = DeltaPoints_Poly;
scatter(DeltaPoints(1,:),DeltaPoints(2,:));hold on
refline
plot(DeltaPoints(1,:), DeltaPoints(2,:), 'o', 'markerSize', 8, 'markerFaceColor', color(2,:), 'markerEdgeColor', 'k', 'lineWidth', 1)
ylabel('Predicted \Delta points')
xlabel('\Delta Points off- / on-drug')
[r_LRIntcpt,p_LRIntcpt] = corr(DeltaPoints');



subplot(2,4,7)
load('data/FeedConfrim_Sim_orginvT.mat')
p       = polyfit(FeedConfrim_Value,Points,4);

x1      = linspace(min(FeedConfrim_Value),max(FeedConfrim_Value),1000);
y1      = polyval(p,x1);
highscore = max(y1);
plot(FeedConfrim_Value,Points,'o')
hold on
plot(x1,y1,LineWidth=3)
ylabel('Points');xlabel('LR FeedConf')

subplot(2,4,8)
PredPoints_PL = polyval(p,LRFeedConfPLS);
PredPoints_MH = polyval(p,LRFeedConfDrug);
DeltaPoints_Poly  = PredPoints_MH-PredPoints_PL;
load("data/DeltaPoints_Eta_orgInvT.mat");
DeltaPoints(2,:) = DeltaPoints_Poly;
scatter(DeltaPoints(1,:),DeltaPoints(2,:));hold on
refline
plot(DeltaPoints(1,:), DeltaPoints(2,:), 'o', 'markerSize', 8, 'markerFaceColor', color(2,:), 'markerEdgeColor', 'k', 'lineWidth', 1)
ylabel('Predicted \Delta points')
xlabel('\Delta Points off- / on-drug')
[r_LRFeedConf,p_LRFeedConf] = corr(DeltaPoints');


h=gcf;
h.Position=[127         212        1330         789];
print2pdf(fullfile(pwd,'FIgures',['ParamSim_Performance.pdf']),h,300)


%%
%load('data/EtaSim_orginvT.mat')
load('data/EtaSim.mat')
deltaPoints_deltaEta  = EndPOints_DS-EndPOints_PLS;

%high BL performer: 13  66 77

%index = [13 47 52 66 77 79];

index = [13 47 52 66];
deltaPoints_deltaEta(index)

EtaStuff(1,:) = EtaPLS;
EtaStuff(2,:) = EtaDrug;

EtaPLBigger_all = length(find(EtaStuff(1,:)>EtaStuff(2,:)))/94;
EtaPLBigger_LBP = length(find(EtaStuff(1,indexLowScoreO)>EtaStuff(2,indexLowScoreO)))/length(indexLowScoreO);
EtaPLBigger_HBP = length(find(EtaStuff(1,indexHighScoreO)>EtaStuff(2,indexHighScoreO)))/length(indexHighScoreO);


color    = get(groot,'DefaultAxesColorOrder');

figure(3);clf;
subplot(1,3,1)
Scale=[ min(EtaStuff(:)),max(EtaStuff(:))];
hold on
plot(Scale, Scale, '--k',LineWidth=2); hold on
plot(EtaStuff(1,indexLowScoreO), EtaStuff(2,indexLowScoreO), 'o', 'markerSize', 15, 'markerFaceColor', color(7,:), 'markerEdgeColor', 'k', 'lineWidth', 1)
plot(EtaStuff(1,indexHighScoreO), EtaStuff(2,indexHighScoreO), 'o', 'markerSize', 15, 'markerFaceColor', color(3,:), 'markerEdgeColor', 'k', 'lineWidth', 1)
plot(EtaStuff(1,index), EtaStuff(2,index), 'x', 'markerSize', 25, 'markerFaceColor', "None", 'markerEdgeColor', 'r', 'lineWidth', 5)
ylim(Scale)
xlim(Scale)
ylabel('Eta MH')
xlabel('Eta PL')

subplot(1,3,2)
p       = polyfit(etaValue,Points,4);
x1      = linspace(0,1,1000);
y1      = polyval(p,x1);
highscore = max(y1);

plot(etaValue,Points,'o')
hold on
plot(x1,y1,LineWidth=3)
xline(x1(y1==highscore),LineWidth=2)
xline(.24,LineWidth=3,Color=[0.6350 0.0780 0.1840])% low orientation MPH
xline(.33,LineWidth=3,Color=[0.4940 0.1840 0.5560])% low orientation PLA
%xline(.33,LineWidth=3,Color=[0.4940 0.1840 0.5560])% low orientation PLA
plot(EtaStuff(2,index(1)),720, 'o', 'markerSize', 15, 'markerFaceColor', color(3,:), 'markerEdgeColor', 'k', 'lineWidth', 3)
plot(EtaStuff(1,index(1)),720, 'o', 'markerSize', 15, 'markerFaceColor', color(3,:), 'markerEdgeColor', 'r', 'lineWidth', 3)
plot(EtaStuff(2,index(2)),750, 'o', 'markerSize', 15, 'markerFaceColor', color(7,:), 'markerEdgeColor', 'k', 'lineWidth', 3)
plot(EtaStuff(1,index(2)),750, 'o', 'markerSize', 15, 'markerFaceColor', color(7,:), 'markerEdgeColor', 'r', 'lineWidth', 3)
plot(EtaStuff(2,index(3)),780, 'o', 'markerSize', 15, 'markerFaceColor', color(7,:), 'markerEdgeColor', 'k', 'lineWidth', 3)
plot(EtaStuff(1,index(3)),780, 'o', 'markerSize', 15, 'markerFaceColor', color(7,:), 'markerEdgeColor', 'r', 'lineWidth', 3)
plot(EtaStuff(2,index(4)),810, 'o', 'markerSize', 15, 'markerFaceColor', color(3,:), 'markerEdgeColor', 'k', 'lineWidth', 3)
plot(EtaStuff(1,index(4)),810, 'o', 'markerSize', 15, 'markerFaceColor', color(3,:), 'markerEdgeColor', 'r', 'lineWidth', 3)
ylabel('Points');xlabel('Eta')

indexLowScoreO_noOut = indexLowScoreO;
indexLowScoreO_noOut(5) = [];


subplot(1,3,3)
load("data/DeltaPoints_Eta_orgInvT.mat");

PredPoints_PL = polyval(p,EtaPLS);
PredPoints_MH = polyval(p,EtaDrug);
DeltaPoints_Poly  = PredPoints_MH-PredPoints_PL;
DeltaPoints(2,:) = DeltaPoints_Poly;

[r_poly1_LP,p_poly1_LP]         = corr(DeltaPoints(:,indexLowScoreO_noOut)');
[r_poly1_HP,p_poly1_HP]         = corr(DeltaPoints(:,indexHighScoreO)');
[r_poly1_LP_all,p_poly1_LP_all] = corr(DeltaPoints(:,indexLowScoreO)','tail','right');

scatter(DeltaPoints(1,indexLowScoreO),DeltaPoints(2,indexLowScoreO));hold on
Fit1 = polyfit(DeltaPoints(1,indexLowScoreO_noOut),DeltaPoints(2,indexLowScoreO_noOut),1);
rl(1) = refline(Fit1(1),Fit1(2));   
rl(1).LineWidth = 2;rl(1).Color=color(7,:);

scatter(DeltaPoints(1,indexHighScoreO),DeltaPoints(2,indexHighScoreO));hold on
Fit2 = polyfit(DeltaPoints(1,indexHighScoreO),DeltaPoints(2,indexHighScoreO),1);
rl(2) = refline(Fit2(1),Fit2(2));   
rl(2).LineWidth = 2;rl(2).Color=color(3,:);

plot(DeltaPoints(1,indexLowScoreO), DeltaPoints(2,indexLowScoreO), 'o', 'markerSize', 15, 'markerFaceColor', color(7,:), 'markerEdgeColor', 'k', 'lineWidth', 1)
plot(DeltaPoints(1,indexHighScoreO), DeltaPoints(2,indexHighScoreO), 'o', 'markerSize', 15, 'markerFaceColor', color(3,:), 'markerEdgeColor', 'k', 'lineWidth', 1)

ylabel('Predicted performance difference')
xlabel('\Delta Points off-drug to on-drug')

h = gcf;
h.Position = [ 125         449        1604         504];
print2pdf(fullfile(pwd,'FIgures',['Eta_Points_Stuff_fixedInvT.pdf']),h,300)
ert




