clear

rootDir = pwd;
addpath(genpath(rootDir));

% Load data

%load('data/all_behavior_DurgSession.mat');
%load('data/all_behavior_PLSession.mat');
%load('data/all_behavior_Orientation_idealObs.mat');
%load('data/all_behavior_Session1.mat');
load('data/all_behavior_Session2.mat');

RS_lateLearning_HighProb = nan(length(D),1);
RS_earlyLearing_HighProb = nan(length(D),1);

RS_lateLearning_LowProb = nan(length(D),1);
RS_earlyLearing_LowProb = nan(length(D),1);

RS_Err_lateLearning_HighProb = nan(length(D),1);
RS_Err_earlyLearing_HighProb = nan(length(D),1);

RS_Err_lateLearning_LowProb = nan(length(D),1);
RS_Err_earlyLearing_LowProb = nan(length(D),1);

CorrChoice_earlyLearing_HighProb = nan(length(D),1);
CorrChoice_lateLearning_HighProb = nan(length(D),1);

CorrChoice_earlyLearing_LowProb = nan(length(D),1);
CorrChoice_lateLearning_LowProb = nan(length(D),1);

RS_Err_very_earlyLearing_HighProb = nan(length(D),1);
RS_Err_very_earlyLearing_LowProb = nan(length(D),1);


AccAfterMisleadingFB_earlyLearing_LowProb   = nan(length(D),1);
AccAfterMisleadingFB_lateLearning_LowProb    = nan(length(D),1);

AccAfterMisleadingFB_earlyLearing_HighProb   = nan(length(D),1);
AccAfterMisleadingFB_lateLearning_HighProb    = nan(length(D),1);

for i = 1:length(D)

    Data = D(i);

    %Data = dstruct(i);

    Data.RS  = nan(size(Data.choice));
    for ii = 2:Data.Nch; if Data.choice(ii) == Data.choice(ii-1); Data.RS(ii) = 0;elseif  Data.choice(ii) ~= Data.choice(ii-1); Data.RS(ii) = 1;end; end

    Data.RS(find(Data.reversal==1)) = nan;

    % generate varibale coding for missleading feedback
    MissleadingFeedback = nan(Data.Nch,1);
    MissleadingFeedback(Data.Prob > 50 & Data.outcome == 0) = 1;
    MissleadingFeedback(Data.Prob < 50 & Data.outcome == 1) = 1;
    MissleadingFeedback(Data.Prob > 50 & Data.outcome == 1) = 0;
    MissleadingFeedback(Data.Prob < 50 & Data.outcome == 0) = 0;

    PrevMissleading         = nan(Data.Nch,1);
    PrevMissleading(2:end)  = MissleadingFeedback(1:end-1);

    index = find(Data.reversal==1);

    InfoStim1 = find(Data.Stimno == 1 & Data.SymStage == 1);
    InfoStim2 = find(Data.Stimno == 2 & Data.SymStage == 1);
    InfoStim3 = find(Data.Stimno == 3 & Data.SymStage == 1);

    if length(InfoStim1)==7

        InfoStim1(8)=InfoStim2(1);
    end

%     iReversalsall_lateLearning = [InfoStim1(1)+10:InfoStim1(2)-1 InfoStim1(2)+10:InfoStim1(3)-1 InfoStim1(3)+10:InfoStim1(4)-1 ...
%         InfoStim1(4)+10:InfoStim1(5)-1 InfoStim1(5)+10:InfoStim1(6)-1 InfoStim1(7)+10:InfoStim1(8)-1 ...
%         InfoStim2(1)+10:InfoStim2(2)-1 InfoStim2(2)+10:InfoStim2(3)-1 InfoStim2(3)+10:InfoStim2(4)-1 ...
%         InfoStim2(4)+10:InfoStim2(5)-1 InfoStim2(5)+10:InfoStim2(6)-1 InfoStim2(7)+10:InfoStim2(8)-1 ...
%         InfoStim3(1)+10:InfoStim3(2)-1 InfoStim3(2)+10:InfoStim3(3)-1 InfoStim3(3)+10:InfoStim3(4)-1 ...
%         InfoStim3(4)+10:InfoStim3(5)-1 InfoStim3(5)+10:InfoStim3(6)-1 InfoStim3(7)+10:InfoStim3(8)-1];


    iReversalsall_lateLearning = [InfoStim1(1)+10:InfoStim1(1)+29 InfoStim1(2)+10:InfoStim1(2)+29 InfoStim1(3)+10:InfoStim1(3)+29 ...
        InfoStim1(4)+10:InfoStim1(4)+29 InfoStim1(5)+10:InfoStim1(5)+29 InfoStim1(7)+10:InfoStim1(7)+29 ...
        InfoStim2(1)+10:InfoStim2(1)+29 InfoStim2(2)+10:InfoStim2(2)+29 InfoStim2(3)+10:InfoStim2(3)+29 ...
        InfoStim2(4)+10:InfoStim2(4)+29 InfoStim2(5)+10:InfoStim2(5)+29 InfoStim2(7)+10:InfoStim2(7)+29 ...
        InfoStim3(1)+10:InfoStim3(1)+29 InfoStim3(2)+10:InfoStim3(2)+29 InfoStim3(3)+10:InfoStim3(3)+29 ...
        InfoStim3(4)+10:InfoStim3(4)+29 InfoStim3(5)+10:InfoStim3(5)+29 InfoStim3(7)+10:InfoStim3(7)+29];

    iReversalsall_earlyLearning = [InfoStim1(1):InfoStim1(1)+9 InfoStim1(2):InfoStim1(2)+9 InfoStim1(3):InfoStim1(3)+9 ...
        InfoStim1(4):InfoStim1(4)+9 InfoStim1(5):InfoStim1(5)+9 InfoStim1(7):InfoStim1(7)+9 ...
        InfoStim2(1):InfoStim2(1)+9 InfoStim2(2):InfoStim2(2)+9 InfoStim2(3):InfoStim2(3)+9 ...
        InfoStim2(4):InfoStim2(4)+9 InfoStim2(5):InfoStim2(5)+9 InfoStim2(7):InfoStim2(7)+9 ...
        InfoStim3(1):InfoStim3(1)+9 InfoStim3(2):InfoStim3(2)+9 InfoStim3(3):InfoStim3(3)+9 ...
        InfoStim3(4):InfoStim3(4)+9 InfoStim3(5):InfoStim3(5)+9 InfoStim3(7):InfoStim3(7)+9];

    iReversalsall_earlyLearningV2 = [InfoStim1(1)+1:InfoStim1(1)+9 InfoStim1(2)+1:InfoStim1(2)+9 InfoStim1(3)+1:InfoStim1(3)+9 ...
        InfoStim1(4)+1:InfoStim1(4)+9 InfoStim1(5)+1:InfoStim1(5)+9 InfoStim1(7)+1:InfoStim1(7)+9 ...
        InfoStim2(1)+1:InfoStim2(1)+9 InfoStim2(2)+1:InfoStim2(2)+9 InfoStim2(3)+1:InfoStim2(3)+9 ...
        InfoStim2(4)+1:InfoStim2(4)+9 InfoStim2(5)+1:InfoStim2(5)+9 InfoStim2(7)+1:InfoStim2(7)+9 ...
        InfoStim3(1)+1:InfoStim3(1)+9 InfoStim3(2)+1:InfoStim3(2)+9 InfoStim3(3)+1:InfoStim3(3)+9 ...
        InfoStim3(4)+1:InfoStim3(4)+9 InfoStim3(5)+1:InfoStim3(5)+9 InfoStim3(7)+1:InfoStim3(7)+9];

    %       iReversalsall = [InfoStim1(2):InfoStim1(2)+29 InfoStim1(3):InfoStim1(3)+29 ...
    %         InfoStim1(4):InfoStim1(4)+29 InfoStim1(5):InfoStim1(5)+29 InfoStim1(7):InfoStim1(7)+29 ...
    %         InfoStim2(2):InfoStim2(2)+29 InfoStim2(3):InfoStim2(3)+29 ...
    %         InfoStim2(4):InfoStim2(4)+29 InfoStim2(5):InfoStim2(5)+29 InfoStim2(7):InfoStim2(7)+29 ...
    %         InfoStim3(2):InfoStim3(2)+29 InfoStim3(3):InfoStim3(3)+29 ...
    %         InfoStim3(4):InfoStim3(4)+29 InfoStim3(5):InfoStim3(5)+29 InfoStim3(7):InfoStim3(7)+29];

    RS      = Data.RS'; % is the current trial a switch
    Prob    = Data.Prob';

    CorrChoice = Data.CorrectResp';

    CorrChoice_earlyLearing_HighProb(i) = sum(CorrChoice(iReversalsall_earlyLearning)==1 &(Prob(iReversalsall_earlyLearning)==80 | Prob(iReversalsall_earlyLearning)==20))/sum(Prob(iReversalsall_earlyLearning)==80 | Prob(iReversalsall_earlyLearning)==20);
    CorrChoice_lateLearning_HighProb(i) = sum(CorrChoice(iReversalsall_lateLearning)==1 &(Prob(iReversalsall_lateLearning)==80 | Prob(iReversalsall_lateLearning)==20))/sum(Prob(iReversalsall_lateLearning)==80 | Prob(iReversalsall_lateLearning)==20);

    CorrChoice_earlyLearing_LowProb(i) = sum(CorrChoice(iReversalsall_earlyLearning)==1 &(Prob(iReversalsall_earlyLearning)==70 | Prob(iReversalsall_earlyLearning)==30))/sum(Prob(iReversalsall_earlyLearning)==70 | Prob(iReversalsall_earlyLearning)==30);
    CorrChoice_lateLearning_LowProb(i) = sum(CorrChoice(iReversalsall_lateLearning)==1 &(Prob(iReversalsall_lateLearning)==70 | Prob(iReversalsall_lateLearning)==30))/sum(Prob(iReversalsall_lateLearning)==70 | Prob(iReversalsall_lateLearning)==30);

    RS_earlyLearing_HighProb(i) = sum(RS(iReversalsall_earlyLearning)==1 &(Prob(iReversalsall_earlyLearning)==80 | Prob(iReversalsall_earlyLearning)==20))/sum(Prob(iReversalsall_earlyLearning)==80 | Prob(iReversalsall_earlyLearning)==20);
    RS_lateLearning_HighProb(i) = sum(RS(iReversalsall_lateLearning)==1 &(Prob(iReversalsall_lateLearning)==80 | Prob(iReversalsall_lateLearning)==20))/sum(Prob(iReversalsall_lateLearning)==80 | Prob(iReversalsall_lateLearning)==20);

    RS_earlyLearing_LowProb(i) = sum(RS(iReversalsall_earlyLearning)==1 & (Prob(iReversalsall_earlyLearning)==70 | Prob(iReversalsall_earlyLearning)==30))/sum(Prob(iReversalsall_earlyLearning)==70 | Prob(iReversalsall_earlyLearning)==30);
    RS_lateLearning_LowProb(i) = sum(RS(iReversalsall_lateLearning)==1 & (Prob(iReversalsall_lateLearning)==70 | Prob(iReversalsall_lateLearning)==30))/sum(Prob(iReversalsall_lateLearning)==70 | Prob(iReversalsall_lateLearning)==30);

    RS_Err_earlyLearing_HighProb(i) = sum(CorrChoice(iReversalsall_earlyLearning)==0 & RS(iReversalsall_earlyLearning)==1 & (Prob(iReversalsall_earlyLearning)==80 | Prob(iReversalsall_earlyLearning)==20))/sum(RS(iReversalsall_earlyLearning)==1 & Prob(iReversalsall_earlyLearning)==80 | Prob(iReversalsall_earlyLearning)==20);
    RS_Err_lateLearning_HighProb(i) = sum(CorrChoice(iReversalsall_lateLearning)==0 & RS(iReversalsall_lateLearning)==1 & (Prob(iReversalsall_lateLearning)==80 | Prob(iReversalsall_lateLearning)==20))/sum(RS(iReversalsall_lateLearning)==1 & Prob(iReversalsall_lateLearning)==80 | Prob(iReversalsall_lateLearning)==20);

    RS_Err_earlyLearing_LowProb(i) = sum(CorrChoice(iReversalsall_earlyLearning)==0 & RS(iReversalsall_earlyLearning)==1 & (Prob(iReversalsall_earlyLearning)==70 | Prob(iReversalsall_earlyLearning)==30))/sum(RS(iReversalsall_earlyLearning)==1 & Prob(iReversalsall_earlyLearning)==70 | Prob(iReversalsall_earlyLearning)==30);
    RS_Err_lateLearning_LowProb(i) = sum(CorrChoice(iReversalsall_lateLearning)==0 & RS(iReversalsall_lateLearning)==1 & (Prob(iReversalsall_lateLearning)==70 | Prob(iReversalsall_lateLearning)==30))/sum(RS(iReversalsall_lateLearning)==1 & Prob(iReversalsall_lateLearning)==70 | Prob(iReversalsall_lateLearning)==30);
   

    AccAfterMisleadingFB_earlyLearing_LowProb(i)  = sum(CorrChoice(iReversalsall_earlyLearningV2)==1 & (PrevMissleading(iReversalsall_earlyLearningV2-1)==1 | PrevMissleading(iReversalsall_earlyLearningV2)==1) & (Prob(iReversalsall_earlyLearningV2)==70 | Prob(iReversalsall_earlyLearningV2)==30)) ...
                                                    /sum((PrevMissleading(iReversalsall_earlyLearningV2-1)==1 | PrevMissleading(iReversalsall_earlyLearningV2)==1) & (Prob(iReversalsall_earlyLearningV2)==70 | Prob(iReversalsall_earlyLearningV2)==30));
    AccAfterMisleadingFB_lateLearning_LowProb(i)  = sum(CorrChoice(iReversalsall_lateLearning)==1 & (PrevMissleading(iReversalsall_lateLearning-1)==1 | PrevMissleading(iReversalsall_lateLearning)==1) & (Prob(iReversalsall_lateLearning)==70 | Prob(iReversalsall_lateLearning)==30)) ...
                                                    /sum((PrevMissleading(iReversalsall_lateLearning-1)==1 | PrevMissleading(iReversalsall_lateLearning)==1) & (Prob(iReversalsall_lateLearning)==70 | Prob(iReversalsall_lateLearning)==30));

    AccAfterMisleadingFB_lateLearning_HighProb(i)  = sum(CorrChoice(iReversalsall_lateLearning)==1 & (PrevMissleading(iReversalsall_lateLearning-1)==1 | PrevMissleading(iReversalsall_lateLearning)==1) &(Prob(iReversalsall_lateLearning)==80 | Prob(iReversalsall_lateLearning)==20)) ...
                                                    /sum((PrevMissleading(iReversalsall_lateLearning-1)==1 | PrevMissleading(iReversalsall_lateLearning)==1) & (Prob(iReversalsall_lateLearning)==80 | Prob(iReversalsall_lateLearning)==20));
                                                    

end

ert

RawInfoSession2 = struct;

RawInfoSession2.RS_earlyLearning_HighProb  = RS_earlyLearing_HighProb;
RawInfoSession2.RS_lateLearning_HighProb   = RS_lateLearning_HighProb;

RawInfoSession2.RS_earlyLearning_LowProb  = RS_earlyLearing_LowProb;
RawInfoSession2.RS_lateLearning_LowProb   = RS_lateLearning_LowProb;

RawInfoSession2.RS_Err_earlyLearning_HighProb  = RS_Err_earlyLearing_HighProb;
RawInfoSession2.RS_Err_lateLearning_HighProb   = RS_Err_lateLearning_HighProb;

RawInfoSession2.RS_Err_earlyLearning_LowProb  = RS_Err_earlyLearing_LowProb;
RawInfoSession2.RS_Err_lateLearning_LowProb   = RS_Err_lateLearning_LowProb;

RawInfoSession2.CorrChoice_earlyLearning_HighProb  = CorrChoice_earlyLearing_HighProb;
RawInfoSession2.CorrChoice_lateLearning_HighProb   = CorrChoice_lateLearning_HighProb;

RawInfoSession2.CorrChoice_earlyLearning_LowProb  = CorrChoice_earlyLearing_LowProb;
RawInfoSession2.CorrChoice_lateLearning_LowProb   = CorrChoice_lateLearning_LowProb;

RawInfoSession2.AccAfterMisleadingFB_earlyLearing_LowProb   = AccAfterMisleadingFB_earlyLearing_LowProb;
RawInfoSession2.AccAfterMisleadingFB_lateLearning_LowProb   = AccAfterMisleadingFB_lateLearning_LowProb;
RawInfoSession2.AccAfterMisleadingFB_lateLearning_HighProb  = AccAfterMisleadingFB_lateLearning_HighProb;


save("data/RawInfoSession2","RawInfoSession2")
