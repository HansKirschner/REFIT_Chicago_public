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

%%
clear
%load('data/Data_and_Sim_Drug.mat')
load('data/Data_and_Sim_O.mat')
%load('data/Data_and_Sim_PLA.mat')

for i = 1: length(D)
    D(i).lowCIChoice    = D(i).lowCIChoice';
    D(i).highCIChoice   = D(i).highCIChoice';
    D(i).LR             = D(i).LR';
   
end

SymStage = [];
n = size(D,2);
for c =  1 : n
    US = D(c).SymStage'; If = 1; AllI = [];
    for c2 = 2 : length(US)
        if US(c2)<=US(c2-1) %end of stage
            if US(c2-1)>25
                
                AllI = [AllI If:c2-1];
            end
            If = c2;
        end
    end
    length(AllI);
    AllIAll(c) = {AllI};
    SymStage = [SymStage D(c).SymStage(AllI)'];
end
SymStage

% Change all fieldnames into equally size arrays
FN = fieldnames(D); FN(1) = [];
for c = 2 : length(FN)-2
    eval([FN{c} ' = [];'])
    for c2 = 1 : n
        eval([FN{c} ' = [' FN{c} ' D(c2).(FN{c})(AllIAll{c2})''];'])
    end
end

O_choice            = choice;
O_Prob              = Prob;
O_ChoiceProb        = ChoiceProb;
O_LR                = RL_LR;
O_Stimno            = Stimno;
O_ProbChange        = ProbChange;
O_EV                = EV;
O_RPE               = RPE;
O_minSimPC          = minSimPC;
O_maxSimPC          = maxSimPC;
O_Points_mean       = [D.SimBonus_mean]';
O_Points_median     = [D.SimBonus_median]';
O_lowCIChoice       = lowCIChoice;
O_highCIChoice      = highCIChoice;
O_idealLR           = LR;


save('data/O_BehavSum.mat',"O_LR","O_ChoiceProb","O_Prob","O_choice",...
    "O_Stimno","O_ProbChange","O_EV","O_RPE","O_maxSimPC","O_minSimPC","O_Points_mean",...
    "O_Points_median","O_lowCIChoice","O_highCIChoice","O_idealLR")

%% exclusion of subjects
clear
load('data/D_BehavSum.mat')
load('data/PLA_BehavSum.mat')
load('data/O_BehavSum.mat')

load('data/InfoSubjects.mat')
load('data/all_EndPOints_Orientation.mat')
load('data/all_EndPOints_PLS.mat')
load('data/all_EndPOints_DS.mat')


% Orientation
excluda_O                           = [26,79,86];
excluda_expSession                  = [30,60,90,97];
ID(excluda_expSession)              = [];


O_choice(:,excluda_O)          = [];
O_Prob(:,excluda_O)            = [];
O_ChoiceProb(:,excluda_O)      = [];
O_LR(:,excluda_O)              = [];
O_Stimno(:,excluda_O)          = [];
O_ProbChange(:,excluda_O)      = [];
O_EV(:,excluda_O)              = [];
O_RPE(:,excluda_O)             = [];
O_minSimPC(:,excluda_O)        = [];
O_maxSimPC(:,excluda_O)        = [];

O_Points_mean(excluda_O)       = [];
O_Points_median(excluda_O)     = [];
O_lowCIChoice(:,excluda_O)     = [];
O_highCIChoice(:,excluda_O)    = [];
O_idealLR(:,excluda_O)         = [];


PLS_choice(:,excluda_expSession)          = [];
PLS_Prob(:,excluda_expSession)            = [];
PLS_ChoiceProb(:,excluda_expSession)      = [];
PLS_LR(:,excluda_expSession)              = [];
PLS_Stimno(:,excluda_expSession)          = [];
PLS_ProbChange(:,excluda_expSession)      = [];
PLS_EV(:,excluda_expSession)              = [];
PLS_RPE(:,excluda_expSession)             = [];
PLS_minSimPC(:,excluda_expSession)        = [];
PLS_maxSimPC(:,excluda_expSession)        = [];
PLS_Points_mean(excluda_expSession)       = [];
PLS_Points_median(excluda_expSession)     = [];
PLS_lowCIChoice(:,excluda_expSession)        = [];
PLS_highCIChoice(:,excluda_expSession)        = [];


D_choice(:,excluda_expSession)          = [];
D_Prob(:,excluda_expSession)            = [];
D_ChoiceProb(:,excluda_expSession)      = [];
D_LR(:,excluda_expSession)              = [];
D_Stimno(:,excluda_expSession)          = [];
D_ProbChange(:,excluda_expSession)      = [];
D_EV(:,excluda_expSession)              = [];
D_RPE(:,excluda_expSession)             = [];
D_minSimPC(:,excluda_expSession)        = [];
D_maxSimPC(:,excluda_expSession)        = [];
D_Points_mean(excluda_expSession)       = [];
D_Points_median(excluda_expSession)     = [];
D_lowCIChoice(:,excluda_expSession)        = [];
D_highCIChoice(:,excluda_expSession)        = [];

Shortname(excluda_O)                        = [];
EndPOints_O(excluda_O)                      = [];

EndPOints_DS(excluda_expSession)            = [];
EndPOints_PLS(excluda_expSession)           = [];

LIA                             = ismember(ID,Shortname,'rows');
indexExclude_missingO           = find(LIA==0)';


PLS_choice(:,indexExclude_missingO)          = [];
PLS_Prob(:,indexExclude_missingO)            = [];
PLS_ChoiceProb(:,indexExclude_missingO)      = [];
PLS_LR(:,indexExclude_missingO)              = [];
PLS_Stimno(:,indexExclude_missingO)          = [];
PLS_ProbChange(:,indexExclude_missingO)      = [];
PLS_EV(:,indexExclude_missingO)              = [];
PLS_RPE(:,indexExclude_missingO)             = [];
PLS_minSimPC(:,indexExclude_missingO)        = [];
PLS_maxSimPC(:,indexExclude_missingO)        = [];
PLS_Points_mean(indexExclude_missingO)       = [];
PLS_Points_median(indexExclude_missingO)     = [];
PLS_lowCIChoice(:,indexExclude_missingO)        = [];
PLS_highCIChoice(:,indexExclude_missingO)        = [];


D_choice(:,indexExclude_missingO)          = [];
D_Prob(:,indexExclude_missingO)            = [];
D_ChoiceProb(:,indexExclude_missingO)      = [];
D_LR(:,indexExclude_missingO)              = [];
D_Stimno(:,indexExclude_missingO)          = [];
D_ProbChange(:,indexExclude_missingO)      = [];
D_EV(:,indexExclude_missingO)              = [];
D_RPE(:,indexExclude_missingO)             = [];
D_minSimPC(:,indexExclude_missingO)        = [];
D_maxSimPC(:,indexExclude_missingO)        = [];
D_Points_mean(indexExclude_missingO)       = [];
D_Points_median(indexExclude_missingO)     = [];
D_lowCIChoice(:,indexExclude_missingO)        = [];
D_highCIChoice(:,indexExclude_missingO)        = [];


EndPOints_DS(indexExclude_missingO)            = [];
EndPOints_PLS(indexExclude_missingO)           = [];

split = median(EndPOints_O);

indexLowScoreO  = find(EndPOints_O<=split);
indexHighScoreO = find(EndPOints_O>split);



SEM = std(O_minSimPC,0,2)/sqrt(size(O_minSimPC,2));            % Standard Error
ts = tinv([0.0000000000001  0.9999999999999],length(O_minSimPC)-1);      % T-Score
CI = mean(O_minSimPC,2) + ts.*SEM;               % Confidence Intervals
minPC_O = CI(:,1);

SEM = std(O_maxSimPC,0,2)/sqrt(size(O_maxSimPC,2));            % Standard Error
ts = tinv([0.0000000000001  0.9999999999999],length(O_maxSimPC)-1);      % T-Score
CI = mean(O_maxSimPC,2) + ts.*SEM;               % Confidence Intervals
maxPC_O = CI(:,2);


SEM = std(PLS_minSimPC,0,2)/sqrt(size(PLS_minSimPC,2));            % Standard Error
ts = tinv([0.0000000000001  0.9999999999999],length(PLS_minSimPC)-1);      % T-Score
CI = mean(PLS_minSimPC,2) + ts.*SEM;               % Confidence Intervals
minPC_PLS = CI(:,1);

SEM = std(PLS_maxSimPC,0,2)/sqrt(size(PLS_maxSimPC,2));            % Standard Error
ts = tinv([0.0000000000001  0.9999999999999],length(PLS_maxSimPC)-1);      % T-Score
CI = mean(PLS_maxSimPC,2) + ts.*SEM;               % Confidence Intervals
maxPC_PLS = CI(:,2);


SEM = std(D_minSimPC,0,2)/sqrt(size(D_minSimPC,2));            % Standard Error
ts = tinv([0.0000000000001  0.9999999999999],length(D_minSimPC)-1);      % T-Score
CI = mean(D_minSimPC,2) + ts.*SEM;               % Confidence Intervals
minPC_Drug = CI(:,1);

SEM = std(D_maxSimPC,0,2)/sqrt(size(D_maxSimPC,2));            % Standard Error
ts = tinv([0.0000000000001  0.9999999999999],length(D_maxSimPC)-1);      % T-Score
CI = mean(D_maxSimPC,2) + ts.*SEM;               % Confidence Intervals
maxPC_Drug = CI(:,2);


%%
color    = get(groot,'DefaultAxesColorOrder');

figure(1);clf;
subplot(3,1,1)
shadedErrBar([], AGF_running_average(mean(O_choice,2),2,2), AGF_running_average(se(O_choice',0.99),2,2),{'-o', 'color',  color(5,:), 'markerfacecolor', color(5,:), 'markerSize', 2, 'lineWidth', 1});hold on;
plot(AGF_running_average(mean(O_ChoiceProb,2),2,2),'linewidth',3,'Color',color(5,:));
plot(mean(PLS_Prob,2)/100,'LineWidth',2,'Color','k')
xlim([1 length(D_choice)])
set(gca,'xtick',[])
legend({'choice' 'Model choice prob' 'Reward prob'},'FontSize',14,'Location','eastoutside');
set(0,'DefaultLegendAutoUpdate','off')
ylabel('P(choice)','FontSize',14, 'FontWeight', 'bold')
%plot(AGF_running_average(minPC_O,2,2),'-.k',LineWidth=1);
%plot(AGF_running_average(maxPC_O,2,2),'-.k',LineWidth=1); 
plot(AGF_running_average(mean(O_lowCIChoice,2),2,2),'-.k',LineWidth=1);
plot(AGF_running_average(mean(O_highCIChoice,2),2,2),'-.k',LineWidth=1); 


gridxy(find([D_ProbChange(:,1)==1]))
gridxy([find(D_Stimno(:,1) == 2, 1 ) find(D_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');
title({'Orientation Session'})

subplot(3,1,2)
shadedErrBar([], AGF_running_average(mean(D_choice,2),2,2), AGF_running_average(se(D_choice',0.99),2,2),{'-o', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 2, 'lineWidth', 1}); hold on;
plot(AGF_running_average(mean(D_ChoiceProb,2),2,2),'linewidth',3,'Color',color(3,:));
plot(mean(D_Prob,2)/100,'LineWidth',2,'Color','k')
xlim([1 length(D_choice)])
set(gca,'xtick',[])
legend({'choice' 'Model choice prob' 'Reward prob'},'FontSize',14,'Location','eastoutside');
set(0,'DefaultLegendAutoUpdate','off')
ylabel('P(choice)','FontSize',14, 'FontWeight', 'bold')
%plot(AGF_running_average(minPC_Drug,2,2),'-.k',LineWidth=1)
%plot(AGF_running_average(maxPC_Drug,2,2),'-.k',LineWidth=1); 
plot(AGF_running_average(mean(D_lowCIChoice,2),2,2),'-.k',LineWidth=1);
plot(AGF_running_average(mean(D_highCIChoice,2),2,2),'-.k',LineWidth=1); 
gridxy(find([D_ProbChange(:,1)==1]))
gridxy([find(D_Stimno(:,1) == 2, 1 ) find(D_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');
title({'MPH Session'})

subplot(3,1,3)
shadedErrBar([], AGF_running_average(mean(PLS_choice,2),2,2), AGF_running_average(se(PLS_choice',0.99),2,2),{'-o', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 2, 'lineWidth', 1});hold on;
plot(AGF_running_average(mean(PLS_ChoiceProb,2),2,2),'linewidth',3,'Color', color(1,:));
plot(mean(PLS_Prob,2)/100,'LineWidth',2,'Color','k')
xlim([1 length(D_choice)])
set(gca,'xtick',[])
legend({'choice' 'Model choice prob' 'Reward prob'},'FontSize',14,'Location','eastoutside');
set(0,'DefaultLegendAutoUpdate','off')
ylabel('P(choice)','FontSize',14, 'FontWeight', 'bold')
%plot(AGF_running_average(minPC_PLS,2,2),'-.k',LineWidth=1)
%plot(AGF_running_average(maxPC_PLS,2,2),'-.k',LineWidth=1); 
plot(AGF_running_average(mean(D_lowCIChoice,2),2,2),'-.k',LineWidth=1);
plot(AGF_running_average(mean(D_highCIChoice,2),2,2),'-.k',LineWidth=1); 
gridxy(find([D_ProbChange(:,1)==1]))
gridxy([find(D_Stimno(:,1) == 2, 1 ) find(D_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');
title({'PLA Session'})
h=gcf;
h.Position=[-2348         153        2002         787];
print2pdf(fullfile(pwd,'FIgures',['ChoiceBehaviour_AllSessions_withSimV2_newColor.pdf']),h,300)

%% LR Plot
figure(1);clf;
subplot(3,1,1)
shadedErrBar([], AGF_running_average(mean(PLS_LR(:,indexLowScoreO),2),2,2), AGF_running_average(se(O_choice',0.99),2,2),{'-o', 'color',  [0.4940 0.1840 0.5560], 'markerfacecolor', [0.4940 0.1840 0.5560], 'markerSize', 2, 'lineWidth', 1});hold on;
shadedErrBar([], AGF_running_average(mean(D_LR(:,indexLowScoreO),2),2,2), AGF_running_average(se(O_choice',0.99),2,2),{'-o', 'color',  [0.6350 0.0780 0.1840], 'markerfacecolor', [0.6350 0.0780 0.1840], 'markerSize', 2, 'lineWidth', 1});hold on;
plot(mean(O_idealLR,2),'LineWidth',2,'Color','k')
xlim([1 length(D_choice)])
set(gca,'xtick',[])
legend({'PLA' 'MPH' 'ideal LR'},'FontSize',14,'Location','eastoutside');
set(0,'DefaultLegendAutoUpdate','off')
ylabel('LR','FontSize',14, 'FontWeight', 'bold')
gridxy(find([D_ProbChange(:,1)==1]))
gridxy([find(D_Stimno(:,1) == 2, 1 ) find(D_Stimno(:,1) == 3, 1 )],'linewidth',3,'Color','b');


%%
mean(EndPOints_O)
mean(O_Points_mean)

mean(EndPOints_PLS)
mean(PLS_Points_mean)


mean(EndPOints_DS)
mean(D_Points_mean)


