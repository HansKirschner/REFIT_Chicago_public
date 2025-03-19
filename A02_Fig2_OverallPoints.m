clear

%% load data
path('helper/',path);
load('Data/all_EndPOints_Orientation.mat');
load('Data/all_EndPOints_PL.mat');
load('Data/all_EndPOints_MA.mat');
load('Data/all_EndPOints_Session1.mat');
load('Data/all_EndPOints_Session2.mat');


load('Data/fminconResult_wPrior_111110.mat')

InvTOS        = fminconResult.fitParams(:,1);
PlayBiasOS    = fminconResult.fitParams(:,2);
EtaOS         = fminconResult.fitParams(:,3);
LRIntcptOS    = fminconResult.fitParams(:,4);
LRFeedConfOS  = fminconResult.fitParams(:,5);


load('Data/MA_wGenPrior_fminconResult_111110.mat')

InvTDrug        = fminconResult.fitParams(:,1);
PlayBiasDrug    = fminconResult.fitParams(:,2);
EtaDrug         = fminconResult.fitParams(:,3);
LRIntcptDrug    = fminconResult.fitParams(:,4);
LRFeedConfDrug  = fminconResult.fitParams(:,5);


load('Data/PL_wGenPriors_fminconResult_111110.mat')
InvTPLS        = fminconResult.fitParams(:,1);
PlayBiasPLS    = fminconResult.fitParams(:,2);
EtaPLS         = fminconResult.fitParams(:,3);
LRIntcptPLS    = fminconResult.fitParams(:,4);
LRFeedConfPLS  = fminconResult.fitParams(:,5);

load('Data/InfoSubjects.mat')
load('Data/SessionInfo.mat')

EndPOints_Session1_all = EndPOints_Session1;

%% exclusion of subjects 
% (exclusion criteria: no participantion in the 
% orientation session and high proportion of misses (see data extraction 
% scripts in the data folder))

% Orientation
% DDP736  DDP839   DDP846
excluda_O = [26,79,86];

% PL Session
% {'DDP736.1'}    {'DDP839.1'}    {'DDP846.2'}
excluda_PLS = [30,90,97];

% Drug Session
% {'DDP736.2'}    {'DDP805.2'}
excluda_Drug = [30,60];

excluda_expSession = [30,60,90,97];

EndPOints_Session1_all(excluda_expSession)= [];

ID(excluda_expSession)=[];
Session1(excluda_expSession)=[];

EtaDrug(excluda_expSession)=[];
EtaPLS(excluda_expSession)=[];

InvTDrug(excluda_expSession)=[];
PlayBiasDrug(excluda_expSession)=[];
LRIntcptDrug(excluda_expSession)=[];
LRFeedConfDrug(excluda_expSession)=[];

InvTPLS(excluda_expSession)=[];
PlayBiasPLS(excluda_expSession)=[];
LRIntcptPLS(excluda_expSession)=[];
LRFeedConfPLS(excluda_expSession)=[];


EndPOints_PLS(excluda_expSession)=[];
EndPOints_DS(excluda_expSession)=[];
EndPOints_Session1(excluda_expSession)=[];
EndPOints_Session2(excluda_expSession)=[];


Shortname(excluda_O)=[];
EndPOints_O(excluda_O)=[];
EtaOS(excluda_O)=[];

[LIA,LOCB]              = ismember(ID,Shortname,'rows');
indexExclude_missingO   = find(LIA==0)';

EndPOints_PLS(indexExclude_missingO)=[];
EndPOints_DS(indexExclude_missingO)=[];
EndPOints_Session1(indexExclude_missingO)=[];
EndPOints_Session2(indexExclude_missingO)=[];

EtaDrug(indexExclude_missingO)=[];
EtaPLS(indexExclude_missingO)=[];

InvTDrug(indexExclude_missingO)=[];
PlayBiasDrug(indexExclude_missingO)=[];
LRIntcptDrug(indexExclude_missingO)=[];
LRFeedConfDrug(indexExclude_missingO)=[];

InvTPLS(indexExclude_missingO)=[];
PlayBiasPLS(indexExclude_missingO)=[];
LRIntcptPLS(indexExclude_missingO)=[];
LRFeedConfPLS(indexExclude_missingO)=[];

Session1(indexExclude_missingO)=[];


%%
ttestout(EndPOints_Session1_all(LIA==1),EndPOints_Session1_all(LIA==0),1)

%%

mean(EndPOints_O)
std(EndPOints_O)
mean(EndPOints_Session1)
std(EndPOints_Session1)
mean(EndPOints_Session2)
std(EndPOints_Session2)
mean(EndPOints_DS)
mean(EndPOints_PLS)

ttestout(EndPOints_O,EndPOints_Session1,1)
ttestout(EndPOints_O,EndPOints_Session2,1)
ttestout(EndPOints_O,EndPOints_PLS,1)
ttestout(EndPOints_Session1,EndPOints_Session2,1)

ttestout(EndPOints_DS,EndPOints_PLS,1)


t_SessionEffect = table(EndPOints_O,EndPOints_Session1,EndPOints_Session2,...
    'VariableNames',{'PointsSession1','PointsSession2','PointsSession3'});

Session =  table(["t1";"t2";"t3"],'VariableNames',{'TimePoints'});

rm = fitrm(t_SessionEffect ,'PointsSession1-PointsSession3 ~ 1','WithinDesign',Session); % ~ 1 = we model the intercept
ranovatbl = ranova(rm); 

multcompare(rm,'TimePoints')


%% median split orientation

split = median(EndPOints_O);

indexLowScoreO  = find(EndPOints_O<=split);
indexHighScoreO = find(EndPOints_O>split);

ttestout(EndPOints_DS(indexLowScoreO),EndPOints_PLS(indexLowScoreO),1)
ttestout(EndPOints_DS(indexHighScoreO),EndPOints_PLS(indexHighScoreO),1)

ttestout(EndPOints_Session1(indexLowScoreO),EndPOints_Session2(indexLowScoreO),1)
ttestout(EndPOints_Session1(indexHighScoreO),EndPOints_Session2(indexHighScoreO),1)

ttestout(EndPOints_DS,EndPOints_PLS,2)

ttestout(EtaOS(indexLowScoreO),EtaOS(indexHighScoreO),1)

group = repmat("Gr_A",94,1);
group(indexHighScoreO) = "Gr_B";  

SessionGroup = repmat("Gr_A",94,1);
SessionGroup(Session1==1) = "Gr_B";  


t_DrugEffect1 = table(group,EndPOints_PLS,EndPOints_DS,...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect1,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);
ranovatbl1 = ranova(rm,'WithinModel','TimePoints'); 

% % session order control analyes
% t_SessionEffect = table(group,EndPOints_Session1,EndPOints_Session2,...
%     'VariableNames',{'Group','PointsSession1','PointsSession2'});
% 
% Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});
% 
% rm = fitrm(t_SessionEffect,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);
% ranovatbl2 = ranova(rm,'WithinModel','TimePoints'); 


% session order control analyes V2 
t_DrugEffect1 = table(group,SessionGroup,EndPOints_PLS,EndPOints_DS,...
    'VariableNames',{'Group','Session','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect1,'PointsSession1-PointsSession2 ~ Group:Session','WithinDesign',Session);
ranovatbl1 = ranova(rm,'WithinModel','TimePoints'); 


%% median split on eta 
splitEta = median(EtaOS);

indexLowEta  = find(EtaOS<=splitEta);
indexHighEta = find(EtaOS>splitEta);

ttestout(EndPOints_O(indexLowEta),EndPOints_O(indexHighEta),1)

splitEtaDrug = median(EtaDrug);

indexLowEtaDrug  = find(EtaDrug<=splitEtaDrug);
indexHighEtaDrug = find(EtaDrug>splitEtaDrug);

ttestout(EndPOints_DS(indexLowEtaDrug),EndPOints_DS(indexHighEtaDrug),1)
[r,p] = corr(EndPOints_DS,EtaDrug)

splitEtaPLS = median(EtaPLS);

indexLowEtaPLS  = find(EtaPLS<=splitEtaPLS);
indexHighEtaPLS = find(EtaPLS>splitEtaPLS);

ttestout(EndPOints_PLS(indexLowEtaPLS),EndPOints_PLS(indexHighEtaPLS),1)
[r,p] = corr(EndPOints_PLS,EtaPLS)

%% ploting

color    = get(groot,'DefaultAxesColorOrder');

figure(1),clf;
subplot(2,2,1)
[x,y,dataR,IQR] = violinplotHK(EndPOints_O);
patch([y -y(end:-1:1)] , [x x(end:-1:1)], color(5,:),'facealpha',.7);hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(EndPOints_O),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(EndPOints_O),'ko','markerfacecolor','g','markersize',10)

[x,y,dataR,IQR] = violinplotHK(EndPOints_Session1);
patch([y -y(end:-1:1)]+3 , [x x(end:-1:1)], color(2,:),'facealpha',.7)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(EndPOints_Session1),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(EndPOints_Session1),'ko','markerfacecolor','g','markersize',10)

[x,y,dataR,IQR] = violinplotHK(EndPOints_Session2);
patch([y -y(end:-1:1)]+6 , [x x(end:-1:1)],  color(7,:),'facealpha',.7)
hold on
% plot other descriptive stats
plot([6 6],IQR,'k','linew',3)
plot(6,nanmean(EndPOints_Session2),'ks','markerfacecolor','r','markersize',10)
plot(6,nanmedian(EndPOints_Session2),'ko','markerfacecolor','g','markersize',10)

set(gca,'xlim',[-2.5 8.5],'xtick',[],'ylim',[-550 1500])
box off
title('Performance across session')
ylabel('Points')

subplot(2,2,2)
[x,y,dataR,IQR] = violinplotHK(EndPOints_PLS);
patch([y -y(end:-1:1)] , [x x(end:-1:1)],  color(1,:),'facealpha',.7)
hold on
% plot other descriptive stats
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(EndPOints_PLS),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(EndPOints_PLS),'ko','markerfacecolor','g','markersize',10)

[x,y,dataR,IQR] = violinplotHK(EndPOints_DS);
patch([y -y(end:-1:1)]+3 , [x x(end:-1:1)],  color(3,:),'facealpha',.7)
hold on
% plot other descriptive stats
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(EndPOints_DS),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(EndPOints_DS),'ko','markerfacecolor','g','markersize',10)

set(gca,'xlim',[-2.5 5.5],'xtick',[],'ylim',[-550 1500])
box off
title('Performance placebo vs MPH')
ylabel('Points')

subplot(2,2,3)
[x,y,dataR,IQR] = violinplotHK(EndPOints_PLS(indexLowScoreO));
patch([y -y(end:-1:1)] , [x x(end:-1:1)],  color(1,:),'facealpha',.5)
hold on
% plot other descriptive stats
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(EndPOints_PLS(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(EndPOints_PLS(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y,dataR,IQR] = violinplotHK(EndPOints_DS(indexLowScoreO));
patch([y -y(end:-1:1)]+3 , [x x(end:-1:1)], color(3,:),'facealpha',.5)
hold on
% plot other descriptive stats
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(EndPOints_DS(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(EndPOints_DS(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

% high perforamce orientation
[x,y,dataR,IQR] = violinplotHK(EndPOints_PLS(indexHighScoreO));
patch([y -y(end:-1:1)]+6 , [x x(end:-1:1)], color(1,:),'facealpha',.9)
hold on
% plot other descriptive stats
plot([6 6],IQR,'k','linew',3)
plot(6,nanmean(EndPOints_PLS(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(6,nanmedian(EndPOints_PLS(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)


[x,y,dataR,IQR] = violinplotHK(EndPOints_DS(indexHighScoreO));
patch([y -y(end:-1:1)]+9 , [x x(end:-1:1)], color(3,:),'facealpha',.9)
hold on
% plot other descriptive stats
plot([9 9],IQR,'k','linew',3)
plot(9,nanmean(EndPOints_DS(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(9,nanmedian(EndPOints_DS(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)

set(gca,'xlim',[-2.5 11.5],'xtick',[],'ylim',[-550 1500])
box off
title('Performance placebo vs MPH split')
ylabel('Points')


subplot(2,2,4)
[x,y,dataR,IQR] = violinplotHK(EndPOints_Session1(indexLowScoreO));
patch([y -y(end:-1:1)] , [x x(end:-1:1)], color(4,:),'facealpha',.5)
hold on
% plot other descriptive stats
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(EndPOints_Session1(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(EndPOints_Session1(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

[x,y,dataR,IQR] = violinplotHK(EndPOints_Session2(indexLowScoreO));
patch([y -y(end:-1:1)]+3 , [x x(end:-1:1)], color(6,:),'facealpha',.5)
hold on
% plot other descriptive stats
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(EndPOints_Session2(indexLowScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(EndPOints_Session2(indexLowScoreO)),'ko','markerfacecolor','g','markersize',10)

% high perforamce orientation
[x,y,dataR,IQR] = violinplotHK(EndPOints_Session1(indexHighScoreO));
patch([y -y(end:-1:1)]+6 , [x x(end:-1:1)], color(4,:),'facealpha',.9)
hold on
% plot other descriptive stats
plot([6 6],IQR,'k','linew',3)
plot(6,nanmean(EndPOints_Session1(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(6,nanmedian(EndPOints_Session1(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)


[x,y,dataR,IQR] = violinplotHK(EndPOints_Session2(indexHighScoreO));
patch([y -y(end:-1:1)]+9 , [x x(end:-1:1)], color(6,:),'facealpha',.9)
hold on
% plot other descriptive stats
plot([9 9],IQR,'k','linew',3)
plot(9,nanmean(EndPOints_Session2(indexHighScoreO)),'ks','markerfacecolor','r','markersize',10)
plot(9,nanmedian(EndPOints_Session2(indexHighScoreO)),'ko','markerfacecolor','g','markersize',10)

set(gca,'xlim',[-2.5 11.5],'xtick',[],'ylim',[-550 1500])
box off
title('Performance session 2 vs 3 split')
ylabel('Points')

h = gcf;
h.Position = [104         192        1454         773];
print2pdf(fullfile(pwd,'Figures',['OverallPerformance_Split.pdf']),h,300)

%% Extract Info for mixed effects model

% SubjNr            = [Shortname-699; Shortname-699];
% DrugSession       = [ones(length(Shortname),1)*-1;ones(length(Shortname),1)];
% SesssionOrder     = [Session1*2-1;Session1*2-1];
% BLPerformace      = [normalise(EndPOints_O);normalise(EndPOints_O)];
% TotalPoints       = [EndPOints_PLS;EndPOints_DS];
% 
% InvT              = [InvTPLS;InvTDrug];
% PlayBias          = [PlayBiasPLS;PlayBiasDrug];
% LRIntcpt          = [LRIntcptPLS;LRIntcptDrug];
% LRFeedConf        = [LRFeedConfPLS;LRFeedConfDrug];
% Eta               = [EtaPLS;EtaDrug];
% 
% REFIT_Chicago_DataM = nanrem(table(SubjNr,DrugSession,SesssionOrder,BLPerformace,TotalPoints,Eta,...
%     InvT,PlayBias,LRIntcpt,LRFeedConf));
% 
% save("Data/REFIT_Chicago_Data_long.mat","REFIT_Chicago_DataM")
% writetable(REFIT_Chicago_DataM, 'Data/REFIT_Chicago_Data_long.csv');
