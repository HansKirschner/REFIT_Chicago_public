function [randPriorVal,priorPdf] = getLearningFuncVarInfo(varStr,paramVal)
%Get the prior distribution for the learning function
% 

if strcmp(varStr,'invT')
    randPriorVal = gamrnd(2, 1);
    priorPdf = pdf('Gamma',paramVal, 2, 1);
elseif strcmp(varStr,'valExp')
    randPriorVal = gamrnd(2, 1);
    priorPdf = pdf('Gamma',paramVal, 2, 1);
elseif strcmp(varStr,'playBias')
    randPriorVal = normrnd(0, 10);
    priorPdf = pdf('norm',paramVal, 0, 10);
elseif strcmp(varStr,'LR_intcpt')
    randPriorVal = normrnd(0, 10);
    priorPdf = pdf('norm', paramVal, 0, 10);
else
    randPriorVal = normrnd(0, 5);
    priorPdf=pdf('norm', tParams(5:end), 0, 5);
end

end

