function [output] = learningFunc_REFITChicagoRWPH_sim(params, input)  %input comes from fmincon (initially start_point)
 
%keyboard

% parameters:

% 1) inverse temperature
% 2) play bias
% 3) N parameters governing the effects of columns of matrix learningMat on
%    learning rate. First one should be intercept.
% allParams = {'invT','playBias','Alpha1Real','eta','kappa','confBias','Alpha1Fictive'};

% First 5 parameters are fixed
invT= params(strcmp(input.paramNames,'invT'));

playBias= params(strcmp(input.paramNames,'playBias'));

eta = params(strcmp(input.paramNames,'eta'));

intcpt = params(strcmp(input.paramNames,'intcpt'));

% rest of parameters control flexible learning rate
LR_coeffWts=params(~ismember(input.paramNames,{'invT','playBias','eta'}));

allLR=nan(size(input.outcome));
expP=zeros(size(input.outcome));
RPE=nan(size(input.outcome));
logPChoice=nan(size(input.outcome));
ChoiceProb = nan(size(input.outcome))';

reward = ones(length(input.outcome),1);
reward(input.outcome==0) = -1;

BonusSum = nan(size(input.outcome))';
points   = nan(size(input.outcome))';

for i = 1:length(input.outcome)
    
    % if this is a new stimuli restet trialProb
    if input.reversal(i)==1
        expP(i)=0;
    end
       
    % If the subject is biased toward playing then they could be described as attributing a higher value
    % to the play option.

    biasedTrialVs=[playBias+expP(i),0];

    % first column computes bet probability, second column = pass
    [pBet_pass, ~]=softMax(biasedTrialVs, invT);
    
    ChoiceProb(i)=pBet_pass(1);

    if input.genDataFlag==true
       input.choice(i)=rand>pBet_pass(2);
    end
    
    % Want this to be close to 0
    % See if the subject made the higher probability choice. If subject
    % chose the higher prob option, logPChoice will be smaller negative
    % value.
    logPChoice(i)=log(pBet_pass( (input.choice(i)==0) +1));
    
    % compute feedback: i.e. delta rule
    % update according to learning rate times prediction error
    % This should be the outcome of the trial that the subject saw.
    RPE(i)= reward(i)-expP(i);
    
    LR_term=input.learningMat(i,:)*LR_coeffWts'; % input.learningMat should have column of ones as first column
    
    if input.reversal(i)==1
        LR=exp(LR_term)./(1+exp(LR_term)); %map unbounded LR_term onto to [0 1] interval
        allLR(i) = LR;
    else
        LR=exp(LR_term*allLR(i))./(1+exp(LR_term*allLR(i)));
    end

    % kappa scales the LR to be between 0 and 1
    newTrialProb = expP(i) + LR * RPE(i);
    
    % stick updated probability and LR in appropriate direction:
    expP(i+1)= newTrialProb;
   
    if ~isempty(eta)
        allLR(i+1)=eta * abs(RPE(i)) + (1-eta)* LR;
    elseif isempty(eta)
        allLR(i+1)=LR;
    end



    if input.pointEstFlag

        if input.choice(i) == 1
            points(i) = reward(i)*10;
        else
            points(i) = 0;
        end

        BonusSum(i) = sum(points(1:i));
    end

end

output = struct;
output.choice       = input.choice;
output.ChoiceProb   = ChoiceProb;
output.outcome      = input.outcome;
output.BounsSum     = BonusSum(end);
output.Prob         = input.Prob;
output.Stimno       = input.stimNr;
output.event        = input.event;
output.reversal     = input.reversal;
output.LR           = allLR;

end
