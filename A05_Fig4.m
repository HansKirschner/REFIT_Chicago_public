clear

path('helper/',path);

rootDir                 = pwd;
fminconDir              = fullfile(rootDir,'Data/fminconResults/woPriors/');

% read data names
files = dir ([fminconDir  '*.mat']);

for i = 1:length(files)
    
    load([fminconDir files(i).name ])

    ModelE.CompareBIC(i,:)= fminconResult.BIC;
    ModelE.negLogLike(i,:)= fminconResult.negLogLike;

end


[posteriorBIC,outBIC] = VBA_groupBMC(-ModelE.CompareBIC/2);


sumBIC =  sum(ModelE.CompareBIC,2);

% nice colors
cols    = get(groot,'DefaultAxesColorOrder');


figure(2);clf;
h = bar(outBIC.ep,'FaceColor','k');hold on
h.FaceAlpha = 0.7;
bar(outBIC.Ef,0.5,'FaceColor',cols(1,:))
set(gca, 'YLim', [min(outBIC.ep)*+.95 max(outBIC.ep)*1.05])
f = gcf;

print2pdf(fullfile(pwd,'Figures',['MSFig4_ModelComparision.pdf']),f,300)

%% 
clear
rootDir = pwd;

load('Data/MA_wGenPrior_fminconResult_111110.mat')
load('Data/fminconResults/MA_wGenPrior_fminconResult_111110.mat')

InvTDrug        = fminconResult.fitParams(:,1);
PlayBiasDrug    = fminconResult.fitParams(:,2);
EtaDrug         = fminconResult.fitParams(:,3);
LRIntcptDrug    = fminconResult.fitParams(:,4);
LRFeedConfDrug  = fminconResult.fitParams(:,5);


load('Data/PL_wGenPriors_fminconResult_111110.mat')
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

% endpoints
EndPOints_PLS(indexExclude_missingO)    = [];
EndPOints_DS(indexExclude_missingO)     = [];

split = median(EndPOints_O);

indexLowScoreO  = find(EndPOints_O<=split);
indexHighScoreO = find(EndPOints_O>split);


figure(3),clf;
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
print2pdf(fullfile(pwd,'Figures',['MSFig4_ParamComparison_split.pdf']),h,300)

%% Revsion - check distirbution of inverse temperature accross drug-sessions

color    = get(groot,'DefaultAxesColorOrder');
figure(1);clf;
plot(InvTPLS(indexLowScoreO), InvTDrug(indexLowScoreO), 'o', 'markerSize', 15, 'markerFaceColor',color(1,:), 'markerEdgeColor', 'k', 'lineWidth', 1); hold on;
plot(InvTPLS(indexHighScoreO), InvTDrug(indexHighScoreO), 'o', 'markerSize', 15, 'markerFaceColor',color(3,:), 'markerEdgeColor', 'k', 'lineWidth', 1); hold on;
legend('Low Baseline Performance', 'High Baseline Performance',Location='best')
xlabel('InvT PL')
ylabel('InvT MA')
plot([0 5],[0 5], '--k', 'LineWidth', 1.5); 
h = gcf;
h.Position = [ -1949         480         560         420];
print2pdf(fullfile(pwd,'Figures',['InvTDistribution.pdf']),h,300)

[p, ~, stats]        = signrank(InvTPLS,InvTDrug);
[p_LP, ~, stats_LP]  = signrank(InvTPLS(indexLowScoreO),InvTDrug(indexLowScoreO));
[p_HP, ~, stats_HP]  = signrank(InvTPLS(indexHighScoreO),InvTDrug(indexHighScoreO));

%% exclusion of subjects
clear
load('data/MA_BehavSum.mat')
load('data/PL_BehavSum.mat')
load('data/O_BehavSum.mat')

load('data/InfoSubjects.mat')
load('data/all_EndPOints_Orientation.mat')
load('data/all_EndPOints_PL.mat')
load('data/all_EndPOints_MA.mat')


% Orientation
excluda_O                           = [26,79,86];
excluda_expSession                  = [30,60,90,97];
ID(excluda_expSession)              = [];


O_choice(:,excluda_O)          = [];
O_Prob(:,excluda_O)            = [];
O_ChoiceProb(:,excluda_O)      = [];
O_LR(:,excluda_O)              = [];
O_Stimno(:,excluda_O)          = [];
O_ProbChange(:,excluda_O)      = [];
O_EV(:,excluda_O)              = [];
O_RPE(:,excluda_O)             = [];
O_minSimPC(:,excluda_O)        = [];
O_maxSimPC(:,excluda_O)        = [];

O_Points_mean(excluda_O)       = [];
O_Points_median(excluda_O)     = [];
O_lowCIChoice(:,excluda_O)     = [];
O_highCIChoice(:,excluda_O)    = [];
O_idealLR(:,excluda_O)         = [];


P_choice(:,excluda_expSession)          = [];
P_Prob(:,excluda_expSession)            = [];
P_ChoiceProb(:,excluda_expSession)      = [];
P_LR(:,excluda_expSession)              = [];
P_Stimno(:,excluda_expSession)          = [];
P_ProbChange(:,excluda_expSession)      = [];
P_EV(:,excluda_expSession)              = [];
P_RPE(:,excluda_expSession)             = [];
P_minSimPC(:,excluda_expSession)        = [];
P_maxSimPC(:,excluda_expSession)        = [];
P_Points_mean(excluda_expSession)       = [];
P_Points_median(excluda_expSession)     = [];
P_lowCIChoice(:,excluda_expSession)        = [];
P_highCIChoice(:,excluda_expSession)        = [];


D_choice(:,excluda_expSession)          = [];
D_Prob(:,excluda_expSession)            = [];
D_ChoiceProb(:,excluda_expSession)      = [];
D_LR(:,excluda_expSession)              = [];
D_Stimno(:,excluda_expSession)          = [];
D_ProbChange(:,excluda_expSession)      = [];
D_EV(:,excluda_expSession)              = [];
D_RPE(:,excluda_expSession)             = [];
D_minSimPC(:,excluda_expSession)        = [];
D_maxSimPC(:,excluda_expSession)        = [];
D_Points_mean(excluda_expSession)       = [];
D_Points_median(excluda_expSession)     = [];
D_lowCIChoice(:,excluda_expSession)        = [];
D_highCIChoice(:,excluda_expSession)        = [];

Shortname(excluda_O)                        = [];
EndPOints_O(excluda_O)                      = [];

EndPOints_DS(excluda_expSession)            = [];
EndPOints_PLS(excluda_expSession)           = [];

LIA                             = ismember(ID,Shortname,'rows');
indexExclude_missingO           = find(LIA==0)';


P_choice(:,indexExclude_missingO)          = [];
P_Prob(:,indexExclude_missingO)            = [];
P_ChoiceProb(:,indexExclude_missingO)      = [];
P_LR(:,indexExclude_missingO)              = [];
P_Stimno(:,indexExclude_missingO)          = [];
P_ProbChange(:,indexExclude_missingO)      = [];
P_EV(:,indexExclude_missingO)              = [];
P_RPE(:,indexExclude_missingO)             = [];
P_minSimPC(:,indexExclude_missingO)        = [];
P_maxSimPC(:,indexExclude_missingO)        = [];
P_Points_mean(indexExclude_missingO)       = [];
P_Points_median(indexExclude_missingO)     = [];
P_lowCIChoice(:,indexExclude_missingO)        = [];
P_highCIChoice(:,indexExclude_missingO)        = [];


D_choice(:,indexExclude_missingO)          = [];
D_Prob(:,indexExclude_missingO)            = [];
D_ChoiceProb(:,indexExclude_missingO)      = [];
D_LR(:,indexExclude_missingO)              = [];
D_Stimno(:,indexExclude_missingO)          = [];
D_ProbChange(:,indexExclude_missingO)      = [];
D_EV(:,indexExclude_missingO)              = [];
D_RPE(:,indexExclude_missingO)             = [];
D_minSimPC(:,indexExclude_missingO)        = [];
D_maxSimPC(:,indexExclude_missingO)        = [];
D_Points_mean(indexExclude_missingO)       = [];
D_Points_median(indexExclude_missingO)     = [];
D_lowCIChoice(:,indexExclude_missingO)        = [];
D_highCIChoice(:,indexExclude_missingO)        = [];


EndPOints_DS(indexExclude_missingO)            = [];
EndPOints_PLS(indexExclude_missingO)           = [];

split = median(EndPOints_O);

indexLowScoreO  = find(EndPOints_O<=split);
indexHighScoreO = find(EndPOints_O>split);

color    = get(groot,'DefaultAxesColorOrder');

figure(1);clf;
subplot(3,1,1)
shadedErrBar([], AGF_running_average(mean(O_choice,2),2,2), AGF_running_average(se(O_choice',0.99),2,2),{'-o', 'color',  color(5,:), 'markerfacecolor', color(5,:), 'markerSize', 2, 'lineWidth', 1});hold on;
plot(AGF_running_average(mean(O_ChoiceProb,2),2,2),'linewidth',3,'Color',color(5,:));
plot(mean(P_Prob,2)/100,'LineWidth',2,'Color','k')
xlim([1 length(D_choice)])
set(gca,'xtick',[])
legend({'choice' 'Model choice prob' 'Reward prob'},'FontSize',14,'Location','eastoutside');
set(0,'DefaultLegendAutoUpdate','off')
ylabel('P(choice)','FontSize',14, 'FontWeight', 'bold')
%plot(AGF_running_average(minPC_O,2,2),'-.k',LineWidth=1);
%plot(AGF_running_average(maxPC_O,2,2),'-.k',LineWidth=1); 
plot(AGF_running_average(mean(O_lowCIChoice,2),2,2),'-.k',LineWidth=1);
plot(AGF_running_average(mean(O_highCIChoice,2),2,2),'-.k',LineWidth=1); 


gridxy(find([D_ProbChange(:,1)==1]))
gridxy([find(D_Stimno(:,1) == 2, 1 ) find(D_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');
title({'Orientation Session'})

subplot(3,1,2)
shadedErrBar([], AGF_running_average(mean(D_choice,2),2,2), AGF_running_average(se(D_choice',0.99),2,2),{'-o', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 2, 'lineWidth', 1}); hold on;
plot(AGF_running_average(mean(D_ChoiceProb,2),2,2),'linewidth',3,'Color',color(3,:));
plot(mean(D_Prob,2)/100,'LineWidth',2,'Color','k')
xlim([1 length(D_choice)])
set(gca,'xtick',[])
legend({'choice' 'Model choice prob' 'Reward prob'},'FontSize',14,'Location','eastoutside');
set(0,'DefaultLegendAutoUpdate','off')
ylabel('P(choice)','FontSize',14, 'FontWeight', 'bold')
%plot(AGF_running_average(minPC_Drug,2,2),'-.k',LineWidth=1)
%plot(AGF_running_average(maxPC_Drug,2,2),'-.k',LineWidth=1); 
plot(AGF_running_average(mean(D_lowCIChoice,2),2,2),'-.k',LineWidth=1);
plot(AGF_running_average(mean(D_highCIChoice,2),2,2),'-.k',LineWidth=1); 
gridxy(find([D_ProbChange(:,1)==1]))
gridxy([find(D_Stimno(:,1) == 2, 1 ) find(D_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');
title({'MPH Session'})

subplot(3,1,3)
shadedErrBar([], AGF_running_average(mean(P_choice,2),2,2), AGF_running_average(se(P_choice',0.99),2,2),{'-o', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 2, 'lineWidth', 1});hold on;
plot(AGF_running_average(mean(P_ChoiceProb,2),2,2),'linewidth',3,'Color', color(1,:));
plot(mean(P_Prob,2)/100,'LineWidth',2,'Color','k')
xlim([1 length(D_choice)])
set(gca,'xtick',[])
legend({'choice' 'Model choice prob' 'Reward prob'},'FontSize',14,'Location','eastoutside');
set(0,'DefaultLegendAutoUpdate','off')
ylabel('P(choice)','FontSize',14, 'FontWeight', 'bold')
%plot(AGF_running_average(minPC_PLS,2,2),'-.k',LineWidth=1)
%plot(AGF_running_average(maxPC_PLS,2,2),'-.k',LineWidth=1); 
plot(AGF_running_average(mean(D_lowCIChoice,2),2,2),'-.k',LineWidth=1);
plot(AGF_running_average(mean(D_highCIChoice,2),2,2),'-.k',LineWidth=1); 
gridxy(find([D_ProbChange(:,1)==1]))
gridxy([find(D_Stimno(:,1) == 2, 1 ) find(D_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');
title({'PLA Session'})
h=gcf;
h.Position=[-2348         153        2002         787];
print2pdf(fullfile(pwd,'Figures',['MSFig4_DtoF.pdf']),h,300)
