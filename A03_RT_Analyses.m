%% 1. extract data
clear
load('Data/MA_wGenPrior_Data_111110.mat')

RT_MPH              = nan(length(dstruct),1);
SD_RT_MPH           = nan(length(dstruct),1);
Corr_SDC_RT_MPH     = nan(length(dstruct),1);
RT_Good_MPH         = nan(length(dstruct),1);
RT_Bad_MPH          = nan(length(dstruct),1);
RT_neutral_MPH      = nan(length(dstruct),1);
SD_RT_Good_MPH      = nan(length(dstruct),1);
SD_RT_Bad_MPH       = nan(length(dstruct),1);
SD_RT_neutral_MPH   = nan(length(dstruct),1);

mSDC_MPH           = nan(length(dstruct),1);

ACC_MPH         = nan(length(dstruct),1);
ACC_Good_MPH    = nan(length(dstruct),1);
ACC_Bad_MPH     = nan(length(dstruct),1);

for i = 1:length(dstruct)

    ACC_MPH(i)          = nanmean(dstruct(i).CorrectResp);
    RT_MPH(i)           = nanmedian(dstruct(i).RT);
    SD_RT_MPH(i)        = nanstd(dstruct(i).RT);

    SDC                 = abs(dstruct(i).ChoiceProb-.5)*2;
    mSDC_MPH(i)         = mean(SDC);

    Misses = find(~isnan(dstruct(i).RT));
    
    Corr_SDC_RT_MPH(i)  = corr(SDC(Misses)',dstruct(i).RT(Misses)');

    RT_Good_MPH(i)         = nanmedian(dstruct(i).RT(dstruct(i).Prob>50));
    RT_neutral_MPH(i)      = nanmedian(dstruct(i).RT(dstruct(i).Prob==50));
    RT_Bad_MPH(i)          = nanmedian(dstruct(i).RT(dstruct(i).Prob<50));


    ACC_Good_MPH(i)         = nanmean(dstruct(i).CorrectResp(dstruct(i).Prob>50));
    ACC_Bad_MPH(i)          = nanmean(dstruct(i).CorrectResp(dstruct(i).Prob<50));


    SD_RT_Good_MPH(i)         = nanstd(dstruct(i).RT(dstruct(i).Prob>50));
    SD_RT_neutral_MPH(i)      = nanstd(dstruct(i).RT(dstruct(i).Prob==50));
    SD_RT_Bad_MPH(i)          = nanstd(dstruct(i).RT(dstruct(i).Prob<50));

end

load('Data/PL_wGenPriors_Data_111110.mat')

RT_PLA          = nan(length(dstruct),1);
SD_RT_PLA       = nan(length(dstruct),1);
Corr_SDC_RT_PLA = nan(length(dstruct),1);
RT_Good_PLA     = nan(length(dstruct),1);
RT_Bad_PLA      = nan(length(dstruct),1);
RT_neutral_PLA  = nan(length(dstruct),1);
SD_RT_Good_PLA     = nan(length(dstruct),1);
SD_RT_Bad_PLA      = nan(length(dstruct),1);
SD_RT_neutral_PLA  = nan(length(dstruct),1);

ACC_PLA         = nan(length(dstruct),1);
ACC_Good_PLA    = nan(length(dstruct),1);
ACC_Bad_PLA     = nan(length(dstruct),1);

mSDC_PLA        = nan(length(dstruct),1);


for i = 1:length(dstruct)

    ACC_PLA(i)          = nanmean(dstruct(i).CorrectResp);

    RT_PLA(i)           = nanmedian(dstruct(i).RT);
    SD_RT_PLA(i)        = nanstd(dstruct(i).RT);

    SDC                 = abs(dstruct(i).ChoiceProb-.5)*2;
    mSDC_PLA(i)         = mean(SDC);

    Misses = find(~isnan(dstruct(i).RT));
    
    Corr_SDC_RT_PLA(i)  = corr(SDC(Misses)',dstruct(i).RT(Misses)');

    RT_Good_PLA(i)         = nanmedian(dstruct(i).RT(dstruct(i).Prob>50));
    RT_neutral_PLA(i)      = nanmedian(dstruct(i).RT(dstruct(i).Prob==50));
    RT_Bad_PLA(i)          = nanmedian(dstruct(i).RT(dstruct(i).Prob<50));


    ACC_Good_PLA(i)         = nanmean(dstruct(i).CorrectResp(dstruct(i).Prob>50));
    ACC_Bad_PLA(i)          = nanmean(dstruct(i).CorrectResp(dstruct(i).Prob<50));

    SD_RT_Good_PLA(i)         = nanstd(dstruct(i).RT(dstruct(i).Prob>50));
    SD_RT_neutral_PLA(i)      = nanstd(dstruct(i).RT(dstruct(i).Prob==50));
    SD_RT_Bad_PLA(i)          = nanstd(dstruct(i).RT(dstruct(i).Prob<50));

end

load('Data/all_behavior_Orientation.mat')

RT_O          = nan(length(D),1);
SD_RT_O       = nan(length(D),1);
Corr_SDC_RT_O = nan(length(D),1);
RT_Good_O     = nan(length(D),1);
RT_Bad_O      = nan(length(D),1);
RT_neutral_O  = nan(length(D),1);
SD_RT_Good_O     = nan(length(D),1);
SD_RT_Bad_O      = nan(length(D),1);
SD_RT_neutral_O  = nan(length(D),1);

ACC_O       = nan(length(D),1);
ACC_Good_O  = nan(length(D),1);
ACC_Bad_O   = nan(length(D),1);


mSDC_O        = nan(length(D),1);


for i = 1:length(D)

    ACC_O(i)          = nanmean(D(i).CorrectResp);

    RT_O(i)           = nanmedian(D(i).RT);
    SD_RT_O(i)        = nanstd(D(i).RT);


    Misses = find(~isnan(D(i).RT));
    

    RT_Good_O(i)         = nanmedian(D(i).RT(D(i).Prob>50));
    RT_neutral_O(i)      = nanmedian(D(i).RT(D(i).Prob==50));
    RT_Bad_O(i)          = nanmedian(D(i).RT(D(i).Prob<50));

    ACC_Good_O(i)         = nanmedian(D(i).CorrectResp(D(i).Prob>50));
    ACC_Bad_O(i)          = nanmedian(D(i).CorrectResp(D(i).Prob<50));

    SD_RT_Good_O(i)         = nanstd(D(i).RT(D(i).Prob>50));
    SD_RT_neutral_O(i)      = nanstd(D(i).RT(D(i).Prob==50));
    SD_RT_Bad_O(i)          = nanstd(D(i).RT(D(i).Prob<50));

end

%% 2. exclude subjects
% (exclusion criteria: no participantion in the 
% orientation session and high proportion of misses (see data extraction 
% scripts in the data folder))
load('Data/InfoSubjects.mat')
load('Data/all_EndPOints_Orientation.mat');

% Orientation
excluda_O                               = [26,79,86];
excluda_expSession                      = [30,60,90,97];
ID(excluda_expSession)                  = [];

RT_PLA(excluda_expSession)                = [];
SD_RT_PLA(excluda_expSession)             = [];
Corr_SDC_RT_PLA(excluda_expSession)       = [];
RT_Good_PLA(excluda_expSession)           = [];
RT_Bad_PLA(excluda_expSession)            = [];
RT_neutral_PLA(excluda_expSession)        = [];
SD_RT_Good_PLA(excluda_expSession)           = [];
SD_RT_Bad_PLA(excluda_expSession)            = [];
SD_RT_neutral_PLA(excluda_expSession)        = [];
mSDC_PLA(excluda_expSession)              = [];

ACC_PLA(excluda_expSession)                 = [];
ACC_Good_PLA(excluda_expSession)            = [];
ACC_Bad_PLA(excluda_expSession)             = [];


RT_MPH(excluda_expSession)                = [];
SD_RT_MPH(excluda_expSession)             = [];
Corr_SDC_RT_MPH(excluda_expSession)       = [];
RT_Good_MPH(excluda_expSession)           = [];
RT_Bad_MPH(excluda_expSession)            = [];
RT_neutral_MPH(excluda_expSession)        = [];

SD_RT_Good_MPH(excluda_expSession)                     = [];
SD_RT_Bad_MPH(excluda_expSession)            = [];
SD_RT_neutral_MPH(excluda_expSession)        = [];

mSDC_MPH(excluda_expSession)              = [];

ACC_MPH(excluda_expSession)                 = [];
ACC_Good_MPH(excluda_expSession)            = [];
ACC_Bad_MPH(excluda_expSession)             = [];

EndPOints_O(excluda_O)                  = [];
ACC_O(excluda_O)                        = [];
ACC_Good_O(excluda_O)                   = [];
ACC_Bad_O(excluda_O)                    = [];
Shortname(excluda_O)                    = [];

LIA                                     = ismember(ID,Shortname,'rows');
indexExclude_missingO                   = find(LIA==0)';

RT_PLA(indexExclude_missingO)            = [];
SD_RT_PLA(indexExclude_missingO)         = [];
Corr_SDC_RT_PLA(indexExclude_missingO)   = [];
RT_Good_PLA(indexExclude_missingO)       = [];
RT_Bad_PLA(indexExclude_missingO)        = [];
RT_neutral_PLA(indexExclude_missingO)    = [];

SD_RT_Good_PLA(indexExclude_missingO)       = [];
SD_RT_Bad_PLA(indexExclude_missingO)        = [];
SD_RT_neutral_PLA(indexExclude_missingO)    = [];

mSDC_PLA(indexExclude_missingO)          = [];

RT_MPH(indexExclude_missingO)            = [];
SD_RT_MPH(indexExclude_missingO)         = [];
Corr_SDC_RT_MPH(indexExclude_missingO)   = [];
RT_Good_MPH(indexExclude_missingO)       = [];
RT_Bad_MPH(indexExclude_missingO)        = [];
RT_neutral_MPH(indexExclude_missingO)    = [];

SD_RT_Good_MPH(indexExclude_missingO)       = [];
SD_RT_Bad_MPH(indexExclude_missingO)        = [];
SD_RT_neutral_MPH(indexExclude_missingO)    = [];

mSDC_MPH(indexExclude_missingO)          = [];


ACC_MPH(indexExclude_missingO)          = [];
ACC_Good_MPH(indexExclude_missingO)     = [];
ACC_Bad_MPH(indexExclude_missingO)      = [];

ACC_PLA(indexExclude_missingO)          = [];
ACC_Good_PLA(indexExclude_missingO)     = [];
ACC_Bad_PLA(indexExclude_missingO)      = [];


split = median(EndPOints_O);

indexLowScoreO  = find(EndPOints_O<=split);
indexHighScoreO = find(EndPOints_O>split);


%% 3. run stats on the data

path('helper/',path);

%RT 

group = repmat("Gr_A",94,1);
group(indexHighScoreO) = "Gr_B";    

t_DrugEffect1 = table(group,RT_PLA,RT_MPH,...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect1,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);
ranovatblRT = ranova(rm,'WithinModel','TimePoints'); 

ttestout(RT_PLA,RT_MPH,1);
ttestout(RT_PLA(indexLowScoreO),RT_MPH(indexLowScoreO),1);
ttestout(RT_PLA(indexHighScoreO),RT_MPH(indexHighScoreO),1);

%SD
ttestout(SD_RT_PLA,SD_RT_MPH,1);
ttestout(SD_RT_PLA(indexLowScoreO),SD_RT_MPH(indexLowScoreO),1);
ttestout(SD_RT_PLA(indexHighScoreO),SD_RT_MPH(indexHighScoreO),1);


LowOP_SDRT = [SD_RT_PLA(indexLowScoreO);SD_RT_MPH(indexLowScoreO)];
HighOP_SDRT = [SD_RT_PLA(indexHighScoreO);SD_RT_MPH(indexHighScoreO)];

ttestout(LowOP_SDRT,HighOP_SDRT,1);


t_DrugEffect1 = table(group,SD_RT_PLA,SD_RT_MPH,...
    'VariableNames',{'Group','PointsSession1','PointsSession2'});

Session =  table(["t1";"t2"],'VariableNames',{'TimePoints'});

rm = fitrm(t_DrugEffect1,'PointsSession1-PointsSession2 ~ Group','WithinDesign',Session);
ranovatblSDRT = ranova(rm,'WithinModel','TimePoints'); 

%%
% load("Data/REFIT_Chicago_Data_long.mat")
% 
% SD_RT = [SD_RT_PLA;SD_RT_MPH];
% RT    = [RT_PLA;RT_MPH];
% 
% addOnTable = nanrem(table(RT,SD_RT)); 
% 
% REFIT_Chicago_DataM =[REFIT_Chicago_DataM,addOnTable];
% 
% save("Data/REFIT_Chicago_Data_long.mat","REFIT_Chicago_DataM")
% writetable(REFIT_Chicago_DataM, 'Data/REFIT_Chicago_Data_long.csv');
