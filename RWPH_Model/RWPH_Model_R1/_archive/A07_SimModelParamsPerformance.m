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


MH = load('data/fminconResults/DrugS_wGenPrior_fminconResult_111110.mat');

%load('data/all_behavior_PLSession.mat');
load('data/PLS_wGenPriors_Data_111110.mat')
PL = load('data/fminconResults/PLS_wGenPriors_fminconResult_111110.mat');
load('all_EndPOints_PLS.mat')


Params = [MH.fminconResult.fitParams;PL.fminconResult.fitParams];

MeanParams   = mean(Params);

ap       = MeanParams;

invT_Value          = unifrnd(min(Params(:,1)),max(Params(:,1)),1000,1);
playBias_Value      = unifrnd(min(Params(:,2)),max(Params(:,2)),1000,1);
etaValue            = unifrnd(0,1,1000,1);
intcpt_Value        = unifrnd(min(Params(:,4)),max(Params(:,4)),1000,1);
FeedConfrim_Value   = unifrnd(min(Params(:,5)),max(Params(:,5)),1000,1);


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

        %ap(1) =  invT_Value(s);
        %ap(2) =  playBias_Value(s);
        %ap(3) = etaValue(s);
        %ap(4) = intcpt_Value(s);
        ap(4) =FeedConfrim_Value(s);

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

load("data/DeltaPoints_Eta_orgInvT.mat");

Points      = [simD.BounsSum];

%p           = polyfit(invT_Value,Points,4);
%p           = polyfit(playBias_Value,Points,4);
%p           = polyfit(etaValue,Points,4);
%p           = polyfit(intcpt_Value,Points,4);
p           = polyfit(FeedConfrim_Value,Points,4);
x1          = linspace(min(Params(:,5)),max(Params(:,5)),1000);
y1          = polyval(p,x1);

PredPoints_PL = polyval(p,PL.fminconResult.fitParams(:,5));
PredPoints_MH = polyval(p,MH.fminconResult.fitParams(:,5));

DeltaPoints_Poly  = PredPoints_MH-PredPoints_PL;

excluda_expSession = [30,60,90,97];
DeltaPoints_Poly(excluda_expSession)=[];
indexExclude_missingO = [3,4,6,7,31,47,59,62,83,84,95,100,101,102,108];
DeltaPoints_Poly(indexExclude_missingO)=[];

DeltaPoints(2,:)  = DeltaPoints_Poly;

[r_poly,p_poly] = corr(DeltaPoints')



figure(2);clf;
%plot(etaValue,Points,'o')
%plot(invT_Value,Points,'o')
%plot(playBias_Value,Points,'o')
%plot(intcpt_Value,Points,'o')
plot(FeedConfrim_Value,Points,'o')

hold on
plot(x1,y1,LineWidth=2)
%xline(x1(y1==highscore),LineWidth=2)
%xline(.24,LineWidth=3,Color=[0.6350 0.0780 0.1840])% low orientation MPH
%xline(.33,LineWidth=3,Color=[0.4940 0.1840 0.5560])% low orientation PLA
ylabel('Points');
%xlabel('Eta');
%xlabel('InvT');
%xlabel('playBias');
%xlabel('Intcpt');
xlabel('FeedConfrim_Value');
h = gcf;
h.Position=[512   458   420   513];

ert
% print2pdf(fullfile(pwd,'FIgures',['invT_GridPoints_orginvT.pdf']),h,300)
% save("data/invT_Sim_orginvT.mat","invT_Value","Points")

%print2pdf(fullfile(pwd,'FIgures',['playBias_GridPoints_orginvT.pdf']),h,300)
%save("data/playBias_Sim_orginvT.mat","playBias_Value","Points")

% print2pdf(fullfile(pwd,'FIgures',['EtaGridPoints_orginvT.pdf']),h,300)
% save("data/EtaSim_orginvT.mat","etaValue","Points")

% print2pdf(fullfile(pwd,'FIgures',['intcpt_GridPoints_orginvT.pdf']),h,300)
% save("data/intcpt_Sim_orginvT.mat","intcpt_Value","Points")

print2pdf(fullfile(pwd,'FIgures',['FeedConfrim_GridPoints_orginvT.pdf']),h,300)
save("data/FeedConfrim_Sim_orginvT.mat","FeedConfrim_Value","Points")

