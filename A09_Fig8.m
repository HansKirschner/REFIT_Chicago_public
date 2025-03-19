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

load('data/RawInfoMA_V2.mat')
load('data/RawInfoPL_V2.mat')

load('data/all_EndPOints_PL.mat')
load('data/all_EndPOints_MA.mat')

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

%% Check how task performance maps on model parameters

% setup indecies

all     = 1:188;
MA     = 1:94;
PL     = 95:188;

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


% difference paramse PL - MH

delta_Eta          = Eta_Reg(PL)-Eta_Reg(MA);
delta_invT         = invT_Reg(PL)-invT_Reg(MA);
delta_PlayBias     = PlayBias_Reg(PL)-PlayBias_Reg(MA);
delta_LRItcpt      = LRItcpt_Reg(PL) -LRItcpt_Reg(MA);
delta_LRFeedConf   = LRFeedConf_Reg(PL)-LRFeedConf_Reg(MA);


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
figure(1);clf;
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
print2pdf(fullfile(pwd,'FIgures',['Fig8_GLM_overallPoints.pdf']),h,300)


%%

load('Data/EtaSim_orginvT.mat')

deltaPoints_deltaEta  = EndPOints_DS-EndPOints_PLS;


index = [13 47 52 66];
deltaPoints_deltaEta(index)

EtaStuff(1,:) = EtaPLS;
EtaStuff(2,:) = EtaDrug;

EtaPLBigger_all = length(find(EtaStuff(1,:)>EtaStuff(2,:)))/94;
EtaPLBigger_LBP = length(find(EtaStuff(1,indexLowScoreO)>EtaStuff(2,indexLowScoreO)))/length(indexLowScoreO);
EtaPLBigger_HBP = length(find(EtaStuff(1,indexHighScoreO)>EtaStuff(2,indexHighScoreO)))/length(indexHighScoreO);


color    = get(groot,'DefaultAxesColorOrder');

figure(2);clf;
subplot(1,2,1)
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

subplot(1,2,2)
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


h = gcf;
h.Position = [-2248         527         999         458];
print2pdf(fullfile(pwd,'FIgures',['Fig8Part2.pdf']),h,300)