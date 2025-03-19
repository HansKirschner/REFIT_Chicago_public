
clear
path('helper/',path)

load('Data/LR_Choice_MA.mat')
load('Data/LR_Choice_PL.mat')

load('Data/InfoSubjects.mat')
load('Data/SessionInfo.mat')
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
Session1(excluda_expSession)            = [];
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
Session1(indexExclude_missingO)         = [];
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
% These routines can be used by and distributed for non-profit academic
% purposes without any royalty except that the users must cite:
% Bai, Jushan and Pierre Perron (1998): "Estimating and Testing Linear
% Models with Multiple Structural Changes," Econometrica, vol 66,@47-78
% and Bai, Jushan and Pierre Perron (2003): "Computation and Analysis of
%  Multiple Structural Change Models," Journal of Applied Econometrics, 18, 1-22.
% For any other commercial use and/or comments, please contact Pierre
% Perron at perron at bu.edu.
% Even though we tried to make this program error-free we cannot be held
% responsible for any consequences that could result from remaining errors.
% Copyright, Pierre Perron (1999, 2004)


LearningCurve_Acq_all               = nan(2*94,30);
LearningCurve_1stReversal_all       = nan(2*94,30);
LearningCurve_all                   = nan(2*94,30);

LearningCurve_LC                   = nan(2*94,30);
LearningCurve_HC                   = nan(2*94,30);

LearningCurve_BadGood_all           = nan(2*94,30);
LearningCurve_GoodBad_all           = nan(2*94,30);

LearningCurve_BadNeutral_all        = nan(2*94,30);
LearningCurve_GoodNeutral_all       = nan(2*94,30);

GotIt                               = nan(2*94,1);

for i = 1:2
    for ii = 1:94

        if i == 1
            LearningCurve_Acq_all(ii+((i-1)*94),:)          = mean([LRc_P(ii).PcorrAcqisition],1);
            LearningCurve_1stReversal_all(ii+((i-1)*94),:)  = mean([LRc_P(ii).PcorrfirstReversal],1);
            LearningCurve_BadGood_all(ii+((i-1)*94),:)      = mean([LRc_P(ii).FractionChoiceBadtoGood],1);
            LearningCurve_GoodBad_all(ii+((i-1)*94),:)      = mean([LRc_P(ii).FractionChoiceGoodtoBad],1);

            LearningCurve_all(ii+((i-1)*94),:)              = nanmean([LRc_P(ii).FractionChoice],1);

            LearningCurve_LC(ii+((i-1)*94),:)               = nanmean([LRc_P(ii).PCorrLC],1);
            
            GotIt_all = nan(8,1);
            for iii = 1:6
                check = false;
                for iiii = 2:30
                        if LRc_P(ii).PCorrLC(iii,iiii-1)==1 && LRc_P(ii).PCorrLC(iii,iiii)==1 && check == false
                        
                            GotIt_all(iii)=iiii;
                            check = true;
                        end
                end

            end

            GotIt(ii+((i-1)*94)) = nanmean(GotIt_all);
            
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
            
            GotIt_all = nan(8,1);
            for iii = 1:6
                check = false;
                for iiii = 2:30
                        if LRc_D(ii).PCorrLC(iii,iiii-1)==1 && LRc_D(ii).PCorrLC(iii,iiii)==1  && check == false
                        
                            GotIt_all(iii)=iiii;
                            check = true;
                        end
                end

            end

            GotIt(ii+((i-1)*94)) = nanmean(GotIt_all);

            LearningCurve_HC(ii+((i-1)*94),:)              = nanmean([LRc_D(ii).PCorrHC],1);
            
            LearningCurve_BadNeutral_all(ii+((i-1)*94),:)   = mean([LRc_D(ii).FractionChoiceBadtoNeutral],1);
            LearningCurve_GoodNeutral_all(ii+((i-1)*94),:)  = mean([LRc_D(ii).FractionChoiceGoodtoNeutral],1);
        end
    end
end

%% 

ttestout(GotIt(indexLowScoreO),GotIt(indexLowScoreO_2),1);
ttestout(GotIt(1:94),GotIt(95:end),1);


%% Plot overall (note that in the manuscript figure we applied some smoothing)
color    = get(groot,'DefaultAxesColorOrder');

figure(1);clf;
subplot(2,3,1)
%xline(10,LineWidth=3);hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_all(1:94,:),1),0,0),se(LearningCurve_all(1:94,:),1),{'-o', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 3});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_all(95:end,:),1),0,0),se(LearningCurve_all(95:end,:),1),{'-o', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 3});hold on
%legend({'Placebo';'MPH'},'Location','best');
ylabel('Probability correct');xlabel('Trials');
%title('All Reversal all')

subplot(2,3,2)
%xline(10,LineWidth=3);hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_LC(1:94,:),1),0,0),se(LearningCurve_LC(1:94,:),1),{'-o', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 3});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_LC(95:end,:),1),0,0),se(LearningCurve_LC(95:end,:),1),{'-o', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 3});hold on
%legend({'Placebo';'MPH'},'Location','best');
ylabel('Probability correct');xlabel('Trials');
%title('30/70 reward prob all')

subplot(2,3,3)
%xline(10,LineWidth=3);hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_HC(1:94,:),1),0,0),se(LearningCurve_HC(1:94,:),1),{'-o', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 3});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_HC(95:end,:),1),0,0),se(LearningCurve_HC(95:end,:),1),{'-o', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 3});hold on
legend({'PL';'MA'},'Location','southeast');
ylabel('Probability correct');xlabel('Trials');
%title('20/80 reward prob all')

subplot(2,3,4)
%xline(10,LineWidth=3);hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_all(indexLowScoreO,:),1),0,0),se(LearningCurve_all(indexLowScoreO,:),1),{'-s', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 3});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_all(indexLowScoreO_2,:),1),0,0),se(LearningCurve_all(indexLowScoreO_2,:),1),{'-s', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 3});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_all(indexHighScoreO,:),1),0,0),se(LearningCurve_all(indexHighScoreO,:),1),{'-^', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 3});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_all(indexHighScoreO_2,:),1),0,0),se(LearningCurve_all(indexHighScoreO_2,:),1),{'-^', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 3});hold on
%legend({'PL_l_o_w';'MPH_l_o_w'; 'PL_h_i_g_h';'MPH_h_i_g_h'},'Location','best');
ylabel('Probability correct');xlabel('Trials');
%title('All Reversal orientation performance split')

subplot(2,3,5)
%xline(10,LineWidth=3);hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_LC(indexLowScoreO,:),1),0,0),se(LearningCurve_LC(indexLowScoreO,:),1),{'-s', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 3});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_LC(indexLowScoreO_2,:),1),0,0),se(LearningCurve_LC(indexLowScoreO_2,:),1),{'-s', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 3});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_LC(indexHighScoreO,:),1),0,0),se(LearningCurve_LC(indexHighScoreO,:),1),{'-^', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 3});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_LC(indexHighScoreO_2,:),1),0,0),se(LearningCurve_LC(indexHighScoreO_2,:),1),{'-^', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 3});hold on
%legend({'PL_l_o_w';'MPH_l_o_w'; 'PL_h_i_g_h';'MPH_h_i_g_h'},'Location','best');
ylabel('Probability correct');xlabel('Trials');
%title('30/70 reward prob  orientation performance split')

subplot(2,3,6)
%xline(10,LineWidth=3);hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_HC(indexLowScoreO,:),1),0,0),se(LearningCurve_HC(indexLowScoreO,:),1),{'-s', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 3});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_HC(indexLowScoreO_2,:),1),0,0),se(LearningCurve_HC(indexLowScoreO_2,:),1),{'-s', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 3});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_HC(indexHighScoreO,:),1),0,0),se(LearningCurve_HC(indexHighScoreO,:),1),{'-^', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 3});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_HC(indexHighScoreO_2,:),1),0,0),se(LearningCurve_HC(indexHighScoreO_2,:),1),{'-^', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 3});hold on
legend({'PL_l_o_w';'MA_l_o_w'; 'PL_h_i_g_h';'MA_h_i_g_h'},'Location','southeast');

ylabel('Probability correct');xlabel('Trials');
%title('30/70 reward prob  orientation performance split')

h = gcf;
h.Position = [206         131        1234         870];
print2pdf(fullfile(pwd,'Figures',['LearningCurvesChoice_MAvsPL_shortPic_nosmoothing.pdf']),h,300)


%% plot learning curves split up by orientation performance

figure(2);clf;
subplot(2,3,1)
shadedErrBar([],mean(LearningCurve_all(indexLowScoreO,:),1),se(LearningCurve_all(indexLowScoreO,:),1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 4, 'lineWidth', 2});hold on
shadedErrBar([],mean(LearningCurve_all(indexLowScoreO_2,:),1),se(LearningCurve_all(indexLowScoreO_2,:),1),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 4, 'lineWidth', 2});hold on

shadedErrBar([],mean(LearningCurve_all(indexHighScoreO,:),1),se(LearningCurve_all(indexHighScoreO,:),1),{'-s', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 4, 'lineWidth', 2});hold on
shadedErrBar([],mean(LearningCurve_all(indexHighScoreO_2,:),1),se(LearningCurve_all(indexHighScoreO_2,:),1),{'-s', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 4, 'lineWidth', 2});hold on

legend({'Pl lowPO';'MPH lowPO'; 'Pl highPO';'MPH highPO'},'Location','best');
ylabel('Probability correct');xlabel('Trials');
title('All Reversal')

subplot(2,3,2)
shadedErrBar([],mean(LearningCurve_Acq_all(indexLowScoreO,:),1),se(LearningCurve_Acq_all(indexLowScoreO,:),1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 4, 'lineWidth', 2});hold on
shadedErrBar([],mean(LearningCurve_Acq_all(indexLowScoreO_2,:),1),se(LearningCurve_Acq_all(indexLowScoreO_2,:),1),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 4, 'lineWidth', 2});hold on

shadedErrBar([],mean(LearningCurve_Acq_all(indexHighScoreO,:),1),se(LearningCurve_Acq_all(indexHighScoreO,:),1),{'-s', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 4, 'lineWidth', 2});hold on
shadedErrBar([],mean(LearningCurve_Acq_all(indexHighScoreO_2,:),1),se(LearningCurve_Acq_all(indexHighScoreO_2,:),1),{'-s', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 4, 'lineWidth', 2});hold on

ylabel('Probability correct');xlabel('Trials');
title('Acqusition')

subplot(2,3,3)
shadedErrBar([],mean(LearningCurve_1stReversal_all(indexLowScoreO,:),1),se(LearningCurve_1stReversal_all(indexLowScoreO,:),1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 4, 'lineWidth', 2});hold on
shadedErrBar([],mean(LearningCurve_1stReversal_all(indexLowScoreO_2,:),1),se(LearningCurve_1stReversal_all(indexLowScoreO_2,:),1),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 4, 'lineWidth', 2});hold on

shadedErrBar([],mean(LearningCurve_1stReversal_all(indexHighScoreO,:),1),se(LearningCurve_1stReversal_all(indexHighScoreO,:),1),{'-s', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 4, 'lineWidth', 2});hold on
shadedErrBar([],mean(LearningCurve_1stReversal_all(indexHighScoreO_2,:),1),se(LearningCurve_1stReversal_all(indexHighScoreO_2,:),1),{'-s', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 4, 'lineWidth', 2});hold on

ylabel('Probability correct');xlabel('Trials');
title('1st reversal')

subplot(2,4,5)
shadedErrBar([],mean(LearningCurve_BadGood_all(indexLowScoreO,:),1),se(LearningCurve_BadGood_all(indexLowScoreO,:),1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 4, 'lineWidth', 2});hold on
shadedErrBar([],mean(LearningCurve_BadGood_all(indexLowScoreO_2,:),1),se(LearningCurve_BadGood_all(indexLowScoreO_2,:),1),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 4, 'lineWidth', 2});hold on

shadedErrBar([],mean(LearningCurve_BadGood_all(indexHighScoreO,:),1),se(LearningCurve_BadGood_all(indexHighScoreO,:),1),{'-s', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 4, 'lineWidth', 2});hold on
shadedErrBar([],mean(LearningCurve_BadGood_all(indexHighScoreO_2,:),1),se(LearningCurve_BadGood_all(indexHighScoreO_2,:),1),{'-s', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 4, 'lineWidth', 2});hold on

ylabel('Probability to select');xlabel('Trials');
title('Bad to good option')

subplot(2,4,6)
shadedErrBar([],mean(LearningCurve_GoodBad_all(indexLowScoreO,:),1),se(LearningCurve_GoodBad_all(indexLowScoreO,:),1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 4, 'lineWidth', 2});hold on
shadedErrBar([],mean(LearningCurve_GoodBad_all(indexLowScoreO_2,:),1),se(LearningCurve_GoodBad_all(indexLowScoreO_2,:),1),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 4, 'lineWidth', 2});hold on

shadedErrBar([],mean(LearningCurve_GoodBad_all(indexHighScoreO,:),1),se(LearningCurve_GoodBad_all(indexHighScoreO,:),1),{'-s', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 4, 'lineWidth', 2});hold on
shadedErrBar([],mean(LearningCurve_GoodBad_all(indexHighScoreO_2,:),1),se(LearningCurve_GoodBad_all(indexHighScoreO_2,:),1),{'-s', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 4, 'lineWidth', 2});hold on

ylabel('Probability to select');xlabel('Trials');
title('Good to bad option')

subplot(2,4,7)
shadedErrBar([],mean(LearningCurve_BadNeutral_all(indexLowScoreO,:),1),se(LearningCurve_BadNeutral_all(indexLowScoreO,:),1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 4, 'lineWidth', 2});hold on
shadedErrBar([],mean(LearningCurve_BadNeutral_all(indexLowScoreO_2,:),1),se(LearningCurve_BadNeutral_all(indexLowScoreO_2,:),1),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 4, 'lineWidth', 2});hold on

shadedErrBar([],mean(LearningCurve_BadNeutral_all(indexHighScoreO,:),1),se(LearningCurve_BadNeutral_all(indexHighScoreO,:),1),{'-s', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 4, 'lineWidth', 2});hold on
shadedErrBar([],mean(LearningCurve_BadNeutral_all(indexHighScoreO_2,:),1),se(LearningCurve_BadNeutral_all(indexHighScoreO_2,:),1),{'-s', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 4, 'lineWidth', 2});hold on

ylabel('Probability to select');xlabel('Trials');
title('Bad to neutral option')


subplot(2,4,8)
shadedErrBar([],mean(LearningCurve_GoodNeutral_all(indexLowScoreO,:),1),se(LearningCurve_GoodNeutral_all(1:94,:),1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 4, 'lineWidth', 2});hold on
shadedErrBar([],mean(LearningCurve_GoodNeutral_all(indexLowScoreO_2,:),1),se(LearningCurve_GoodNeutral_all(95:end,:),1),{'-o', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 4, 'lineWidth', 2});hold on

shadedErrBar([],mean(LearningCurve_GoodNeutral_all(indexHighScoreO,:),1),se(LearningCurve_GoodNeutral_all(indexLowScoreO,:),1),{'-s', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 4, 'lineWidth', 2});hold on
shadedErrBar([],mean(LearningCurve_GoodNeutral_all(indexHighScoreO_2,:),1),se(LearningCurve_GoodNeutral_all(indexHighScoreO_2,:),1),{'-s', 'color', [0.6350 0.0780 0.1840], 'markerfacecolor',[0.6350 0.0780 0.1840], 'markerSize', 4, 'lineWidth', 2});hold on

ylabel('Probability to select');xlabel('Trials');
title('Good to neutral option')

h = gcf;
h.Position = [-2110         242        1287         772];
print2pdf(fullfile(pwd,'Figures',['LearningCurves_MPHvsPL_OP_Split.pdf']),h,300)


%% calculate break points in the learning curves

bigt=30;                  % set effective sample size
y=mean(LearningCurve_all)';            % set up the data, y is the dependent variable z is 
                           % the matrix of regressors (bigt,q) whose coefficients 
                           % are allowed to change, x is a (bigt,p) matrix of 
                           % regressors with coefficients fixed across regimes. 
                           % Note: initialize x to [] if p=0.
z=ones(bigt,1);

x=[];

q=1;                      % number of regressors z
p=0;                      % number of regressors x 
m=2;                      % maximum number of structural changes allowed
eps1=.15;                 % value of the trimming (in percentage) for the construction 
                          % and critical values of the supF type tests (used in the 
                          % supF test, the Dmax, the supF(l+1|l) and the sequential 
                          % procedure). If these tests are used, h below should be set 
                          % at int(eps1*bigt). But if the tests are not required, 
                          % estimation can be done with an arbitrary h. There are five 
                          % options: eps1= .05, .10, .15, .20, or .25. For each option, 
                          % the maximal value of m above is: 10 for eps=.05, 8 for 
                          % eps1=.10, 5 for eps1=.15, 3 for eps1=.20, and 2 for eps1=.25.

h=round(eps1*bigt);       % minimal length of a segment (h >= q). Note: if robust=1, h 
                          % should be set at a larger value. 

% The followings are options if p > 0 -------------------------------                          
fixb=0;                   % set to 1 if use fixed initial values for beta
betaini=0;                % if fixb=1, load the initial value of beta
maxi=20;                  % maximum number of iterations for the nonlinear procedure to 
                          % obtain global minimizers
printd=1;                 % set to 1 if want the output from the iterations to be printed
eps=0.0001;               % criterion for the convergence
% --------------------------------------------------------------------
robust=1;                % set to 1 if want to allow for heterogeneity and autocorrelation 
                         % in the residuals, 0 otherwise. The method used is Andrews(1991) 
                         % automatic bandwidth with AR(1) approximation and the quadratic 
                         % kernel. Note: Do not set to 1 if lagged dependent variables are 
                         % included as regressors.
prewhit=1;               % set to 1 if want to apply AR(1) prewhitening prior to estimating 
                         % the long run covariance matrix.
hetdat=1;                % option for the construction of the F tests. Set to 1 if want to
                         % allow different moment matrices of the regressors across segments. 
                         % If hetdat=0, the same moment matrices are assumed for each segment 
                         % and estimated from the ful sample. It is recommended to set 
                         % hetdat=1 if p>0.
hetvar=1;                % option for the construction of the F tests.Set to 1 if want to allow 
                         % for the variance of the residuals to be different across segments. 
                         % If hetvar=0, the variance of the residuals is assumed constant 
                         % across segments and constructed from the ful sample. This option 
                         % is not available when robust=1.  
hetomega=1;              % used in the construction of the confidence intervals for the break 
                         % dates. If hetomega=0, the long run covariance matrix of zu is 
                         % assumed identical across segments (the variance of the errors u 
                         % if robust=0)
hetq=1;                  % used in the construction of the confidence intervals for the break 
                         % dates. If hetq=0, the moment matrix of the data is assumed identical 
                         % across segments.
doglobal=1;              % set to 1 if want to cal the procedure to obtain global minimizers
dotest=1;                % set to 1 if want to construct the supF, UDmax and WDmax tests 
                         % doglobal must be set to 1 to run this procedure.
dospflp1=1;              % set to 1 if want to construct the supF(l+1|l) tests where under
                         % the null the l breaks are obtained using global minimizers. 
                         % doglobal must be set to 1 to run this procedure.
doorder=1;               % set to 1 if want to cal the procedure that selects the number of
                         % breaks using information criteria. doglobal must be set to 1 to 
                         % run this procedure.
dosequa=1;               % set to 1 if want to estimate the breaks sequentialy and estimate 
                         % the number of breaks using supF(l+1|l) test   
dorepart=1;              % set to 1 if want to modify the break dates obtained from the 
                         % sequential method using the repartition method of Bai (1995),
                         % Estimating breaks one at a time. This is needed for the confidence 
                         % intervals obtained with estim below to be valid.
estimbic=1;              % set to 1 if want to estimate the model with the number of breaks 
                         % selected by BIC.
estimlwz=0;              % set to 1 if want to estimate the model with the number of breaks  
                         % selected by LWZ
estimseq=1;              % set to 1 if want to estimate the model with the number of breaks
                         % selected using the sequential procedure
estimrep=0;              % set to 1 if want to estimate the model with the breaks selected
                         % using the repartition method
estimfix=0;              % set to 1 if want to estimate the model with a prespecified number
                         % of breaks equal to fixn set below
fixn=0;

pbreak(bigt,y,z,q,m,h,eps1,robust,prewhit,hetomega,hetq,doglobal,dotest,dospflp1,doorder,dosequa,dorepart,estimbic,estimlwz,estimseq,estimrep,estimfix,fixb,x,p,eps,maxi,betaini,printd,hetdat,hetvar,fixn)

%% P(corr) - break at 10

% ANOVA early learning
group = repmat("Gr_A",94,1);
group(indexHighScoreO) = "Gr_B";   

SessionGroup = repmat("Gr_A",94,1);
SessionGroup(Session1==1) = "Gr_B"; 

%% Acq 
clc;
ttestout(mean(LearningCurve_Acq_all(1:94,1:9),2),mean(LearningCurve_Acq_all(95:end,1:9),2),1);
ttestout(mean(LearningCurve_Acq_all(1:94,10:end),2),mean(LearningCurve_Acq_all(95:end,10:end),2),1);

% ANOVA early learning
t_DrugEffect_allreversal_Acq_all_1 = table(group,mean(LearningCurve_Acq_all(1:94,1:9),2),mean(LearningCurve_Acq_all(95:end,1:9),2),...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_allreversal_Acq_all_1,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);
ranovatbl_Acq_all_1 = ranova(rm,'WithinModel','TimePoints'); 


% Session Control

% ANOVA early learning
t_DrugEffect_allreversal_Acq_all_1_SC = table(group,SessionGroup,mean(LearningCurve_Acq_all(1:94,1:9),2),mean(LearningCurve_Acq_all(95:end,1:9),2),...
    'VariableNames',{'Group','Session','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_allreversal_Acq_all_1_SC,'PointsSession1-PointsSession2 ~ Group:Session','WithinDesign',Session);
ranovatbl_Acq_all_1_SC = ranova(rm,'WithinModel','TimePoints'); 


% ANOVA late learning
t_DrugEffect_allreversal_Acq_all_2 = table(group,mean(LearningCurve_Acq_all(1:94,10:end),2),mean(LearningCurve_Acq_all(95:end,10:end),2),...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_allreversal_Acq_all_2,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);
ranovatbl_Acq_all_2 = ranova(rm,'WithinModel','TimePoints'); 

% post hoc t-tests
ttestout(mean(LearningCurve_Acq_all(indexLowScoreO,1:9),2),mean(LearningCurve_Acq_all(indexLowScoreO_2,1:9),2),1);
ttestout(mean(LearningCurve_Acq_all(indexLowScoreO,10:end),2),mean(LearningCurve_Acq_all(indexLowScoreO_2,10:end),2),1);

ttestout(mean(LearningCurve_Acq_all(indexHighScoreO,1:9),2),mean(LearningCurve_Acq_all(indexHighScoreO_2,1:9),2),1);
ttestout(mean(LearningCurve_Acq_all(indexHighScoreO,10:end),2),mean(LearningCurve_Acq_all(indexHighScoreO_2,10:end),2),1);

%% 1st Reversal
ttestout(mean(LearningCurve_1stReversal_all(1:94,1:9),2),mean(LearningCurve_1stReversal_all(95:end,1:9),2),1);
ttestout(mean(LearningCurve_1stReversal_all(1:94,10:end),2),mean(LearningCurve_1stReversal_all(95:end,10:end),2),1);

% ANOVA early learning
t_DrugEffect_allreversal_1stReversal_all_1 = table(group,mean(LearningCurve_1stReversal_all(1:94,1:9),2),mean(LearningCurve_1stReversal_all(95:end,1:9),2),...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_allreversal_1stReversal_all_1,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);
ranovatbl_1stReversal_all_1 = ranova(rm,'WithinModel','TimePoints'); 

% ANOVA late learning
t_DrugEffect_allreversal_1stReversal_all_2 = table(group,mean(LearningCurve_1stReversal_all(1:94,10:end),2),mean(LearningCurve_1stReversal_all(95:end,10:end),2),...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_allreversal_1stReversal_all_2,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);
ranovatbl_1stReversal_all_2 = ranova(rm,'WithinModel','TimePoints'); 

% post hoc t-tests
ttestout(mean(LearningCurve_1stReversal_all(indexLowScoreO,1:9),2),mean(LearningCurve_1stReversal_all(indexLowScoreO_2,1:9),2),1);
ttestout(mean(LearningCurve_1stReversal_all(indexLowScoreO,10:end),2),mean(LearningCurve_1stReversal_all(indexLowScoreO_2,10:end),2),1);

ttestout(mean(LearningCurve_1stReversal_all(indexHighScoreO,1:9),2),mean(LearningCurve_1stReversal_all(indexHighScoreO_2,1:9),2),1);
ttestout(mean(LearningCurve_1stReversal_all(indexHighScoreO,10:end),2),mean(LearningCurve_1stReversal_all(indexHighScoreO_2,10:end),2),1);

%% all Reversal
ttestout(mean(LearningCurve_all(1:94,1:9),2),mean(LearningCurve_all(95:end,1:9),2),1);
ttestout(mean(LearningCurve_all(1:94,10:end),2),mean(LearningCurve_all(95:end,10:end),2),1);

% ANOVA early learning
group = repmat("Gr_A",94,1);
group(indexHighScoreO) = "Gr_B";    

t_DrugEffect_allreversal_1 = table(group,mean(LearningCurve_all(1:94,1:9),2),mean(LearningCurve_all(95:end,1:9),2),...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_allreversal_1,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);
ranovatbl_allreversal_1 = ranova(rm,'WithinModel','TimePoints'); 

% ANOVA late learning
t_DrugEffect_allreversal_2 = table(group,mean(LearningCurve_all(1:94,10:end),2),mean(LearningCurve_all(95:end,10:end),2),...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_allreversal_2,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);
ranovatbl_allreversal_2 = ranova(rm,'WithinModel','TimePoints'); 

% post hoc t-tests
ttestout(mean(LearningCurve_all(indexLowScoreO,1:9),2),mean(LearningCurve_all(indexLowScoreO_2,1:9),2),1);
ttestout(mean(LearningCurve_all(indexLowScoreO,10:end),2),mean(LearningCurve_all(indexLowScoreO_2,10:end),2),1);

ttestout(mean(LearningCurve_all(indexHighScoreO,1:9),2),mean(LearningCurve_all(indexHighScoreO_2,1:9),2),1);
ttestout(mean(LearningCurve_all(indexHighScoreO,10:end),2),mean(LearningCurve_all(indexHighScoreO_2,10:end),2),1);

%% all Reversal low certainty
clc;
ttestout(mean(LearningCurve_LC(1:94,1:9),2),mean(LearningCurve_LC(95:end,1:9),2),1);
ttestout(mean(LearningCurve_LC(1:94,10:end),2),mean(LearningCurve_LC(95:end,10:end),2),1);

% ANOVA early learning
t_DrugEffect_allreversal_LC_1 = table(group,mean(LearningCurve_LC(1:94,1:9),2),mean(LearningCurve_LC(95:end,1:9),2),...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_allreversal_LC_1,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);
ranovatbl_allreversal_1 = ranova(rm,'WithinModel','TimePoints'); 

% ANOVA late learning
t_DrugEffect_allreversal_LC_2 = table(group,mean(LearningCurve_LC(1:94,10:end),2),mean(LearningCurve_LC(95:end,10:end),2),...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_allreversal_LC_2,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);
ranovatbl_allreversal_2 = ranova(rm,'WithinModel','TimePoints'); 


% Session Control

% ANOVA early learning
t_DrugEffect_allreversal_LC_2_SC = table(group,SessionGroup,mean(LearningCurve_LC(1:94,1:9),2),mean(LearningCurve_LC(95:end,1:9),2),...
    'VariableNames',{'Group','Session','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_allreversal_LC_2_SC,'PointsSession1-PointsSession2 ~ Group:Session','WithinDesign',Session);
ranovatbl_LowC_late_SC = ranova(rm,'WithinModel','TimePoints'); 

% post hoc t-tests
ttestout(mean(LearningCurve_LC(indexLowScoreO,1:9),2),mean(LearningCurve_LC(indexLowScoreO_2,1:9),2),1);
ttestout(mean(LearningCurve_LC(indexLowScoreO,10:end),2),mean(LearningCurve_LC(indexLowScoreO_2,10:end),2),1);

ttestout(mean(LearningCurve_LC(indexHighScoreO,1:9),2),mean(LearningCurve_LC(indexHighScoreO_2,1:9),2),1);
ttestout(mean(LearningCurve_LC(indexHighScoreO,10:end),2),mean(LearningCurve_LC(indexHighScoreO_2,10:end),2),1);

%% all Reversal high certainty
clc;
ttestout(mean(LearningCurve_HC(1:94,1:9),2),mean(LearningCurve_HC(95:end,1:9),2),1);
ttestout(mean(LearningCurve_HC(1:94,10:end),2),mean(LearningCurve_HC(95:end,10:end),2),1);

% ANOVA early learning
t_DrugEffect_allreversal_HC_1 = table(group,mean(LearningCurve_HC(1:94,1:9),2),mean(LearningCurve_HC(95:end,1:9),2),...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_allreversal_HC_1,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);
ranovatbl_allreversal_1 = ranova(rm,'WithinModel','TimePoints'); 

% ANOVA late learning
t_DrugEffect_allreversal_HC_2 = table(group,mean(LearningCurve_HC(1:94,10:end),2),mean(LearningCurve_HC(95:end,10:end),2),...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_allreversal_HC_2,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);
ranovatbl_allreversal_2 = ranova(rm,'WithinModel','TimePoints'); 

% post hoc t-tests
ttestout(mean(LearningCurve_HC(indexLowScoreO,1:9),2),mean(LearningCurve_HC(indexLowScoreO_2,1:9),2),1);
ttestout(mean(LearningCurve_HC(indexLowScoreO,10:end),2),mean(LearningCurve_HC(indexLowScoreO_2,10:end),2),1);

ttestout(mean(LearningCurve_HC(indexHighScoreO,1:9),2),mean(LearningCurve_HC(indexHighScoreO_2,1:9),2),1);
ttestout(mean(LearningCurve_HC(indexHighScoreO,10:end),2),mean(LearningCurve_HC(indexHighScoreO_2,10:end),2),1);

%% Bad to Good
clc;
ttestout(mean(LearningCurve_BadGood_all(1:94,1:9),2),mean(LearningCurve_BadGood_all(95:end,1:9),2),1);
ttestout(mean(LearningCurve_BadGood_all(1:94,10:end),2),mean(LearningCurve_BadGood_all(95:end,10:end),2),1);

% ANOVA early learning
t_DrugEffect_allreversal_BadGood_all_1 = table(group,mean(LearningCurve_BadGood_all(1:94,1:9),2),mean(LearningCurve_BadGood_all(95:end,1:9),2),...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_allreversal_BadGood_all_1,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);
ranovatbl_BadGood_all_1 = ranova(rm,'WithinModel','TimePoints'); 

% ANOVA late learning
t_DrugEffect_allreversal_BadGood_all_2 = table(group,mean(LearningCurve_BadGood_all(1:94,10:end),2),mean(LearningCurve_BadGood_all(95:end,10:end),2),...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_allreversal_BadGood_all_2,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);
ranovatbl_BadGood_all_2 = ranova(rm,'WithinModel','TimePoints'); 

% post hoc t-tests
ttestout(mean(LearningCurve_BadGood_all(indexLowScoreO,1:9),2),mean(LearningCurve_BadGood_all(indexLowScoreO_2,1:9),2),1);
ttestout(mean(LearningCurve_BadGood_all(indexLowScoreO,10:end),2),mean(LearningCurve_BadGood_all(indexLowScoreO_2,10:end),2),1);

ttestout(mean(LearningCurve_BadGood_all(indexHighScoreO,1:9),2),mean(LearningCurve_BadGood_all(indexHighScoreO_2,1:9),2),1);
ttestout(mean(LearningCurve_BadGood_all(indexHighScoreO,10:end),2),mean(LearningCurve_BadGood_all(indexHighScoreO_2,10:end),2),1);

%% Good to Bad
clc;
ttestout(mean(LearningCurve_GoodBad_all(1:94,1:9),2),mean(LearningCurve_GoodBad_all(95:end,1:9),2),1);
ttestout(mean(LearningCurve_GoodBad_all(1:94,10:end),2),mean(LearningCurve_GoodBad_all(95:end,10:end),2),1);

% ANOVA early learning
t_DrugEffect_allreversal_GoodBad_all_1 = table(group,mean(LearningCurve_GoodBad_all(1:94,1:9),2),mean(LearningCurve_GoodBad_all(95:end,1:9),2),...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});


rm = fitrm(t_DrugEffect_allreversal_GoodBad_all_1,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);
ranovatbl_GoodBad_all_1 = ranova(rm,'WithinModel','TimePoints'); 

% ANOVA late learning
t_DrugEffect_allreversal_GoodBad_all_2 = table(group,mean(LearningCurve_GoodBad_all(1:94,10:end),2),mean(LearningCurve_GoodBad_all(95:end,10:end),2),...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect_allreversal_GoodBad_all_2,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);
ranovatbl_GoodBad_all_2 = ranova(rm,'WithinModel','TimePoints'); 

% post hoc t-tests
ttestout(mean(LearningCurve_GoodBad_all(indexLowScoreO,1:9),2),mean(LearningCurve_GoodBad_all(indexLowScoreO_2,1:9),2),1);
ttestout(mean(LearningCurve_GoodBad_all(indexLowScoreO,10:end),2),mean(LearningCurve_GoodBad_all(indexLowScoreO_2,10:end),2),1);

ttestout(mean(LearningCurve_GoodBad_all(indexHighScoreO,1:9),2),mean(LearningCurve_GoodBad_all(indexHighScoreO_2,1:9),2),1);
ttestout(mean(LearningCurve_GoodBad_all(indexHighScoreO,10:end),2),mean(LearningCurve_GoodBad_all(indexHighScoreO_2,10:end),2),1);


% %% add Data to big data table
% load("Data/REFIT_Chicago_Data_long.mat")
% 
% ttestout(mean(LearningCurve_HC(1:94,1:9),2),mean(LearningCurve_HC(95:end,1:9),2),1);
% ttestout(mean(LearningCurve_HC(1:94,10:end),2),mean(LearningCurve_HC(95:end,10:end),2),1);
% ttestout(mean(LearningCurve_LC(1:94,10:end),2),mean(LearningCurve_LC(95:end,10:end),2),1);
% 
% LR_all_early    = mean(LearningCurve_all(:,1:9),2);
% LR_all_late     = mean(LearningCurve_all(:,10:end),2);
% 
% LR_HC_early    = mean(LearningCurve_HC(:,1:9),2);
% LR_HC_late     = mean(LearningCurve_HC(:,10:end),2);
% 
% LR_LC_early    = mean(LearningCurve_LC(:,1:9),2);
% LR_LC_late     = mean(LearningCurve_LC(:,10:end),2);
% 
% addOnTable = nanrem(table(LR_all_early,LR_all_late,LR_LC_early,LR_LC_late,LR_HC_early,LR_HC_late)); 
% 
% REFIT_Chicago_DataM =[REFIT_Chicago_DataM,addOnTable];
% 
% save("Data/REFIT_Chicago_Data_long.mat","REFIT_Chicago_DataM")
% writetable(REFIT_Chicago_DataM, 'Data/REFIT_Chicago_Data_long.csv');

ttestOut_AgainstX(LearningCurve_all(1:94,1),.5);
ttestOut_AgainstX(LearningCurve_HC(1:94,1),.5);
ttestOut_AgainstX(LearningCurve_LC(1:94,1),.5);
