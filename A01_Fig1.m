clear;
set(0,'defaultAxesFontSize',20);
load('Data/DDP.mat')
load('Data/InfoSubjects.mat')
load('Data/all_EndPOints_Orientation.mat');
load('Data/ID_DPP.mat')
load('Data/ARCIA.mat')
load('Data/all_EndPOints_MA.mat')

%% exclusion of subjects 
% (exclusion criteria: no participantion in the 
% orientation session and high proportion of misses (see data extraction 
% scripts in the data folder))

excluda_O                               = [26,79,86];
excluda_expSession                      = [30,60,90,97];
ID(excluda_expSession)                  = [];
EndPOints_O(excluda_O)                  = [];

EndPOints_DS(excluda_expSession)        = [];
DDP(excluda_expSession,:)               = [];

Shortname(excluda_O)                    = [];

LIA                                     = ismember(ID,Shortname,'rows');
indexExclude_missingO                   = find(LIA==0)';
EndPOints_DS(indexExclude_missingO)     = []; 
DDP(indexExclude_missingO,:)            = [];

LIA                                     = ismember(ID_DPP,Shortname,'rows');
indexExclude_missingO                   = find(LIA==0)';

ID_DPP(indexExclude_missingO)           = [];
ARCIA(indexExclude_missingO,:)          = [];

Missing_DPP                             = ismember(Shortname,ID_DPP,'rows');

EndPOints_O(Missing_DPP==0)             =[];
EndPOints_DS(Missing_DPP==0)            =[];


split = median(EndPOints_O);

indexLowScoreO  = find(EndPOints_O<=split);
indexHighScoreO = find(EndPOints_O>split);

%% ploting
time = [0 30 50 135 180 210];

color    = get(groot,'DefaultAxesColorOrder');

figure(1);clf;

shadedErrBar(time,AGF_running_average(nanmean(DDP(indexLowScoreO,1:6),1),0,0),se(DDP(:,1:6),1),{'-s', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 8, 'lineWidth', 3});hold on
shadedErrBar(time,AGF_running_average(nanmean(DDP(indexLowScoreO,7:end),1),0,0),se(DDP(:,7:end),1),{'-s', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 8, 'lineWidth', 3});hold on

shadedErrBar(time,AGF_running_average(nanmean(DDP(indexHighScoreO,1:6),1),0,0),se(DDP(:,1:6),1),{'--^', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 8, 'lineWidth', 3});hold on
shadedErrBar(time,AGF_running_average(nanmean(DDP(indexHighScoreO,7:end),1),0,0),se(DDP(:,7:end),1),{'--^', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 8, 'lineWidth', 3});hold on


legend({'MA_l_o_w_B_L';'PL_l_o_w_B_L';'MA_h_i_g_h_B_L';'PL_h_i_g_h_B_L'},'Location','northeast');
ylabel('Feel Drug Ratings');xlabel('Minutes post-capsule');
xlim([-10,220]);ylim([0 55]);
xline(60, '-k', 'LineWidth', 3); hold on % Dashed red line


h = gcf;
h.Position = [845   316   639   496];
print2pdf('Figures/FeelingDruged_group_split.pdf',h,300)

%% Test differences at timepoints

ttestout(DDP(:,2),DDP(:,8),1);
ttestout(DDP(:,3),DDP(:,9),1);
ttestout(DDP(:,4),DDP(:,10),1);
ttestout(DDP(:,5),DDP(:,11),1);
ttestout(DDP(:,6),DDP(:,12),1);

ttestout(DDP(indexLowScoreO,2),DDP(indexHighScoreO,2),1);
ttestout(DDP(indexLowScoreO,3),DDP(indexHighScoreO,3),1);
ttestout(DDP(indexLowScoreO,4),DDP(indexHighScoreO,4),1);
ttestout(DDP(indexLowScoreO,5),DDP(indexHighScoreO,5),1);
ttestout(DDP(indexLowScoreO,6),DDP(indexHighScoreO,6),1);

ttestout(DDP(indexLowScoreO,8),DDP(indexHighScoreO,8),1);
ttestout(DDP(indexLowScoreO,9),DDP(indexHighScoreO,9),1);
ttestout(DDP(indexLowScoreO,10),DDP(indexHighScoreO,10),1);
ttestout(DDP(indexLowScoreO,11),DDP(indexHighScoreO,11),1);
ttestout(DDP(indexLowScoreO,12),DDP(indexHighScoreO,12),1);

% ARCI_A
ttestout(ARCIA(indexLowScoreO,1),ARCIA(indexHighScoreO,1),1);
ttestout(ARCIA(indexLowScoreO,2),ARCIA(indexHighScoreO,2),1);


%% check if the effect of the drug on task performance was correlated with the subjective effects

[r,p]               = corr(DDP(:,3),EndPOints_DS);

[r_ARCIA,p_ARCIA_]  = corr(ARCIA(:,1),EndPOints_DS);
