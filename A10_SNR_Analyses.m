clear
path('helper/',path)

load('Data/LR_Peaks_MA.mat')
load('Data/LR_Peaks_PL.mat')
load('Data/InfoSubjects.mat')
load('Data/all_EndPOints_Orientation.mat');

%% exclusion of subjects 
% (exclusion criteria: no participantion in the 
% orientation session and high proportion of misses (see data extraction 
% scripts in the data folder))

% Orientation
excluda_O                               = [26,79,86];
excluda_expSession                      = [30,60,90,97];
ID(excluda_expSession)                  = [];
LR_Peaks_MA(excluda_expSession)         = [];
LR_Peaks_PL(excluda_expSession)         = [];
EndPOints_O(excluda_O)                  = [];

Shortname(excluda_O)                    = [];
LIA                                     = ismember(ID,Shortname,'rows');
indexExclude_missingO                   = find(LIA==0)';
LR_Peaks_MA(indexExclude_missingO)      = [];
LR_Peaks_PL(indexExclude_missingO)      = [];

split = median(EndPOints_O);

indexLowScoreO  = find(EndPOints_O<=split);
indexHighScoreO = find(EndPOints_O>split);

%% Run test
SNR_PL = nan(94,1);
for i = 1:94
    SNR_PL(i) = mean([LR_Peaks_PL(i).CP]) - mean(LR_Peaks_PL(i).PE);
end

SNR_MA = nan(94,1);
for i = 1:94
    SNR_MA(i) = mean([LR_Peaks_MA(i).CP]) - mean(LR_Peaks_MA(i).PE);
end

ttestout(SNR_PL(indexLowScoreO),SNR_MA(indexLowScoreO),1);
ttestout(SNR_PL(indexHighScoreO),SNR_MA(indexHighScoreO),1);

%%
% load("Data/REFIT_Chicago_Data_long.mat")
% 
% SNR = [SNR_PL;SNR_MA];
% 
% addOnTable = nanrem(table(SNR)); 
% 
% REFIT_Chicago_DataM =[REFIT_Chicago_DataM,addOnTable];
% 
% save("Data/REFIT_Chicago_Data_long.mat","REFIT_Chicago_DataM")
% writetable(REFIT_Chicago_DataM, 'Data/REFIT_Chicago_Data_long.csv');
% 




