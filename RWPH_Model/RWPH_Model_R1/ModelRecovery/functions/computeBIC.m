function BIC=computeBIC(logLikelihood, numParams, n)

%% computes Bayesian Information Criteria
% When fitting models, it is possible to increase the likelihood by adding parameters, 
% but doing so may result in overfitting. BIC resolves this problem by introducing a penalty term 
% for the number of parameters in the model

BIC=-2.*logLikelihood+numParams.*log(n);
