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

%load('data/all_behavior_Orientation_idealObs.mat');
%load('data/Data_wPrior_111110.mat')
%load('data/fminconResults/fminconResult_wPrior_111110.mat')

% load('data/all_behavior_DurgSession.mat');
% load('data/DrugS_wGenPrior_Data_111110.mat')
% load('data/fminconResults/DrugS_wGenPrior_fminconResult_111110.mat')

% load('data/all_behavior_PLSession.mat');
load('data/PLS_wGenPriors_Data_111110.mat')
load('data/fminconResults/PLS_wGenPriors_fminconResult_111110.mat')


D = dstruct;
% Choose parameters to test
paramset2 = {'invT','playBias','eta','intcpt','FeedConfrim'};

allParamSets = {paramset2};


for tt = 1:length(allParamSets)

    paramsToUse = allParamSets{tt};

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    paramsToFit    = false(length(allParams),1)';
    paramsToFit(ismember(allParams,paramsToUse)) = true;
    paramCount     = sum(paramsToFit);
    allParamsToFit = paramsToFit;
    allParamsToFit = logical(allParamsToFit);

    thisParamsBin = allParamsToFit;
    paramStr = '';
    for k = 1:length(thisParamsBin), paramStr = cat(2,paramStr,num2str(double(thisParamsBin(k)))); end

    for vp = 1:length(D)

        vp
        simChoice=[];
        PC=[];

        for s = 1:100

            % generate synthetic data
            inputSym    = getBehavModelInput_REFITChicagoRWPH_sim(D(vp),allParams(thisParamsBin),nan);

            SymData     = learningFunc_REFITChicagoRWPH_sim(fminconResult.fitParams(vp,:), inputSym);

            simChoice(s,:)  = SymData.choice;
            PC(s,:)         = SymData.ChoiceProb;
            BonusSum(vp,s)  = SymData.BounsSum;
        end
        


        SEM = std(simChoice)/sqrt(size(simChoice,1));        % Standard Error
        ts = tinv([0.00001  0.99999],size(simChoice,1)-1);   % T-Score
        CI = mean(simChoice)' + ts.*SEM';                    % Confidence Intervals
        
        D(vp).lowCIChoice       = CI(:,1);
        D(vp).highCIChoice      = CI(:,2);

        ModelChoice = mean(simChoice);
        ModelChoice(D(vp).Prob  <  50) = 1-ModelChoice(D(vp).Prob  <  50);

        ModelChoiceProb_CorrResp = mean(PC);

        ModelChoiceProb_CorrResp(D(vp).Prob  <  50) = 1-ModelChoiceProb_CorrResp(D(vp).Prob  <  50);

        D(vp).meanCorrectSimChoice  = ModelChoiceProb_CorrResp;
        D(vp).ModelChoice           = ModelChoice;

        D(vp).minSimPC          = min(PC);
        D(vp).maxSimPC          = max(PC);
        D(vp).meanSimPC         = mean(PC);
        D(vp).SimBonus_median   = median(BonusSum(vp,:));
        D(vp).SimBonus_mean     = mean(BonusSum(vp,:));
        
        clear PC
    end
end

%% save data
save("data/Data_and_Sim_PLA.mat","D")
%save("data/Data_and_Sim_MA.mat","D")