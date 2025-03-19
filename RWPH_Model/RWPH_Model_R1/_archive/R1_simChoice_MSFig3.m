clear;clc;

%% load and prepare the data

load('data/Data_and_Sim_PLA.mat')
load('data/InfoSubjects.mat')
load('data/all_EndPOints_Orientation.mat')
load('data/all_EndPOints_PLS.mat')
load('data/all_EndPOints_DS.mat')

% data exclusion
excluda_O                = [26,79,86];
excluda_expSession       = [30,60,90,97];
ID(excluda_expSession)   = [];

EndPOints_O(excluda_O)   = [];

D(excluda_expSession)    = [];

LIA                      = ismember(ID,Shortname,'rows');
indexExclude_missingO    = find(LIA==0)';

D(indexExclude_missingO) = [];

split = median(EndPOints_O);

indexLowScoreO  = find(EndPOints_O<=split);
indexHighScoreO = find(EndPOints_O>split);

indexLowScoreO_2  = indexLowScoreO+94;
indexHighScoreO_2 = indexHighScoreO+94;

%% ok let's extract the learning curves PLA

LRc_PLA = struct;

for a = 1:length(D)

    ii      = 0;
    iiLC    = 0;
    iiHC    = 0;


    InfoStim1 = find(D(a).Stimno == 1 & D(a).SymStage == 1);
    InfoStim2 = find(D(a).Stimno == 2 & D(a).SymStage == 1);
    InfoStim3 = find(D(a).Stimno == 3 & D(a).SymStage == 1);

    Info1stReversls  = nan(9,1);

    if D(a).Prob(InfoStim1(1)) ~= 50;Info1stReversls(1:3) = InfoStim1(1:3);end
    if D(a).Prob(InfoStim2(1)) ~= 50;Info1stReversls(4:6) = InfoStim2(1:3);end
    if D(a).Prob(InfoStim3(1)) ~= 50;Info1stReversls(7:9) = InfoStim3(1:3);end

    indexReversal = find(D(a).ProbChange == 1);

    for i = 1:length(indexReversal)
        ii = ii +1;

        if D(a).Prob(indexReversal(i)+1) == 30 || D(a).Prob(indexReversal(i)+1) == 70
            iiLC = iiLC +1;
            LRc_PLA(a).PCorrLC(iiLC,:) = D(a).meanCorrectSimChoice(indexReversal(i):indexReversal(i)+29);

        elseif D(a).Prob(indexReversal(i)+1) == 20 || D(a).Prob(indexReversal(i)+1) == 80
            iiHC = iiHC +1;
            LRc_PLA(a).PCorrHC(iiHC,:) = D(a).meanCorrectSimChoice(indexReversal(i):indexReversal(i)+29);

        end
    end

end

%% ok let's extract the learning curves MA
clear D
load('data/Data_and_Sim_MA.mat')

D(excluda_expSession)    = [];
D(indexExclude_missingO) = [];

LRc_MA = struct;

for a = 1:length(D)

    ii      = 0;
    iiLC    = 0;
    iiHC    = 0;


    InfoStim1 = find(D(a).Stimno == 1 & D(a).SymStage == 1);
    InfoStim2 = find(D(a).Stimno == 2 & D(a).SymStage == 1);
    InfoStim3 = find(D(a).Stimno == 3 & D(a).SymStage == 1);

    Info1stReversls  = nan(9,1);

    if D(a).Prob(InfoStim1(1)) ~= 50;Info1stReversls(1:3) = InfoStim1(1:3);end
    if D(a).Prob(InfoStim2(1)) ~= 50;Info1stReversls(4:6) = InfoStim2(1:3);end
    if D(a).Prob(InfoStim3(1)) ~= 50;Info1stReversls(7:9) = InfoStim3(1:3);end

    indexReversal = find(D(a).ProbChange == 1);

    for i = 1:length(indexReversal)
        ii = ii +1;

        if D(a).Prob(indexReversal(i)+1) == 30 || D(a).Prob(indexReversal(i)+1) == 70
            iiLC = iiLC +1;
            LRc_MA(a).PCorrLC(iiLC,:) = D(a).ModelChoice(indexReversal(i):indexReversal(i)+29);

        elseif D(a).Prob(indexReversal(i)+1) == 20 || D(a).Prob(indexReversal(i)+1) == 80
            iiHC = iiHC +1;
            LRc_MA(a).PCorrHC(iiHC,:) = D(a).ModelChoice(indexReversal(i):indexReversal(i)+29);

        end
    end

end

%%

LearningCurve_LC                   = nan(2*94,30);
LearningCurve_HC                   = nan(2*94,30);

for i = 1:2
    for ii = 1:94

        if i == 1
            LearningCurve_LC(ii+((i-1)*94),:) = nanmean([LRc_PLA(ii).PCorrLC],1);
            LearningCurve_HC(ii+((i-1)*94),:) = nanmean([LRc_PLA(ii).PCorrHC],1);
        end
        if i == 2       
            LearningCurve_LC(ii+((i-1)*94),:) = nanmean([LRc_MA(ii).PCorrLC],1);
            LearningCurve_HC(ii+((i-1)*94),:) = nanmean([LRc_MA(ii).PCorrHC],1);
        end
    end
end

color    = get(groot,'DefaultAxesColorOrder');

figure(1);clf;
subplot(1,2,1)
shadedErrBar([],AGF_running_average(mean(LearningCurve_LC(indexLowScoreO,:),1),2,2),se(LearningCurve_LC(indexLowScoreO,:),1),{'-s', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 2});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_LC(indexLowScoreO_2,:),1),2,2),se(LearningCurve_LC(indexLowScoreO_2,:),1),{'-s', 'color',color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 2});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_LC(indexHighScoreO,:),1),2,2),se(LearningCurve_LC(indexHighScoreO,:),1),{'-^', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 2});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_LC(indexHighScoreO_2,:),1),2,2),se(LearningCurve_LC(indexHighScoreO_2,:),1),{'-^', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 2});hold on
legend({'PL_l_o_w';'MPH_l_o_w'; 'PL_h_i_g_h';'MPH_h_i_g_h'},'Location','best');
xlabel('Trials after reversal');
xlim([0 30])
ylim([0.4 .95])

subplot(1,2,2)
shadedErrBar([],AGF_running_average(mean(LearningCurve_HC(indexLowScoreO,:),1),2,2),se(LearningCurve_HC(indexLowScoreO,:),1),{'-s', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 2});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_HC(indexLowScoreO_2,:),1),2,2),se(LearningCurve_HC(indexLowScoreO_2,:),1),{'-s', 'color',color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 2});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_HC(indexHighScoreO,:),1),2,2),se(LearningCurve_HC(indexHighScoreO,:),1),{'-^', 'color', color(1,:), 'markerfacecolor',color(1,:), 'markerSize', 6, 'lineWidth', 2});hold on
shadedErrBar([],AGF_running_average(mean(LearningCurve_HC(indexHighScoreO_2,:),1),2,2),se(LearningCurve_HC(indexHighScoreO_2,:),1),{'-^', 'color', color(3,:), 'markerfacecolor',color(3,:), 'markerSize', 6, 'lineWidth', 2});hold on
legend({'PL_l_o_w';'MPH_l_o_w'; 'PL_h_i_g_h';'MPH_h_i_g_h'},'Location','best');
xlabel('Trials after reversal');
xlim([0 30])
ylim([0.35 .95])

%%
h = gcf;
h.Position = [584   581   560   420];
print2pdf(fullfile(pwd,'FIgures',['LearningRates_newColor_simulation.pdf']),h,300)
% 

%% Test key behavioural result, that MA is increasing the probability of 
% correct choices later at later learning stages noisy reward probabilites 


PCorr_highNoise_late_PL = mean(LearningCurve_LC(indexLowScoreO,11:end),2);
PCorr_highNoise_late_MA = mean(LearningCurve_LC(indexLowScoreO_2,11:end),2);

ttestout(PCorr_highNoise_late_PL,PCorr_highNoise_late_MA,3);


