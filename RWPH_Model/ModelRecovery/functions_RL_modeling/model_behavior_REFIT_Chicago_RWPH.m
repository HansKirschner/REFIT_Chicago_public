function  ModelE = model_behavior_REFIT_Chicago_RWPH(dstruct)

%% Run fmincon
%keyboard
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% How many iterations of fmincon should we run?
reps    = 15;
maxReps = 30;

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
    paramsToFit = false(length(allParams),1)';
    paramsToFit(ismember(allParams,paramsToUse)) = true;
    paramCount = sum(paramsToFit);
    allParamsToFit = paramsToFit;
    allParamsToFit = logical(allParamsToFit);

    for paramSet = 1:size(allParamsToFit,1)
        % Check if this parameter set has been tested
        thisParamsBin = allParamsToFit(paramSet,:);
        paramStr = '';
        for k = 1:length(thisParamsBin), paramStr = cat(2,paramStr,num2str(double(thisParamsBin(k)))); end

        fprintf('   Param %d / %d... \n',tt,length(allParamSets));

        input = getBehavModelInput_REFITChicagoRWPH_noP(dstruct,allParams(thisParamsBin),nan);
        minNegLL=inf;
        params_fit = [];
        reps_thisSub = 0;   % So it doesn't exceed maxReps
        i = 1;
        
        while i <= reps
            
            reps_thisSub = reps_thisSub + 1;
           
          
            try
                [fminconOutput]= fitLearningFunc_REFITChicagoRWPH(input);
            catch
                fminconOutput.negLogLike    = minNegLL;
            end
            
            if fminconOutput.negLogLike<minNegLL
                bestOutput=fminconOutput;
                minNegLL=bestOutput.negLogLike;
                params_fit = bestOutput.params;
            end

            % set the new start point for new fmincon
            newInput = getBehavModelInput_REFITChicagoRWPH_noP(dstruct,allParams(thisParamsBin),nan);
            input.startPoint = newInput.newStartPoint;

            % Do more reps if fit values look sketchy
            if any(abs(params_fit(2:end)) > 4)
                if reps_thisSub < maxReps
                    i = 1;
                else
                    i = reps+1;
                end
            else
                i = i + 1;
            end
        end
      
        subBIC = computeBIC(bestOutput.logLike_woPrior, paramCount, length(dstruct.choice));

        ModelE.CompareBIC(tt) = subBIC;
        ModelE.LL(tt) = -bestOutput.logLike_woPrior;

        clear input subBIC bestOutput
    end
end

