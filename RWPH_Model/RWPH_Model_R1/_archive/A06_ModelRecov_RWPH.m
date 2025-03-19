clear;
rootDir = pwd;
addpath(genpath(rootDir));

fminconDir = fullfile(rootDir,'data/fminconResults');
dataDir    = fullfile(rootDir,'data');
savepath = fullfile(rootDir,'results');

% All parameters that can potentially influence decision behavior
allParams = {'invT','playBias','eta','intcpt','FeedConfrim','FeedReality'};

% Choose parameters to test
paramset0 = {'invT','playBias','intcpt'};
paramset1 = {'invT','playBias','eta','intcpt'};
paramset2 = {'invT','playBias','eta','intcpt','FeedConfrim',};
paramset3 = {'invT','playBias','eta','intcpt','FeedConfrim','FeedReality'};

allParamSets = {paramset0,paramset1,paramset2,paramset3};

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

    thisParamsBin = allParamsToFit;
    paramStr = '';
    for k = 1:length(thisParamsBin), paramStr = cat(2,paramStr,num2str(double(thisParamsBin(k)))); end

    load([dataDir '/Data_' paramStr '.mat']);
    load([fminconDir '/fminconResult_' paramStr '.mat']);

    for s = 1:length(dstruct)

        fprintf('Param %d / %d: symno %d \n',tt,length(allParamSets),s);

        %% 1. generate synthetic data
        inputSym   = getBehavModelInput_REFITChicagoRWPH_sim(dstruct(s),allParams(thisParamsBin),nan);
        SymData    = learningFunc_REFITChicagoRWPH_sim(fminconResult.fitParams(s,:), inputSym);


        %% 2. fit the models to the simulated data
        ModelComparision = model_behavior_REFIT_Chicago_RWPH(SymData);
        ModelE.(['Model_' paramStr '_Data'])(s).Compare_BIC  = ModelComparision.CompareBIC;

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




