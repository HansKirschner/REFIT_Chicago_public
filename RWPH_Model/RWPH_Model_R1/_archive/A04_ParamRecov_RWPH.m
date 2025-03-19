%% Script to fit a hybrid RWPH model to REFIT Chicago behavior
% using a constrained search algorithm (fmincon)
clear;
rootDir = pwd;
addpath(genpath(rootDir));
set(0,'defaultAxesFontSize',20);
fminconDir = fullfile(rootDir,'data/fminconResults');
savepath = fullfile(rootDir,'data');

% All parameters that can potentially influence decision behavior
allParams = {'invT','playBias','eta','intcpt','FeedConfrim','FeedReality'};

load('data/all_behavior_Orientation_idealObs.mat');
load('data/Data_wPrior_111110.mat')
load('data/fminconResults/fminconResult_wPrior_111110.mat')

D = dstruct;

% Choose parameters to test
paramset2 = {'invT','playBias','eta','intcpt','FeedConfrim'};

allParamSets = {paramset2};
NrSymulations = length(D)*10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% How many iterations of fmincon should we run?
reps    = 15;
maxReps = 30;

for tt = 1:length(allParamSets)

    paramsToUse = allParamSets{tt};

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    paramsToFit    = false(length(allParams),1)';
    paramsToFit(ismember(allParams,paramsToUse)) = true;
    paramCount     = sum(paramsToFit);
    allParamsToFit = paramsToFit;
    allParamsToFit = logical(allParamsToFit);


    % Check if this parameter set has been tested
    thisParamsBin = allParamsToFit;
    paramStr = '';
    for k = 1:length(thisParamsBin), paramStr = cat(2,paramStr,num2str(double(thisParamsBin(k)))); end

    SymRound = 0;

    saveFileDir = fullfile(savepath,sprintf('ParamRecovery_02_%s.mat',paramStr));
    saveTempFileDir = fullfile(savepath,sprintf('ParamRecovery_02_%s_incomplete.mat',paramStr));

    if exist(saveTempFileDir,'file')
        runThisSub = true;
        load(saveTempFileDir);
        s_start = length(ParamRecov.symno) + 1;
        SymRound = floor(s_start/length(D));
    elseif ~exist(saveFileDir,'file')
        runThisSub = true;
        s_start = 1;
        SymRound = 0;
        % Initialize variables to save parameters and BIC
        ParamRecov = struct;
        ParamRecov.symno            = [];
        ParamRecov.paramsStr        = allParams(thisParamsBin);
        ParamRecov.paramsBin        = thisParamsBin;
        ParamRecov.RecoverdParams   = [];
        ParamRecov.BIC              = [];
        ParamRecov.negLogLike       = [];
        ParamRecov.GroundTruthParam = [];

    end
    if runThisSub
        for s = s_start:NrSymulations

            ParamRecov.symno = cat(1,ParamRecov.symno,s);
            % Get the input structure for fmincon
            fprintf('Param %d / %d: symno %d \n',tt,length(allParamSets),s);

            % get correct index to extract GT params form sample
            index = s - ((length(D)*SymRound));

            if index == length(D), SymRound = SymRound+1; end

            % generate synthetic data
            inputSym   = getBehavModelInput_REFITChicagoRWPH_sim(D(index),allParams(thisParamsBin),nan);
            SymData    = learningFunc_REFITChicagoRWPH_sim(fminconResult.fitParams(index,:), inputSym);

            % store GT Params
            ParamRecov.GroundTruthParam = cat(1,ParamRecov.GroundTruthParam,fminconResult.fitParams(index,:));

            % fit model on synthetic data
            minNegLL=inf;
            params_fit = [];
            reps_thisSub = 0;   % So it doesn't exceed maxReps
            i = 1;
            input = getBehavModelInput_REFITChicagoRWPH(SymData,allParams(thisParamsBin),nan);
            
            tStart = tic;
            while i <= reps
                reps_thisSub = reps_thisSub + 1;

                try
                    [fminconOutput]= fitLearningFunc_REFITChicagoRWPH(input);
                catch
                    fprintf('\n round %d of 15 timeout error...\n',i);
                end

                if fminconOutput.negLogLike<minNegLL
                    bestOutput=fminconOutput;
                    minNegLL=bestOutput.negLogLike;
                    params_fit = bestOutput.params;
                end

                % set the new start point for new fmincon
                newInput = getBehavModelInput_REFITChicagoRWPH(SymData,allParams(thisParamsBin),nan);
                input.startPoint = newInput.newStartPoint;

                % Do more reps if fit values look sketchy
                if any(abs(params_fit(1:end)) > 4)
                    if reps_thisSub < maxReps
                        i = 1;
                    else
                        i = reps+1;
                    end
                else
                    i = i + 1;
                    %fprintf('we are at round %d of 15\n',i);

                end

            end

            subBIC = computeBIC(bestOutput.logLike_woPrior, paramCount, length(SymData.choice));

            % store the fit values for each param
            ParamRecov.RecoverdParams  = cat(1,ParamRecov.RecoverdParams,params_fit);
            % store the BIC
            ParamRecov.BIC        = cat(1,ParamRecov.BIC,subBIC);
            ParamRecov.negLogLike = cat(1,ParamRecov.negLogLike,minNegLL);

            % Save progress in temporary structure in case I need to
            % stop the code midway
            save(saveTempFileDir,'ParamRecov');

            tEnd = toc(tStart);
            fprintf('(%.02fsec)\n\n', tEnd);


        end
        save(saveFileDir,'ParamRecov');

        % delete temp data
        delete(saveTempFileDir);
    end


end

ert 

%% lets plot the resutls
clear
load('data/ParamRecovery_02_111110')

%correlations
for c = 1 : size(ParamRecov.GroundTruthParam,2)
    [r,p] = corr([ParamRecov.GroundTruthParam(:,c) ParamRecov.RecoverdParams(:,c)]); %correlation between ground truth parameters and estimated parameters
    disp([ParamRecov.paramsStr{c} ': correlation r = ' num2str(round(r(2)*100)/100) '; p = ' num2str(p(2))])
end

ert 

CorrelationMatrix = nan(size(ParamRecov.GroundTruthParam,2));

for z = 1:size(ParamRecov.GroundTruthParam,2)

    for c = 1:size(ParamRecov.GroundTruthParam,2)
        
        r = corr([ParamRecov.GroundTruthParam(:,z) ParamRecov.RecoverdParams(:,c)]);

        CorrelationMatrix(z,c) = r(2);

    end
end


h = figure(1);clf;
imagesc(CorrelationMatrix);colorbar
set(gca,'xTick', [1:5],'xticklabel',ParamRecov.paramsStr,'FontWeight','bold');
set(gca,'yTick', [1:5],'yticklabel',ParamRecov.paramsStr,'FontWeight','bold');
colorbar
%colormap(flipud(gray))
colormap('parula')
fig = gcf;
ax = gca;
ax.CLim = [-1 1];
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 12 24];
set(gca, 'FontSize', 20)

print2pdf(fullfile(pwd,'FIgures',['ParameterRecov_RWPH_Model3.pdf']),h,300)




