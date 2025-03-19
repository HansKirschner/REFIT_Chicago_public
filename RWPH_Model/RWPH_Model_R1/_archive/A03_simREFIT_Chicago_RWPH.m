%% Script to fit a hybrid RWPH model to REFIT Chicago behavior
% using a constrained search algorithm (fmincon)
clear;
rootDir = pwd;
addpath(genpath(rootDir));
set(0,'defaultAxesFontSize',20);
fminconDir = fullfile(rootDir,'data/fminconResults');
savepath = fullfile(rootDir,'data');

% All parameters that can potentially influence decision behavior
allParams = {'invT','playBias','eta','intcpt','FeedConfrim','FeedReality'};

% load('data/all_behavior_Orientation_idealObs.mat');
% load('data/Data_wPrior_111110.mat')
% load('data/fminconResults/fminconResult_wPrior_111110.mat')

% load('data/all_behavior_DurgSession.mat');
% load('data/DrugS_wGenPrior_Data_111110.mat')
% load('data/fminconResults/DrugS_wGenPrior_fminconResult_111110.mat')

% load('data/all_behavior_PLSession.mat');
% load('data/PLS_wGenPriors_Data_111110.mat')
% load('data/fminconResults/PLS_wGenPriors_fminconResult_111110.mat')

% optimal params
load('data/all_behavior_Orientation_idealObs.mat');
load('data/optData_111110.mat');
load('data/fminconResults/optfminconResult_111110.mat')


D = dstruct;

% Choose parameters to test
paramset2 = {'invT','playBias','eta','intcpt','FeedConfrim'};

allParamSets = {paramset2};
NrSymulations = length(D)*10;

SimD = struct;

for tt = 1:length(allParamSets)

    paramsToUse = allParamSets{tt};

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    paramsToFit    = false(length(allParams),1)';
    paramsToFit(ismember(allParams,paramsToUse)) = true;
    paramCount     = sum(paramsToFit);
    allParamsToFit = paramsToFit;
    allParamsToFit = logical(allParamsToFit);


    % Check if this parameter set has been tested
    thisParamsBin = allParamsToFit;
    paramStr = '';
    for k = 1:length(thisParamsBin), paramStr = cat(2,paramStr,num2str(double(thisParamsBin(k)))); end

    SymRound = 0;


    for s = 1:NrSymulations

        s
        % get correct index to extract GT params form sample
        index = s - ((length(D)*SymRound));

        if index == length(D), SymRound = SymRound+1; end

        % generate synthetic data
        inputSym    = getBehavModelInput_REFITChicagoRWPH_sim(D(index),allParams(thisParamsBin),nan);
        SymData     = learningFunc_REFITChicagoRWPH_sim(fminconResult.fitParams(index,:), inputSym);
        
        simD(s).forget      = D(index).forget;
        simD(s).ProbChange  = D(index).ProbChange;
        simD(s).reversal    = D(index).reversal;
        simD(s).outcome     = SymData.outcome;
        simD(s).choice      = SymData.choice;
        simD(s).Prob        = SymData.Prob;
        simD(s).CorrectResp = D(index).CorrectResp;
        simD(s).ProbChange  = D(index).ProbChange;
        simD(s).BonusSum    = SymData.BounsSum;
    end
end

save("data/SimD_OptParams.mat","simD")

