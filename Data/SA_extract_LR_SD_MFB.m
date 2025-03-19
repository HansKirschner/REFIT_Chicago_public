clear
rootDir = pwd;
load('RawInfoMASession_R1.mat')
load('RawInfoPLSession_R1.mat')


%% exclusion of subjects
load('InfoSubjects.mat')
load('SessionInfo.mat')
load('all_EndPOints_Orientation.mat')

% Orientation
excluda_O                           = [26,79,86];
excluda_expSession                  = [30,60,90,97];
ID(excluda_expSession)              = [];
Session1(excluda_expSession)        = [];



%SD LR
RawInfoPLSession.SD_LR_earlyLearning_all(excluda_expSession)  = [];
RawInfoPLSession.SD_LR_lateLearning_all(excluda_expSession)  = [];

RawInfoPLSession.SD_LR_earlyLearning_HighProb(excluda_expSession)  = [];
RawInfoPLSession.SD_LR_lateLearning_HighProb(excluda_expSession)  = [];

RawInfoPLSession.SD_LR_earlyLearning_LowProb(excluda_expSession)  = [];
RawInfoPLSession.SD_LR_lateLearning_LowProb(excluda_expSession)  = [];

RawInfoMASession.SD_LR_earlyLearning_all(excluda_expSession)  = [];
RawInfoMASession.SD_LR_lateLearning_all(excluda_expSession)  = [];

RawInfoMASession.SD_LR_earlyLearning_HighProb(excluda_expSession)  = [];
RawInfoMASession.SD_LR_lateLearning_HighProb(excluda_expSession)  = [];

RawInfoMASession.SD_LR_earlyLearning_LowProb(excluda_expSession)  = [];
RawInfoMASession.SD_LR_lateLearning_LowProb(excluda_expSession)  = [];


% correct choices after two misleading FB
RawInfoPLSession.AccAfter2MFB_earlyLearing_LowProb(excluda_expSession)    = [];
RawInfoPLSession.AccAfter2MFB_lateLearning_LowProb(excluda_expSession)    = [];    
RawInfoPLSession.AccAfter2MFB_lateLearning_HighProb(excluda_expSession)    = [];

RawInfoMASession.AccAfter2MFB_earlyLearing_LowProb(excluda_expSession)    = [];
RawInfoMASession.AccAfter2MFB_lateLearning_LowProb(excluda_expSession)    = [];    
RawInfoMASession.AccAfter2MFB_lateLearning_HighProb(excluda_expSession)    = [];

% correct choices after one misleading FB

RawInfoPLSession.AccAfter1MFB_earlyLearing_LowProb(excluda_expSession)    = [];
RawInfoPLSession.AccAfter1MFB_lateLearning_LowProb(excluda_expSession)    = [];

RawInfoMASession.AccAfter1MFB_earlyLearing_LowProb(excluda_expSession)    = [];
RawInfoMASession.AccAfter1MFB_lateLearning_LowProb(excluda_expSession)    = [];


Shortname(excluda_O)            = [];
EndPOints_O(excluda_O)          = [];


LIA                             = ismember(ID,Shortname,'rows');
indexExclude_missingO           = find(LIA==0)';

Session1(indexExclude_missingO)        = [];


%SD LR
RawInfoPLSession.SD_LR_earlyLearning_all(indexExclude_missingO)  = [];
RawInfoPLSession.SD_LR_lateLearning_all(indexExclude_missingO)  = [];

RawInfoPLSession.SD_LR_earlyLearning_HighProb(indexExclude_missingO)  = [];
RawInfoPLSession.SD_LR_lateLearning_HighProb(indexExclude_missingO)  = [];

RawInfoPLSession.SD_LR_earlyLearning_LowProb(indexExclude_missingO)  = [];
RawInfoPLSession.SD_LR_lateLearning_LowProb(indexExclude_missingO)  = [];

RawInfoMASession.SD_LR_earlyLearning_all(indexExclude_missingO)  = [];
RawInfoMASession.SD_LR_lateLearning_all(indexExclude_missingO)  = [];

RawInfoMASession.SD_LR_earlyLearning_HighProb(indexExclude_missingO)  = [];
RawInfoMASession.SD_LR_lateLearning_HighProb(indexExclude_missingO)  = [];

RawInfoMASession.SD_LR_earlyLearning_LowProb(indexExclude_missingO)  = [];
RawInfoMASession.SD_LR_lateLearning_LowProb(indexExclude_missingO)  = [];

% correct choices after two misleading FB
RawInfoPLSession.AccAfter2MFB_earlyLearing_LowProb(indexExclude_missingO)       = [];
RawInfoPLSession.AccAfter2MFB_lateLearning_LowProb(indexExclude_missingO)       = [];
RawInfoPLSession.AccAfter2MFB_lateLearning_HighProb(indexExclude_missingO)       = [];

RawInfoMASession.AccAfter2MFB_earlyLearing_LowProb(indexExclude_missingO)       = [];
RawInfoMASession.AccAfter2MFB_lateLearning_LowProb(indexExclude_missingO)       = [];
RawInfoMASession.AccAfter2MFB_lateLearning_HighProb(indexExclude_missingO)       = [];

% correct choices after one misleading FB
RawInfoPLSession.AccAfter1MFB_earlyLearing_LowProb(indexExclude_missingO)       = [];
RawInfoPLSession.AccAfter1MFB_lateLearning_LowProb(indexExclude_missingO)       = [];

RawInfoMASession.AccAfter1MFB_earlyLearing_LowProb(indexExclude_missingO)       = [];
RawInfoMASession.AccAfter1MFB_lateLearning_LowProb(indexExclude_missingO)       = [];


split = median(EndPOints_O);

indexLowScoreO  = find(EndPOints_O<=split);
indexHighScoreO = find(EndPOints_O>split);

%% quick t-tests

ttestout(RawInfoPLSession.SD_LR_earlyLearning_all,RawInfoMASession.SD_LR_earlyLearning_all,1);
ttestout(RawInfoPLSession.SD_LR_lateLearning_all,RawInfoMASession.SD_LR_lateLearning_all,1);

ttestout(RawInfoPLSession.SD_LR_earlyLearning_HighProb,RawInfoMASession.SD_LR_earlyLearning_HighProb,1)
ttestout(RawInfoPLSession.SD_LR_lateLearning_HighProb,RawInfoMASession.SD_LR_lateLearning_HighProb,1)

ttestout(RawInfoPLSession.SD_LR_earlyLearning_LowProb,RawInfoMASession.SD_LR_earlyLearning_LowProb,1)
ttestout(RawInfoPLSession.SD_LR_lateLearning_LowProb,RawInfoMASession.SD_LR_lateLearning_LowProb,1)

ttestout(RawInfoPLSession.SD_LR_lateLearning_LowProb,RawInfoMASession.SD_LR_lateLearning_LowProb,1)

% check the sign of the MFB effect for just one probabilistic error
ttestout(RawInfoPLSession.AccAfter1MFB_lateLearning_LowProb,RawInfoMASession.AccAfter1MFB_lateLearning_LowProb,1);
ttestout(RawInfoPLSession.AccAfter1MFB_lateLearning_LowProb(indexLowScoreO),RawInfoMASession.AccAfter1MFB_lateLearning_LowProb(indexLowScoreO),1);




%% 

% load("REFIT_Chicago_Data_long.mat")
% 
% 
% LRSD_all_early   = [RawInfoPLSession.SD_LR_earlyLearning_all;RawInfoMASession.SD_LR_earlyLearning_all];
% LRSD_all_late    = [RawInfoPLSession.SD_LR_lateLearning_all;RawInfoMASession.SD_LR_lateLearning_all];
% 
% LRSD_HC_early    = [RawInfoPLSession.SD_LR_earlyLearning_HighProb;RawInfoMASession.SD_LR_earlyLearning_HighProb];
% LRSD_HC_late     = [RawInfoPLSession.SD_LR_lateLearning_HighProb;RawInfoMASession.SD_LR_lateLearning_HighProb];
% 
% LRSD_LC_early    = [RawInfoPLSession.SD_LR_earlyLearning_LowProb;RawInfoMASession.SD_LR_earlyLearning_LowProb];
% LRSD_LC_late     = [RawInfoPLSession.SD_LR_lateLearning_LowProb;RawInfoMASession.SD_LR_lateLearning_LowProb];
% 
% Pcorr2MFB_LC     = [RawInfoPLSession.AccAfter2MFB_lateLearning_LowProb;RawInfoMASession.AccAfter2MFB_lateLearning_LowProb];
% Pcorr1MFB_LC     = [RawInfoPLSession.AccAfter1MFB_lateLearning_LowProb;RawInfoMASession.AccAfter1MFB_lateLearning_LowProb];
% 
% 
% addOnTable = nanrem(table(LRSD_all_early,LRSD_all_late,LRSD_HC_early,LRSD_HC_late,LRSD_LC_early,LRSD_LC_late,...
%     Pcorr2MFB_LC,Pcorr1MFB_LC)); 
% 
% REFIT_Chicago_DataM =[REFIT_Chicago_DataM,addOnTable];
% 
% save("REFIT_Chicago_Data_long.mat","REFIT_Chicago_DataM")
% writetable(REFIT_Chicago_DataM, 'REFIT_Chicago_Data_long.csv');





