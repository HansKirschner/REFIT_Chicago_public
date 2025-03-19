function output=getOptimalLRs(input)

% this function was written by MRN to get optimal inferences over the
% probability of a binary variable (input.data) that evolves according to a change-point
% process with a prior over changepoints (input.H)

% input = structure with fields:
% data  = binary outcomes
% H     = hazard rate

% output= structure with fields:

% output = structure with fields:
% expP   = mean of probability distribution over underlying probability (p)
% LR     = LR corresponding to model probability assessment updates
% dataLL = model log likelihood of seeing change-point from expected dist


% steps:
% 1) compute p(mu_{t+1}|mu_{t},H);
% 2) multiply prior distribution by likelihood of producing new outcome.
% 3) done. Wow. easy as pie.


% specify grid over possible probabilities:


ps=(0:.01:1)';
cpPrior=ones(size(ps))./length(ps);

p=cpPrior;


mu=nan(size(input.data));  % expected reward probability
dataLL=nan(size(input.data));  % Log likelihood
begTrialEntropy=nan(size(input.data));  % Trial uncertainty

for i = 1:length(input.data)
        
    gSel=p>0;
    begTrialEntropy(i)=sum(p(gSel).*(-log(p(gSel))));
    
    if input.data(i)
        condProb=p.*ps;
    else
        condProb=p.*(1-ps);
    end
    dataLL(i)=log(sum(condProb));

    
    mu(i)=sum(ps.*p);

    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% lets create a few different measures of surprise:
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    % 1) change-point probability:
    pByS=[p, cpPrior];
    pS=[ones(size(p)).*(1-input.H), ones(size(p)).*(input.H)];
    p=p.*(1-input.H)+cpPrior.*(input.H);
    
    p=p./nansum(p); % normalize; 
        
    % account for likelihood of data:
    if input.data(i)
        p=p.*ps;
    else
        p=p.*(1-ps);
    end
 
    p=p./nansum(p);
    
end


newBlock=false(length(mu), 1);
newBlock(1)=true;
[output.LR]=computeLR(input.data, mu, newBlock);
output.expP=mu;
output.dataLL=dataLL;
output.begTrialEntropy=begTrialEntropy;


