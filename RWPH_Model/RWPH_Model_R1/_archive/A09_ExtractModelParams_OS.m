clear
rootDir = pwd;
addpath(genpath(rootDir));


load('data/fminconResults/fminconResult_wPrior_111110.mat')
InvTOS        = fminconResult.fitParams(:,1);
PlayBiasOS    = fminconResult.fitParams(:,2);
EtaOS         = fminconResult.fitParams(:,3);
LRIntcptOS    = fminconResult.fitParams(:,4);
LRFeedConfOS  = fminconResult.fitParams(:,5);

load('data/RawInfoDrugSession_V2.mat')
load('data/RawInfoPLSession_V2.mat')

load('data/InfoSubjects.mat')
load('Data/SessionInfo.mat')
load('data/all_EndPOints_Orientation.mat')

% Orientation
excluda_O                           = [26,79,86];
excluda_expSession                  = [30,60,90,97];
ID(excluda_expSession)              = [];
Session1(excluda_expSession)        = [];

Shortname(excluda_O)            = [];
EndPOints_O(excluda_O)          = [];

InvTOS(excluda_O)           = [];
PlayBiasOS(excluda_O)       = [];
EtaOS(excluda_O)            = [];
LRIntcptOS(excluda_O)       = [];
LRFeedConfOS(excluda_O)     = [];

split = median(EndPOints_O);

indexLowScoreO  = find(EndPOints_O<=split);
indexHighScoreO = find(EndPOints_O>split);

PerformanceGroup = ones(94,1);
PerformanceGroup(indexHighScoreO)=2;
%%

EXL = table(Shortname,PerformanceGroup,EndPOints_O,...
           InvTOS,PlayBiasOS,EtaOS,LRIntcptOS,LRFeedConfOS);

writetable(EXL, 'data/REFIT_ChicagoMA_ModelParams_BLS.xlsx')


