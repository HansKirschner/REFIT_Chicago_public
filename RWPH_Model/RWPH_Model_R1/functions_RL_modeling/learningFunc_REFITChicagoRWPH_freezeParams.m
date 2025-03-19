function [negLogLike, allLR, expP, ChoiceProb, input, logLike_woPrior, RPE] = learningFunc_REFITChicagoRWPH_freezeParams(params, input)  %input comes from fmincon (initially start_point)


indexLowScoreO  = [6	9	10	11	12	14	15	16	18	20	21	22	23	24	25	26	28	30	31	32	33	34	36	37	39	41	43	45	46	47	50	51	52	58	65	68	70	71	72	74	76	78	79	85	87	89	94];
indexHighScoreO = [1	2	3	4	5	7	8	13	17	19	27	29	35	38	40	42	44	48	49	53	54	55	56	57	59	60	61	62	63	64	66	67	69	73	75	77	80	81	82	83	84	86	88	90	91	92	93];

if ismember(input.Index,indexLowScoreO)
   LowPerformer = true;
else
   LowPerformer = false;
end

%keyboard
minLogLike=-10e10;

load('/Users/hanskirschner/Desktop/REFIT_Chicago/RL_Modeling/RWPH_Model_R1/data/fminconResults/PLS_wGenPriors_fminconResult_111110.mat')


% parameters:

% 1) inverse temperature
% 2) play bias
% 3) N parameters governing the effects of columns of matrix learningMat on
%    learning rate. First one should be intercept.
% allParams = {'invT','playBias','Alpha1Real','eta','kappa','confBias','Alpha1Fictive'};

% First 5 parameters are fixed
invT= params(strcmp(input.paramNames,'invT'));

playBias= params(strcmp(input.paramNames,'playBias'));

if isempty(playBias)

    if LowPerformer==true
        playBias    = mean(fminconResult.fitParams(indexLowScoreO,2));
    else
        playBias    = mean(fminconResult.fitParams(indexHighScoreO,2));
    end
end

intcpt = params(strcmp(input.paramNames,'intcpt'));

if isempty(intcpt)
    if LowPerformer==true
        intcpt     = mean(fminconResult.fitParams(indexLowScoreO,4));
    else
        intcpt     = mean(fminconResult.fitParams(indexHighScoreO,4));
    end
end

eta = params(strcmp(input.paramNames,'eta'));

% rest of parameters control flexible learning rate
% LR_coeffWts=params(~ismember(input.paramNames,{'invT','playBias','eta'}));
if LowPerformer==true
    LR_coeffWts = [intcpt mean(fminconResult.fitParams(indexLowScoreO,5))];
else
    LR_coeffWts = [intcpt mean(fminconResult.fitParams(indexHighScoreO,5))];
end

if isempty(eta)
    if LowPerformer==true
        eta = mean(fminconResult.fitParams(indexLowScoreO,3));
    else
        eta = mean(fminconResult.fitParams(indexHighScoreO,3));
    end
end


if isempty(invT)
    if LowPerformer==true
        invT = mean(fminconResult.fitParams(indexLowScoreO,1));
    else
        invT = mean(fminconResult.fitParams(indexHighScoreO,1));
    end
end

allLR=nan(size(input.outcome));
expP=zeros(size(input.outcome));
RPE=nan(size(input.outcome));
logPChoice=nan(size(input.outcome));
ChoiceProb = nan(size(input.outcome))';

reward = ones(length(input.outcome),1);
reward(input.outcome==0) = -1;

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

end


logPChoice(logPChoice<minLogLike)=minLogLike;
logPChoice(~isfinite(logPChoice))=minLogLike;

logLike_woPrior=nansum(logPChoice);

if input.usePrior==true
    allPriors = nan(1,length(input.paramNames));
    for p = 1:length(input.paramNames)
        thisParamStr = input.paramNames{p};
        if strcmp(thisParamStr,'invT'), paramValue = invT;
        elseif strcmp(thisParamStr,'playBias'), paramValue = playBias;
        elseif strcmp(thisParamStr,'intcpt'), paramValue = intcpt;
        else
            paramValue = params(p);
        end
        
        inputForPrior = getBehavModelInput_REFITChicagoRWPH(input.datastruct,input.paramNames,paramValue);
        allPriors(p) = inputForPrior.priorPdf(strcmp(input.paramNames,thisParamStr));
        allPriors(p) = max([allPriors(p),10e-10]);
    end
    
    totLogPrior = sum(log(allPriors));
else
    totLogPrior=1;
end

% log posterior probability is log prior plus log likelihood:
postProb = logLike_woPrior+totLogPrior;
negLogLike =-postProb;


if negLogLike==0
    keyboard
end


if ~isfinite(negLogLike)
    disp('something fishy happened');
    keyboard
end


end
