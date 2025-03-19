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

%load('data/all_behavior_PLSession.mat');
%load('data/PLS_wGenPriors_Data_111110.mat')
%load('data/fminconResults/PLS_wGenPriors_fminconResult_111110.mat')

% Moca orginial Data 

load('data/DataMoca_org.mat');
load('data/Data_1110110_wPrior.mat')
load('data/fminconResults/fminconResult_1110110_wPrior.mat')
D = Input;

StdDevParams = std(fminconResult.fitParams,0,1);
MeanParams   = mean(fminconResult.fitParams);

ap = MeanParams;


%D = dstruct;


% Choose parameters to test
paramset2 = {'invT','playBias','eta','intcpt','FeedConfrim'};

allParamSets = {paramset2};
NrSymulations = 100;

SimD = struct;
for i = 1:10

    if i == 1
        etaValue = unifrnd(0,.1,100,1);
    elseif i == 2
        etaValue = unifrnd(.1,.2,100,1);
    elseif i == 3
        etaValue = unifrnd(.2,.3,100,1);
    elseif i == 4
        etaValue = unifrnd(.3,.4,100,1);
    elseif i == 5
        etaValue = unifrnd(.4,.5,100,1);
    elseif i == 6
        etaValue = unifrnd(.5,.6,100,1);
    elseif i == 7
        etaValue = unifrnd(.6,.7,100,1);
    elseif i == 8
        etaValue = unifrnd(.7,.8,100,1);
    elseif i == 9
        etaValue = unifrnd(.8,.9,100,1);
    elseif i == 10
        etaValue = unifrnd(.9,1,100,1);
    end

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
            % get correct index to extract GT params from sample
            index = s - ((length(D)*SymRound));

            if index == length(D), SymRound = SymRound+1; end

            % generate synthetic data
            inputSym    = getBehavModelInput_REFITChicagoRWPH_sim(D(1),allParams(thisParamsBin),nan);

            ap(3) = etaValue(s);

            SymData             = learningFunc_REFITChicagoRWPH_sim(ap, inputSym);

            simD(s).forget      = D(1).forget;
            simD(s).ProbChange  = D(1).ProbChange;
            simD(s).reversal    = D(1).reversal;
            simD(s).outcome     = SymData.outcome;
            simD(s).choice      = SymData.choice;
            simD(s).Prob        = SymData.Prob;
            simD(s).BounsSum    = SymData.BounsSum;
            simD(s).CorrectResp = D(1).CorrectResp;
            simD(s).ProbChange  = D(1).ProbChange;
            
            SymData.LR(SymData.LR>1) = 1;            
            simD(s).LR          = SymData.LR;
        end
    end

    if i == 1
        save("data/SimEtaRange/EtaSim_LR1.mat","simD")
    elseif i == 2
        save("data/SimEtaRange/EtaSim_LR2.mat","simD")
    elseif i == 3
        save("data/SimEtaRange/EtaSim_LR3.mat","simD")
    elseif i == 4
        save("data/SimEtaRange/EtaSim_LR4.mat","simD")
    elseif i == 5
        save("data/SimEtaRange/EtaSim_LR5.mat","simD")
    elseif i == 6
        save("data/SimEtaRange/EtaSim_LR6.mat","simD")
    elseif i == 7
        save("data/SimEtaRange/EtaSim_LR7.mat","simD")
    elseif i == 8
        save("data/SimEtaRange/EtaSim_LR8.mat","simD")
    elseif i == 9
        save("data/SimEtaRange/EtaSim_LR9.mat","simD")
    elseif i == 10
        save("data/SimEtaRange/EtaSim_LR10.mat","simD")
    end
end
%% plot


figure(1);clf;
subplot(5,2,1)
load('data/SimEtaRange/EtaSim_LR1.mat')
LR = extractLR(simD);
shadedErrBar([],AGF_running_average(mean(LR,1),0,0),se(LR,1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 6, 'lineWidth', 2});hold on
ylabel('LR');xlabel('Trials');
title('Eta unif 0:.1 (n=100)')
ylim([.2 .9]);

subplot(5,2,2)
load('data/SimEtaRange/EtaSim_LR2.mat')
LR = extractLR(simD);
shadedErrBar([],AGF_running_average(mean(LR,1),0,0),se(LR,1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 6, 'lineWidth', 2});hold on
ylabel('LR');xlabel('Trials');
title('Eta unif .1:.2 (n=100)')
ylim([.2 .9]);

subplot(5,2,3)
load('data/SimEtaRange/EtaSim_LR3.mat')
LR = extractLR(simD);
shadedErrBar([],AGF_running_average(mean(LR,1),0,0),se(LR,1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 6, 'lineWidth', 2});hold on
ylabel('LR');xlabel('Trials');
title('Eta unif .2:.3 (n=100)')
ylim([.2 .9]);

subplot(5,2,4)
load('data/SimEtaRange/EtaSim_LR4.mat')
LR = extractLR(simD);
shadedErrBar([],AGF_running_average(mean(LR,1),0,0),se(LR,1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 6, 'lineWidth', 2});hold on
ylabel('LR');xlabel('Trials');
title('Eta unif .3:.4 (n=100)')
ylim([.2 .9]);

subplot(5,2,5)
load('data/SimEtaRange/EtaSim_LR5.mat')
LR = extractLR(simD);
shadedErrBar([],AGF_running_average(mean(LR,1),0,0),se(LR,1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 6, 'lineWidth', 2});hold on
ylabel('LR');xlabel('Trials');
title('Eta unif .4:.5 (n=100)')
ylim([.2 .9]);

subplot(5,2,6)
load('data/SimEtaRange/EtaSim_LR6.mat')
LR = extractLR(simD);
shadedErrBar([],AGF_running_average(mean(LR,1),0,0),se(LR,1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 6, 'lineWidth', 2});hold on
ylabel('LR');xlabel('Trials');
title('Eta unif .5:.6 (n=100)')
ylim([.2 1]);

subplot(5,2,7)
load('data/SimEtaRange/EtaSim_LR7.mat')
LR = extractLR(simD);
shadedErrBar([],AGF_running_average(mean(LR,1),0,0),se(LR,1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 6, 'lineWidth', 2});hold on
ylabel('LR');xlabel('Trials');
title('Eta unif .6:.7 (n=100)')
ylim([.2 .9]);

subplot(5,2,8)
load('data/SimEtaRange/EtaSim_LR8.mat')
LR = extractLR(simD);
shadedErrBar([],AGF_running_average(mean(LR,1),0,0),se(LR,1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 6, 'lineWidth', 2});hold on
ylabel('LR');xlabel('Trials');
title('Eta unif .7:.8 (n=100)')
ylim([.2 .9]);

subplot(5,2,9)
load('data/SimEtaRange/EtaSim_LR9.mat')
LR = extractLR(simD);
shadedErrBar([],AGF_running_average(mean(LR,1),0,0),se(LR,1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 6, 'lineWidth', 2});hold on
ylabel('LR');xlabel('Trials');
title('Eta unif .8:.9 (n=100)')
ylim([.2 .9]);

subplot(5,2,10)
load('data/SimEtaRange/EtaSim_LR10.mat')
LR = extractLR(simD);
shadedErrBar([],AGF_running_average(mean(LR,1),0,0),se(LR,1),{'-o', 'color', [0.4940 0.1840 0.5560], 'markerfacecolor',[0.4940 0.1840 0.5560], 'markerSize', 6, 'lineWidth', 2});hold on
ylabel('LR');xlabel('Trials');
title('Eta unif .9:1 (n=100)')
ylim([.2 .9]);

h = gcf; 
h.Position = [584    72   721   929];
print2pdf(fullfile(pwd,'FIgures',['Eta_LRPeakSim_MOCA.pdf']),h,300)

