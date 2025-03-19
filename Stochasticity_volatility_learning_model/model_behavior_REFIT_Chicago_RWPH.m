%% Script to fit a reinforcement leaning model to behavior REFIT Pat
% using a constrained search algorithm (fmincon)
clear;
rootDir = pwd;

path('helper/',path);
path('functions/',path);
path('functions_RL_modeling/',path);
set(0,'defaultAxesFontSize',20);

fminconDir = fullfile(rootDir,'simulations/fminconResults');
savepath = fullfile(rootDir,'simulations');

%% Run fmincon

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% How many iterations of fmincon should we run?
reps    = 15;
maxReps = 30;

% All parameters that can potentially influence decision behavior
allParams = {'invT','playBias','eta','intcpt','FeedConfrim','FeedReality'};

% Choose parameters to test
paramset1 = {'invT','playBias','eta','intcpt'};
paramset2 = {'invT','playBias','eta','intcpt','FeedConfrim',};
paramset3 = {'invT','playBias','eta','intcpt','FeedConfrim','FeedReality'};

allParamSets = {paramset2};

for tt = 1:length(allParamSets)
    
    paramsToUse = allParamSets{tt};
    % Load data
    load('all_behavior_PLSession.mat');
    load('simulations/simChoice_REFIT_Pat.mat')

    SimChoice = SimChocie_all{2};
    dstruct = D(1);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    paramsToFit = false(length(allParams),1)';
    paramsToFit(ismember(allParams,paramsToUse)) = true;
    paramCount = sum(paramsToFit);
    allParamsToFit = paramsToFit;
    allParamsToFit = logical(allParamsToFit);
    
    
    subCount = 1;
    for paramSet = 1:size(allParamsToFit,1)
        % Check if this parameter set has been tested
        thisParamsBin = allParamsToFit(paramSet,:);
        paramStr = '';
        for k = 1:length(thisParamsBin), paramStr = cat(2,paramStr,num2str(double(thisParamsBin(k)))); end
        saveFileDir = fullfile(fminconDir,sprintf('Leasion_wGenPriors_fminconResult_%s.mat',paramStr));
        saveFileDirData = fullfile(savepath,sprintf('Leasion_wGenPriors_Data_%s.mat',paramStr));

        saveTempFileDir     = fullfile(fminconDir,sprintf('Leasion_wGenPriors_fminconResult_%s_incomplete.mat',paramStr));
        saveTempFileDirData = fullfile(savepath,sprintf('Leasion_wGenPriors_Data_%s_incomplete.mat',paramStr));
        runThisSub = false;
        if exist(saveTempFileDir,'file')
            runThisSub = true;
            load(saveTempFileDir);
            %load(saveTempFileDirData);
            s_start = length(fminconResult.subno) + 1;
        elseif ~exist(saveFileDir,'file')
            runThisSub = true;
            s_start = 1;
            % Initialize variables to save parameters and BIC
            fminconResult = struct;
            fminconResult.subno = [];
            fminconResult.paramsStr = allParams(thisParamsBin);
            fminconResult.paramsBin = thisParamsBin;
            fminconResult.fitParams = [];
            fminconResult.BIC = [];
            fminconResult.negLogLike = [];
           
      
        end
        if runThisSub
            for s = s_start:size(SimChoice,2)
                fminconResult.subno = cat(1,fminconResult.subno,dstruct.subno*s);
                
                % Get the input structure for fmincon
                tic;
                fprintf('Param %d / %d: subno %d',tt,length(allParamSets),s);
                dstruct.choice = SimChoice(:,s)';
                input = getBehavModelInput_REFITChicagoRWPH(dstruct,allParams(thisParamsBin),nan);
                
                minNegLL=inf;
                params_fit = [];
                reps_thisSub = 0;   % So it doesn't exceed maxReps
                i = 1;
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
                    newInput = getBehavModelInput_REFITChicagoRWPH(dstruct,allParams(thisParamsBin),nan);
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
                
                subBIC = computeBIC(bestOutput.logLike_woPrior, paramCount, length(dstruct.TrNr));
                
                % store the fit values for each param
                fminconResult.fitParams = cat(1,fminconResult.fitParams,params_fit);
                % store the BIC
                fminconResult.BIC = cat(1,fminconResult.BIC,subBIC);
                fminconResult.negLogLike = cat(1,fminconResult.negLogLike,minNegLL);
               
                %dstruct(s).RL_LR = bestOutput.allLR;
                %dstruct(s).RPE   = bestOutput.RPE;
                %dstruct(s).ChoiceProb = bestOutput.ChoiceProb';

                % Save progress in temporary structure in case I need to
                % stop the code midway
                save(saveTempFileDir,'fminconResult');
                %save(saveTempFileDirData,'dstruct');
                
                subCount = subCount + 1;
                elapsedTime = toc;
                fprintf('\n total run time %.02fsec \n',elapsedTime);
            end
            save(saveFileDir,'fminconResult');
            %save(saveFileDirData,'dstruct');

            % delete temp data
            delete(saveTempFileDir);
            %delete(saveTempFileDirData);
        end
    end
end

%% 

clear
rootDir = pwd;

load('simulations/fminconResults/Control_wGenPriors_fminconResult_111110.mat')

InvTControl        = fminconResult.fitParams(:,1);
PlayBiasControl    = fminconResult.fitParams(:,2);
EtaControl         = fminconResult.fitParams(:,3);
LRIntcptControl    = fminconResult.fitParams(:,4);
LRFeedConfControl  = fminconResult.fitParams(:,5);

load('simulations/fminconResults/Leasion_wGenPriors_fminconResult_111110.mat')


InvTLeasion        = fminconResult.fitParams(:,1);
PlayBiasLeasion    = fminconResult.fitParams(:,2);
EtaLeasion         = fminconResult.fitParams(:,3);
LRIntcptLeasion    = fminconResult.fitParams(:,4);
LRFeedConfLeasion  = fminconResult.fitParams(:,5);


% exclude strange agents from both simulations 

excludeControl = find(EtaControl>.4 | PlayBiasControl > 10 | LRIntcptControl <-22.5 | LRFeedConfControl <-2.5);
excludeLeasion = find(EtaLeasion>.4 | PlayBiasLeasion > 10 | LRIntcptLeasion <-22.5 | LRFeedConfLeasion <-2.5);

excluda = unique([excludeControl;excludeLeasion]);


InvTLeasion(excludeLeasion)        = [];
PlayBiasLeasion(excludeLeasion)    = [];
EtaLeasion(excludeLeasion)         = [];
LRIntcptLeasion(excludeLeasion)    = [];
LRFeedConfLeasion(excludeLeasion)  = [];

InvTControl(excludeControl)        = [];
PlayBiasControl(excludeControl)    = [];
EtaControl(excludeControl)         = [];
LRIntcptControl(excludeControl)    = [];
LRFeedConfControl(excludeControl)  = [];

save("simulations/EtaInfo.mat","EtaControl","EtaLeasion")

ttestout(InvTLeasion,InvTControl,1);
ttestout(PlayBiasLeasion,PlayBiasControl,1);
ttestout(EtaLeasion,EtaControl,1);
ttestout(LRIntcptLeasion,LRIntcptControl,1);
ttestout(LRFeedConfLeasion,LRFeedConfControl,1);

figure(3),clf;
subplot(2,3,1)
[x,y1,~,IQR] = violinplotHK(InvTLeasion);
patch([y1 -y1(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.5)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(InvTLeasion),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(InvTLeasion),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(InvTControl);
patch([y1 -y1(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.5)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(InvTControl),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(InvTControl),'ko','markerfacecolor','g','markersize',10)
set(gca,'xlim',[-2.5 5.5],'xtick',[],'ylim',[0 6])
box off
title('InvT')
box off
title('InvT')

subplot(2,3,2)
[x,y1,~,IQR] = violinplotHK(PlayBiasLeasion);
patch([y1 -y1(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.5)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(PlayBiasLeasion),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(PlayBiasLeasion),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(PlayBiasControl);
patch([y1 -y1(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.5)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(PlayBiasControl),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(PlayBiasControl),'ko','markerfacecolor','g','markersize',10)

box off
title('Play bias')

subplot(2,3,3)
[x,y1,~,IQR] = violinplotHK(EtaLeasion);
patch([y1 -y1(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.5)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(EtaLeasion),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(EtaLeasion),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(EtaControl);
patch([y1 -y1(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.5)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(EtaControl),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(EtaControl),'ko','markerfacecolor','g','markersize',10)

box off
title('Eta')

subplot(2,3,4)
[x,y1,~,IQR] = violinplotHK(LRIntcptLeasion);
patch([y1 -y1(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.5)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(LRIntcptLeasion),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(LRIntcptLeasion),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(LRIntcptControl);
patch([y1 -y1(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.5)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(LRIntcptControl),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(LRIntcptControl),'ko','markerfacecolor','g','markersize',10)


box off
title('LRIntcpt')

subplot(2,3,5)
[x,y1,~,IQR] = violinplotHK(LRFeedConfLeasion);
patch([y1 -y1(end:-1:1)] , [x x(end:-1:1)], [0.4940 0.1840 0.5560],'facealpha',.5)
hold on
plot([0 0],IQR,'k','linew',3)
plot(0,nanmean(LRFeedConfLeasion),'ks','markerfacecolor','r','markersize',10)
plot(0,nanmedian(LRFeedConfLeasion),'ko','markerfacecolor','g','markersize',10)

[x,y1,~,IQR] = violinplotHK(LRFeedConfControl);
patch([y1 -y1(end:-1:1)]+3 , [x x(end:-1:1)], [0.6350 0.0780 0.1840],'facealpha',.5)
plot([3 3],IQR,'k','linew',3)
plot(3,nanmean(LRFeedConfControl),'ks','markerfacecolor','r','markersize',10)
plot(3,nanmedian(LRFeedConfControl),'ko','markerfacecolor','g','markersize',10)

box off
title('LRFeedConf')

h=gcf;
h.Position=[-2131         373         660         516];
print2pdf(fullfile(pwd,'Figures',['StochaVolM_ParamFit.pdf']),h,300)


