function input = getBehavModelInput_REFITChicagoRWPH_noP(datastruct,paramsToFit,paramValue)
%keyboard
% Function to generate the input for modeling behavior
% Input
% datastruct
% paramsToFit: cell array of strings
% paramValue: if you want to get prior pdf of a certain parameter

input = struct;
input.datastruct = datastruct;
input.paramNames = paramsToFit;

input.outcome    = datastruct.outcome;
input.choice     = datastruct.choice;
input.reversal   = datastruct.reversal;

% Feedback Confirmation - 0 = disconfirmational feedback; 1 =
% confirmational feedback
input.feedConfir = ones(length(datastruct.event),1);
input.feedConfir(datastruct.event==2|datastruct.event==3) = 0;

input.usePrior = false;

input.pointEstFlag = false;
input.genDataFlag  = false;

% get new start point from prior distribution for each parameter
input.newStartPoint = [];
input.priorPdf = [];

input.learningMat = [];

% Use these values for all other LR parameters
general_randPriorVal = normrnd(0, 5);
general_priorPdf=pdf('norm', paramValue, 0, 5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARAMETERS:
% All parameters that can potentially influence decision behavior

for p = 1:length(paramsToFit)

    % Inverse temperature
    if strcmp(paramsToFit{p},'invT')
        input.startPoint(:,p) = 1;
        input.lb(:,p) = 0;
        input.ub(:,p) = 100;
        input.newStartPoint(p) = gamrnd(3, 1);
        input.priorPdf(p) = pdf('Gamma',paramValue,3,1);

    % Play bias
    elseif strcmp(paramsToFit{p},'playBias')
        input.startPoint(:,p) = 0;
        input.lb(:,p) = -100;
        input.ub(:,p) = 100;
        input.newStartPoint(p) = normrnd(0,.5);
        input.priorPdf(p) = pdf('norm',paramValue,0,.5);
   
    % eta
    elseif strcmp(paramsToFit{p},'eta')
        input.startPoint(:,p) = .5;
        input.lb(:,p) = 0;
        input.ub(:,p) = 1;
        input.newStartPoint(p) = betarnd(2,5);
        input.priorPdf(p) = pdf('Beta', paramValue,2,5);
   
        % LR intercept
    elseif strcmp(paramsToFit{p},'intcpt')
        input.learningMat(:,p) = ones(length(datastruct.event),1);
        input.startPoint(:,p) = 0;
        input.lb(:,p) = -100;
        input.ub(:,p) = 100;
        input.newStartPoint(p) = normrnd(0, 20);
        input.priorPdf(p) = pdf('norm', paramValue, 0, 20);

        % FeedConfrimation
    elseif strcmp(paramsToFit{p},'FeedConfrim')
        input.learningMat(:,p) = input.feedConfir;
        input.startPoint(:,p) = 0;
        input.lb(:,p) = -100;
        input.ub(:,p) = 100;
        input.newStartPoint(p) = normrnd(10, 20);
        input.priorPdf(p) = pdf('norm', paramValue, 10, 20);
         
        % FeedConfrimation
    elseif strcmp(paramsToFit{p},'FeedReality')
        input.learningMat(:,p) = input.choice;
        input.startPoint(:,p) = 0;
        input.lb(:,p) = -100;
        input.ub(:,p) = 100;
        input.newStartPoint(p) = general_randPriorVal;
        input.priorPdf(p) = general_priorPdf;
                
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% z score learning rate explanatory matrix
%keyboard
if strcmp(paramsToFit{3},'playBias')
    input.learningMat(:,1:3) = [];
elseif ~strcmp(paramsToFit{3},'playBias') 
    input.learningMat(:,1:2) = [];
end
input.learningMat=zScoreX(input.learningMat);
