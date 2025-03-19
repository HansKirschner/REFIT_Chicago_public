
clear
path('helper/',path)

load('Data/LR_MA.mat')
%load('Data/Learning_curves_Orientation.mat')
load('Data/LR_PL.mat')
load('Data/InfoSubjects.mat')
load('Data/all_EndPOints_Orientation.mat');
load('Data/MA_wGenPrior_fminconResult_111110.mat')
EtaDrug         = fminconResult.fitParams(:,3);
load('Data/PL_wGenPriors_fminconResult_111110.mat')
EtaPLS         = fminconResult.fitParams(:,3);

%% exclusion of subjects 
% (exclusion criteria: no participantion in the 
% orientation session and high proportion of misses (see data extraction 
% scripts in the data folder))

% Orientation
excluda_O                               = [26,79,86];
excluda_expSession                      = [30,60,90,97];
ID(excluda_expSession)                  = [];
LRc_D(excluda_expSession)               = [];
LRc_P(excluda_expSession)               = [];
EndPOints_O(excluda_O)                  = [];
EtaPLS(excluda_expSession)                       = [];
EtaDrug(excluda_expSession)                      = [];

Shortname(excluda_O)                    = [];
LIA                                     = ismember(ID,Shortname,'rows');
indexExclude_missingO                   = find(LIA==0)';
LRc_D(indexExclude_missingO)            = [];
LRc_P(indexExclude_missingO)            = [];
EtaPLS(indexExclude_missingO)           = [];
EtaDrug(indexExclude_missingO)          = [];

split = median(EndPOints_O);

indexLowScoreO  = find(EndPOints_O<=split);
indexHighScoreO = find(EndPOints_O>split);

indexLowScoreO_2  = indexLowScoreO+94;
indexHighScoreO_2 = indexHighScoreO+94;



splitDrug = median(EtaDrug);

indexLowEtaDrug  = find(EtaDrug<=splitDrug);
indexHighEtaDrug = find(EtaDrug>splitDrug);

splitPLS= median(EtaPLS);

indexLowEtaPLS  = find(EtaPLS<=splitPLS)+94;
indexHighEtaPLS = find(EtaPLS>splitPLS)+94;

IndexlowEta     = [indexLowEtaDrug;indexLowEtaPLS];
IndexHighEta    = [indexHighEtaDrug;indexHighEtaPLS];

%%

LearningCurve_Acq_all               = nan(2*94,30);
LearningCurve_1stReversal_all       = nan(2*94,30);
LearningCurve_all                   = nan(2*94,30);

LearningCurve_LC                   = nan(2*94,30);
LearningCurve_HC                   = nan(2*94,30);

LearningCurve_BadGood_all           = nan(2*94,30);
LearningCurve_GoodBad_all           = nan(2*94,30);

LearningCurve_BadNeutral_all        = nan(2*94,30);
LearningCurve_GoodNeutral_all       = nan(2*94,30);


for i = 1:2
    for ii = 1:94

        if i == 1
            LearningCurve_Acq_all(ii+((i-1)*94),:)          = mean([LRc_P(ii).PcorrAcqisition],1);
            LearningCurve_1stReversal_all(ii+((i-1)*94),:)  = mean([LRc_P(ii).PcorrfirstReversal],1);
            LearningCurve_BadGood_all(ii+((i-1)*94),:)      = mean([LRc_P(ii).FractionChoiceBadtoGood],1);
            LearningCurve_GoodBad_all(ii+((i-1)*94),:)      = mean([LRc_P(ii).FractionChoiceGoodtoBad],1);

            LearningCurve_all(ii+((i-1)*94),:)              = nanmean([LRc_P(ii).FractionChoice],1);

            LearningCurve_LC(ii+((i-1)*94),:)               = nanmean([LRc_P(ii).PCorrLC],1);
            LearningCurve_HC(ii+((i-1)*94),:)               = nanmean([LRc_P(ii).PCorrHC],1);
            
            LearningCurve_BadNeutral_all(ii+((i-1)*94),:)   = mean([LRc_P(ii).FractionChoiceBadtoNeutral],1);
            LearningCurve_GoodNeutral_all(ii+((i-1)*94),:)  = mean([LRc_P(ii).FractionChoiceGoodtoNeutral],1);
        end
        if i == 2
            LearningCurve_Acq_all(ii+((i-1)*94),:)          = mean([LRc_D(ii).PcorrAcqisition],1);
            LearningCurve_1stReversal_all(ii+((i-1)*94),:)  = mean([LRc_D(ii).PcorrfirstReversal],1);
            LearningCurve_BadGood_all(ii+((i-1)*94),:)      = mean([LRc_D(ii).FractionChoiceBadtoGood],1);
            LearningCurve_GoodBad_all(ii+((i-1)*94),:)      = mean([LRc_D(ii).FractionChoiceGoodtoBad],1);

            LearningCurve_all(ii+((i-1)*94),:)              = nanmean([LRc_D(ii).FractionChoice],1);  
            
            LearningCurve_LC(ii+((i-1)*94),:)              = nanmean([LRc_D(ii).PCorrLC],1);
            LearningCurve_HC(ii+((i-1)*94),:)              = nanmean([LRc_D(ii).PCorrHC],1);
            
            LearningCurve_BadNeutral_all(ii+((i-1)*94),:)   = mean([LRc_D(ii).FractionChoiceBadtoNeutral],1);
            LearningCurve_GoodNeutral_all(ii+((i-1)*94),:)  = mean([LRc_D(ii).FractionChoiceGoodtoNeutral],1);
        end
    end
end

sum(mean(LearningCurve_all(indexLowScoreO,11:end))>.5)

sum(mean(LearningCurve_LC(indexLowScoreO,11:end))>.5)

sum(mean(LearningCurve_all(indexHighScoreO,11:end))>.5)
sum(mean(LearningCurve_LC(indexHighScoreO,11:end))>.5)


%% Plot overall 
color    = get(groot,'DefaultAxesColorOrder');

figure(1);clf;
subplot(3,3,1)
shadedErrBar([],AGF_running_average(mean(LearningCurve_all(1:94,:),1),0,0),se(LearningCurve_all(1:94,:),1),{'-o', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 2});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_all(95:end,:),1),0,0),se(LearningCurve_all(95:end,:),1),{'-o', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 2});hold on
legend({'PL';'MA'},'Location','northeast');
ylabel('Learning rate');xlabel('Trials after reversal');
%title('All Reversal all')
ylim([0.3 .8])

subplot(3,3,7)
shadedErrBar([],AGF_running_average(mean(LearningCurve_LC(1:94,:),1),0,0),se(LearningCurve_LC(1:94,:),1),{'-o', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 2});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_LC(95:end,:),1),0,0),se(LearningCurve_LC(95:end,:),1),{'-o', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 2});hold on
%legend({'Placebo';'MA'},'Location','best');
ylabel('Learning rate');xlabel('Trials after reversal');
%title('30/70 reward prob all')
ylim([0.3 .8])

subplot(3,3,4)
shadedErrBar([],AGF_running_average(mean(LearningCurve_HC(1:94,:),1),0,0),se(LearningCurve_HC(1:94,:),1),{'-o', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 2});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_HC(95:end,:),1),0,0),se(LearningCurve_HC(95:end,:),1),{'-o', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 2});hold on
%legend({'Placebo';'MA'},'Location','best');
ylabel('Learning rate');xlabel('Trials after reversal');
%title('20/80 reward prob all')
ylim([0.3 .8])

subplot(3,3,2)
shadedErrBar([],AGF_running_average(mean(LearningCurve_all(indexLowScoreO,:),1),0,0),se(LearningCurve_all(indexLowScoreO,:),1),{'-s', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 2});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_all(indexLowScoreO_2,:),1),0,0),se(LearningCurve_all(indexLowScoreO_2,:),1),{'-s', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 2});hold on
%shadedErrBar([],AGF_running_average(mean(LearningCurve_all(indexHighScoreO,:),1),0,0),se(LearningCurve_all(indexHighScoreO,:),1),{'-s', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 6, 'lineWidth', 2});hold on
%shadedErrBar([],AGF_running_average(mean(LearningCurve_all(indexHighScoreO_2,:),1),0,0),se(LearningCurve_all(indexHighScoreO_2,:),1),{'-s', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 6, 'lineWidth', 2});hold on
legend({'PL_l_o_w';'MA_l_o_w'},'Location','northeast');
%ylabel('LR');
xlabel('Trials after reversal');
%title('All Reversal orientation performance split')
ylim([0.3 .8])

subplot(3,3,8)
shadedErrBar([],AGF_running_average(mean(LearningCurve_LC(indexLowScoreO,:),1),0,0),se(LearningCurve_LC(indexLowScoreO,:),1),{'-s', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 2});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_LC(indexLowScoreO_2,:),1),0,0),se(LearningCurve_LC(indexLowScoreO_2,:),1),{'-s', 'color',color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 2});hold on
%shadedErrBar([],AGF_running_average(mean(LearningCurve_LC(indexHighScoreO,:),1),0,0),se(LearningCurve_LC(indexHighScoreO,:),1),{'-s', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 6, 'lineWidth', 2});hold on
%shadedErrBar([],AGF_running_average(mean(LearningCurve_LC(indexHighScoreO_2,:),1),0,0),se(LearningCurve_LC(indexHighScoreO_2,:),1),{'-s', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 6, 'lineWidth', 2});hold on
%legend({'PL_l_o_w';'MPH_l_o_w'; 'PL_h_i_g_h';'MPH_h_i_g_h'},'Location','best');
xlabel('Trials after reversal');
%title('30/70 reward prob  orientation performance split')
ylim([0.3 .8])

subplot(3,3,5)
shadedErrBar([],AGF_running_average(mean(LearningCurve_HC(indexLowScoreO,:),1),0,0),se(LearningCurve_HC(indexLowScoreO,:),1),{'-s', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 2});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_HC(indexLowScoreO_2,:),1),0,0),se(LearningCurve_HC(indexLowScoreO_2,:),1),{'-s', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 2});hold on
%shadedErrBar([],AGF_running_average(mean(LearningCurve_HC(indexHighScoreO,:),1),0,0),se(LearningCurve_HC(indexHighScoreO,:),1),{'-s', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 6, 'lineWidth', 2});hold on
%shadedErrBar([],AGF_running_average(mean(LearningCurve_HC(indexHighScoreO_2,:),1),0,0),se(LearningCurve_HC(indexHighScoreO_2,:),1),{'-s', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 6, 'lineWidth', 2});hold on
%legend({'PL_l_o_w';'MA_l_o_w'},'Location','best');
xlabel('Trials after reversal');
%title('20/80 reward prob orientation performance split')
ylim([0.3 .8])

subplot(3,3,3)
%shadedErrBar([],AGF_running_average(mean(LearningCurve_all(indexLowScoreO,:),1),0,0),se(LearningCurve_all(indexLowScoreO,:),1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 6, 'lineWidth', 2});hold on
%shadedErrBar([],AGF_running_average(mean(LearningCurve_all(indexLowScoreO_2,:),1),0,0),se(LearningCurve_all(indexLowScoreO_2,:),1),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 6, 'lineWidth', 2});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_all(indexHighScoreO,:),1),0,0),se(LearningCurve_all(indexHighScoreO,:),1),{'-^', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 2});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_all(indexHighScoreO_2,:),1),0,0),se(LearningCurve_all(indexHighScoreO_2,:),1),{'-^', 'color',color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 2});hold on
legend({'PL_h_i_g_h';'MPH_h_i_g_h'},'Location','northeast');
xlabel('Trials after reversal');
%title('All Reversal orientation performance split')
ylim([0.3 .8])

subplot(3,3,9)
%shadedErrBar([],AGF_running_average(mean(LearningCurve_LC(indexLowScoreO,:),1),0,0),se(LearningCurve_LC(indexLowScoreO,:),1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 6, 'lineWidth', 2});hold on
%shadedErrBar([],AGF_running_average(mean(LearningCurve_LC(indexLowScoreO_2,:),1),0,0),se(LearningCurve_LC(indexLowScoreO_2,:),1),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 6, 'lineWidth', 2});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_LC(indexHighScoreO,:),1),0,0),se(LearningCurve_LC(indexHighScoreO,:),1),{'-^', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 2});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_LC(indexHighScoreO_2,:),1),0,0),se(LearningCurve_LC(indexHighScoreO_2,:),1),{'-^', 'color',color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 2});hold on
%legend({'PL_l_o_w';'MA_l_o_w'; 'PL_h_i_g_h';'MA_h_i_g_h'},'Location','best');
xlabel('Trials after reversal');
%title('30/70 reward prob  orientation performance split')
ylim([0.3 .8])

subplot(3,3,6)
%shadedErrBar([],AGF_running_average(mean(LearningCurve_HC(indexLowScoreO,:),1),0,0),se(LearningCurve_HC(indexLowScoreO,:),1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 6, 'lineWidth', 2});hold on
%shadedErrBar([],AGF_running_average(mean(LearningCurve_HC(indexLowScoreO_2,:),1),0,0),se(LearningCurve_HC(indexLowScoreO_2,:),1),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 6, 'lineWidth', 2});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_HC(indexHighScoreO,:),1),0,0),se(LearningCurve_HC(indexHighScoreO,:),1),{'-^', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 2});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_HC(indexHighScoreO_2,:),1),0,0),se(LearningCurve_HC(indexHighScoreO_2,:),1),{'-^', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 2});hold on
%legend({'PL_h_i_g_h';'MA_h_i_g_h'},'Location','best');
xlabel('Trials after reversal');
%title('20/80 reward prob orientation performance split')
ylim([0.3 .8])

h = gcf;
h.Position = [445          63        1071         938];
print2pdf(fullfile(pwd,'Figures',['LearningRates_newColor.pdf']),h,300)
