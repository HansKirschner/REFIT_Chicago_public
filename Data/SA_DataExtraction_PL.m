%% load data
clear
close all;clear all;clc;


loadpath = 'rawData_DDP_Reversal_Learning_Task/_SubFolder/PLG/';

% read data names
files = dir([loadpath 'DDP*.dat']);

% Build Array (VP) with Names and Filenames
for i = 1:length(files)
    VP(1,i) = {strtok(files(i).name(1:8))};
    VP(2,i) = {strtok(files(i).name)};
end

VPN         = sort(VP(1,:)');
VPN_full    = sort(VP(2,:)');


%% Prealocation

Misses              = nan(length(VPN),1);
Index               = nan(length(VPN),1); % 1 = session 1; 2 = session 2
Index2              = nan(length(VPN),1); % 1 = Amph Session 1; 2 = PL Session 1; 3 = Amph Session 2; 4 = PL Session 2
EndPOints_PLS           = nan(length(VPN),1);
Subject             = nan(length(VPN),1);
ChooseNeutral       = nan(length(VPN),1);
ChooseGood          = nan(length(VPN),1);
ChooseBad           = nan(length(VPN),1);

FractionCorrectResp = nan(length(VPN),1);
Shortname           = nan(length(VPN),1);

TrTillCorrect_all   = nan(length(VPN),1);
TrTillCorrect_BG    = nan(length(VPN),1);
TrTillCorrect_GB    = nan(length(VPN),1);



%% Data Extraction
for a = 1:size(VPN,1) %loop over participants and extract relevant info

    a

    %load data
    rd = all_read([loadpath,VPN_full{a}]);

    Shortname(a) = str2double(VPN_full{a}(4:6));


    Misses(a) = length(find(isnan([rd.Feedback])));
    Subject(a) = str2num(VP{1,a}(4:6));

    %recode outcomes
    DelInd  = unique([find([rd.Resp]==0) find([rd.Feedback]==0) find(isnan([rd.Feedback]))']);
    fn      = fieldnames(rd);

    for c = 1 : length(fn)
        rd.(fn{c})(DelInd) = [];
    end

    stimuli_no          = [rd.Stimulus_No];% get an index for all stimuli (re-sort them in order of appearance)
    [~, stimuli_index]  = sort(stimuli_no);
    stimuli_no2         = stimuli_no(stimuli_index);
    TrNr                = [rd.Trial_No];% get another index to re-sort in original order
    TrNr                = TrNr(stimuli_index);
    [~, backsort]       = sort(TrNr);

    %sort the required factors according to this
    Prob        = [rd.Prob_Shown];
    Prob        = Prob(stimuli_index);
    RT          = [rd.RT];
    RT(([rd.RT])<1) = nan;
    RT          = RT(stimuli_index);
    Stimno      = [rd.Stimulus_No];
    Stimno      = Stimno(stimuli_index);

    SymStage    = [rd.SymbolA_Stage rd.SymbolB_Stage rd.SymbolC_Stage];
    ProbStage   = [rd.Prob_A rd.Prob_B rd.Prob_C];
    O           = [rd.Feedback];
    O           = O(stimuli_index);
    event       = nan(length(O),1);

    D(a).Nch    = length(O);

    ForgetCount     = nan(D(a).Nch,1);
    ForgetCount3    = nan(D(a).Nch+1,3);


    SymStage2   = nan(D(a).Nch,1);
    ProbStage2  = nan(D(a).Nch,1);
    for c = 1 : D(a).Nch
        SymStage2(c) = SymStage(c,rd.Stimulus_No(c));
        ProbStage2(c) = ProbStage(c,rd.Stimulus_No(c));

        if O(c) == 1
            event(c) = 1; % real win

        elseif  O(c) == 2
            event(c) = 2; % real loss

        elseif  O(c) == 3
            event(c) = 3; % fictive win

        elseif  O(c) == 4
            event(c) = 4; % fictive loss
        else
            ert
        end

        %count how long ago the stimulus was last seen
        ForgetCount3(c+1,:)             = ForgetCount3(c,:)+1;
        ForgetCount3(c+1,stimuli_no(c)) = 1;
        ForgetCount(c)                  =  ForgetCount3(c,stimuli_no(c));
    end

    ForgetCount             = ForgetCount(stimuli_index);
    SymStage2               = SymStage2(stimuli_index);
    ProbStage2              = ProbStage2(stimuli_index);

    indexStim1_1st = find(SymStage2 == 1 & stimuli_no2 ==1);
    indexStim2_1st = find(SymStage2 == 1 & stimuli_no2 ==2);
    indexStim3_1st = find(SymStage2 == 1 & stimuli_no2 ==3);

    ForgetCount([indexStim1_1st(1) indexStim2_1st(1) indexStim3_1st(1)]) = 0;

    event                   = event'; % 1 = real win, 2 = real loss; 3 = fictive win; 4 = fictive loss

    choice                  = zeros(D(a).Nch,1);
    outcome                 = zeros(D(a).Nch,1);
    outcome(event==1 | event==3) = 1; % 1 = win; 2 = loss
    choice(event<3)         = 1;  % 1 = choose; 0 = avoided
    Response = rd.Resp(stimuli_index);
    Bonus =    rd.Bonus_sum(stimuli_index);

    ChooseNeutral(a) = sum(choice(ProbStage2==50))/length(find(ProbStage2==50));
    ChooseBad(a)     = sum(choice(ProbStage2<50))/length(find(ProbStage2<50));
    ChooseGood(a)    = sum(choice(ProbStage2>50))/length(find(ProbStage2>50));


    C_rep = zeros(D(a).Nch,1);
    C_rep(choice(2:end) == choice(1:end-1)) = 1;

    ProbChange = zeros(D(a).Nch,1);
    ProbChange(SymStage2 == 1) = 1;
    ProbChange([indexStim1_1st(1) indexStim2_1st(1) indexStim3_1st(1)]) = 0;

    ProbChange([indexStim1_1st(end) indexStim2_1st(end) indexStim3_1st(end)]) = 0;

    reversal = zeros(D(a).Nch,1);
    reversal([indexStim1_1st(1) indexStim2_1st(1) indexStim3_1st(1)]) = 1;


    correctResp = nan(length(O),1);
    correctResp(ProbStage2 > 50 & event' < 3) = 1;
    correctResp(ProbStage2 > 50 & event' > 2) = 0;
    correctResp(ProbStage2 < 50 & event' > 2) = 1;
    correctResp(ProbStage2 < 50 & event' < 3) = 0;

    FractionCorrectResp(a) = nansum(correctResp/length(find(ProbStage2~=50)));

    D(a).subno  = Shortname(a);
    D(a).forget = ForgetCount';
    D(a).ProbChange = ProbChange';
    D(a).reversal = reversal';
    D(a).outcome = outcome';
    D(a).choice = choice';
    D(a).event= event;
    D(a).C_rep = C_rep';
    D(a).TrNr = TrNr';
    D(a).Prob = ProbStage2';
    D(a).RT = RT';
    D(a).SymStage = SymStage2';
    D(a).Stimno = Stimno';
    D(a).CorrectResp = correctResp';
    D(a).backsort       = backsort';

    EndPOints_PLS(a) = rd.Bonus_sum(end);


end


ert
% save('Data/all_behavior_PLSession','D');
% save('Data/all_EndPOints_PLS','EndPOints_PLS');

%outlier detection
histogram(Misses)
[~,~,~,~,stats,outlier,outlier_num] = grubbs(Misses, VP(1,:), 0, 0.05,0);

disp(['Grubbs test for outlier detection with a one sided alpha of 0.05 detected: ' num2str(length(outlier_num)) ' outlier.']);
disp(['These are subjects with more than 10 % missed trials with the following IDs: ' outlier{:,1}]);

find(Misses>40)'

excluda_PLS = [ 30    90    97];
VP(1,excluda_PLS)

