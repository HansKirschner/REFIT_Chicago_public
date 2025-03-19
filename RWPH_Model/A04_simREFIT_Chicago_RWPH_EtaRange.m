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

load('data/all_behavior_DurgSession.mat');
load('data/DrugS_wGenPrior_Data_111110.mat');
load('all_EndPOints_DS.mat')

MH = load('data/fminconResults/DrugS_wGenPrior_fminconResult_111110.mat');

%load('data/all_behavior_PLSession.mat');
load('data/PLS_wGenPriors_Data_111110.mat')
PL = load('data/fminconResults/PLS_wGenPriors_fminconResult_111110.mat');
load('all_EndPOints_PLS.mat')


Params = [MH.fminconResult.fitParams;PL.fminconResult.fitParams];

MeanParams   = mean(Params);

ap       = MeanParams;
etaValue = unifrnd(0,1,1000,1);
%etaValue = unifrnd(min(Params(:,3)),max(Params(:,3)),1000,1);

D = dstruct;

% Choose parameters to test
paramset2 = {'invT','playBias','eta','intcpt','FeedConfrim'};

allParamSets = {paramset2};
NrSymulations = 1000;

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
        simD(s).BounsSum    = SymData.BounsSum+50;
        simD(s).CorrectResp = D(1).CorrectResp;
        simD(s).ProbChange  = D(1).ProbChange;
    end
end

Points      = [simD.BounsSum];
[r,p1]      = corr(etaValue,Points')

p           = polyfit(etaValue,Points,4);
x1          = linspace(0,1,100);
y1          = polyval(p,x1);
highscore   = max(y1);

x1(y1==highscore)

figure(2);clf;
plot(etaValue,Points,'o')
hold on
plot(x1,y1,LineWidth=2)
xline(x1(y1==highscore),LineWidth=2)
xline(.24,LineWidth=3,Color=[0.6350 0.0780 0.1840])% low orientation MPH
xline(.33,LineWidth=3,Color=[0.4940 0.1840 0.5560])% low orientation PLA
ylabel('Points');xlabel('Eta')
h = gcf;
h.Position=[512   458   420   513];
%print2pdf(fullfile(pwd,'Figures',['EtaGridPoints_orginvT.pdf']),h,300)
%save("data/EtaSim_orginvT.mat","etaValue","Points")
