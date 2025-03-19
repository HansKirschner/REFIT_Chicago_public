function A01_ModelRecov_RWPH_func(s)

rootDir = pwd;
addpath(genpath(rootDir));

fminconDir = fullfile(rootDir,'data/fminconResults');
dataDir    = fullfile(rootDir,'data');

% All parameters that can potentially influence decision behavior
allParams = {'invT','playBias','eta','intcpt','FeedConfrim','FeedReality'};

% Choose parameters to test
paramset0 = {'invT','playBias','intcpt'};
paramset1 = {'invT','playBias','eta','intcpt'};
paramset2 = {'invT','playBias','eta','intcpt','FeedConfrim',};
paramset3 = {'invT','playBias','eta','intcpt','FeedConfrim','FeedReality'};

allParamSets = {paramset0,paramset1,paramset2,paramset3};

for tt = 1:length(allParamSets)

    paramsToUse = allParamSets{tt};

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    paramsToFit    = false(length(allParams),1)';
    paramsToFit(ismember(allParams,paramsToUse)) = true;
    allParamsToFit = paramsToFit;
    allParamsToFit = logical(allParamsToFit);

    thisParamsBin = allParamsToFit;
    paramStr = '';
    for k = 1:length(thisParamsBin), paramStr = cat(2,paramStr,num2str(double(thisParamsBin(k)))); end

    load([dataDir '/Data_' paramStr '.mat']);
    load([fminconDir '/fminconResult_' paramStr '.mat']);


    fprintf('Param %d / %d: symno %d \n',tt,length(allParamSets),s);

    ModelComparision_CompareBIC = nan(3,4);
    ModelComparision_LL         = nan(3,4);

    if tt == 2
        fminconResult.fitParams(s,3) = unifrnd(.2,.5);
    end

    if tt == 4
        fminconResult.fitParams(s,6) = unifrnd(10,30);
    end


    for i = 1:3

        %% 1. generate synthetic data
        inputSym   = getBehavModelInput_REFITChicagoRWPH_sim(dstruct(s),allParams(thisParamsBin),nan);
        SymData    = learningFunc_REFITChicagoRWPH_sim(fminconResult.fitParams(s,:), inputSym);

        %% 2. fit the models to the simulated data
        ModelComparision_i = model_behavior_REFIT_Chicago_RWPH(SymData);

        ModelComparision_CompareBIC(i,:)    = ModelComparision_i.CompareBIC;
        ModelComparision_LL(i,:)            = ModelComparision_i.LL;

    end

    ModelE.(['Model_' paramStr '_Data']).Compare_BIC  = mean(ModelComparision_CompareBIC);
    ModelE.(['Model_' paramStr '_Data']).Compare_LL   = mean(ModelComparision_LL);

end

save(['results/ModelRecoveryV2_Sym' num2str(s) '.mat'],"ModelE")
