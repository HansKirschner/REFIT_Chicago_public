
clear

%% compare parameters MPH vs. PLA

load('/Users/hanskirschner/Desktop/REFIT_Chicago/RL_Modeling/RWPH_Model_R1/data/fminconResults/PL_FP_wGenPrior_fminconResult_100000.mat')
InvT_PL = fminconResult.fitParams;

load('/Users/hanskirschner/Desktop/REFIT_Chicago/RL_Modeling/RWPH_Model_R1/data/fminconResults/MA_FP_wGenPrior_fminconResult_100000.mat')
InvT_MA = fminconResult.fitParams;

load('/Users/hanskirschner/Desktop/REFIT_Chicago/RL_Modeling/RWPH_Model_R1/data/fminconResults/PL_FP_wGenPrior_fminconResult_001000.mat')
eta_PL = fminconResult.fitParams;

load('/Users/hanskirschner/Desktop/REFIT_Chicago/RL_Modeling/RWPH_Model_R1/data/fminconResults/MA_FP_wGenPrior_fminconResult_001000.mat')
eta_MA = fminconResult.fitParams;

load('/Users/hanskirschner/Desktop/REFIT_Chicago/RL_Modeling/RWPH_Model_R1/data/fminconResults/PL_FP_wGenPrior_fminconResult_010000.mat')
playBias_PL = fminconResult.fitParams;

load('/Users/hanskirschner/Desktop/REFIT_Chicago/RL_Modeling/RWPH_Model_R1/data/fminconResults/MA_FP_wGenPrior_fminconResult_010000.mat')
playBias_MA = fminconResult.fitParams;

load('/Users/hanskirschner/Desktop/REFIT_Chicago/RL_Modeling/RWPH_Model_R1/data/fminconResults/PL_FP_wGenPrior_fminconResult_000100.mat')
incpt_PL = fminconResult.fitParams;

load('/Users/hanskirschner/Desktop/REFIT_Chicago/RL_Modeling/RWPH_Model_R1/data/fminconResults/MA_FP_wGenPrior_fminconResult_000100.mat')
incpt_MA = fminconResult.fitParams;


% exclusion of subjects
load('data/InfoSubjects.mat')
load('data/all_EndPOints_Orientation.mat')
% Orientation
excluda_O                           = [26,79,86];
excluda_expSession                  = [30,60,90,97];
ID(excluda_expSession)              = [];

%InvT_PL(excluda_expSession)         = [];
%InvT_MA(excluda_expSession)         = [];

%eta_PL(excluda_expSession)         = [];
%eta_MA(excluda_expSession)         = [];

Shortname(excluda_O)            = [];

LIA                             = ismember(ID,Shortname,'rows');
indexExclude_missingO           = find(LIA==0)';

%eta_PL(indexExclude_missingO)         = [];
%eta_MA(indexExclude_missingO)         = [];

% InvT_PL(indexExclude_missingO)     = [];
% InvT_MA(indexExclude_missingO)     = [];

EndPOints_O(excluda_O)              = [];

split = median(EndPOints_O);

indexLowScoreO  = find(EndPOints_O<=split);
indexHighScoreO = find(EndPOints_O>split);


ttestout(eta_PL(indexLowScoreO),eta_MA(indexLowScoreO),1);
ttestout(eta_PL(indexHighScoreO),eta_MA(indexHighScoreO),1);

signrank(eta_PL(indexLowScoreO),eta_MA(indexLowScoreO))
signrank(eta_PL(indexHighScoreO),eta_MA(indexHighScoreO))

ttestout(InvT_PL(indexHighScoreO),InvT_MA(indexHighScoreO),1);
ttestout(InvT_PL(indexLowScoreO),InvT_MA(indexLowScoreO),1);

signrank(InvT_PL(indexHighScoreO),InvT_MA(indexHighScoreO))
signrank(InvT_PL(indexLowScoreO),InvT_MA(indexLowScoreO))


ttestout(playBias_PL(indexHighScoreO),playBias_MA(indexHighScoreO),1);
ttestout(playBias_PL(indexLowScoreO),playBias_MA(indexLowScoreO),1);

signrank(playBias_PL(indexHighScoreO),playBias_MA(indexHighScoreO))
signrank(playBias_PL(indexLowScoreO),playBias_MA(indexLowScoreO))


ttestout(incpt_PL(indexHighScoreO),incpt_MA(indexHighScoreO),1);
ttestout(incpt_PL(indexLowScoreO),incpt_MA(indexLowScoreO),1);

signrank(incpt_PL(indexHighScoreO),incpt_MA(indexHighScoreO))
signrank(incpt_PL(indexLowScoreO),incpt_MA(indexLowScoreO))
