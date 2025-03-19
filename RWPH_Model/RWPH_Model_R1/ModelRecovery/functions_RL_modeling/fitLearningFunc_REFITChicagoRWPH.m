function [output]= fitLearningFunc_REFITChicagoRWPH(input)
%keyboard
% fit a flexible delta rule learning algorithm to subject behavior in the
% REFIT task. This task has probabilities that need to be learned over time
% Subjects need to stipulate whether they want to pass or play according to
% probabilities of the stimuli.

% input         = structure with following fields:
% rew           = was chosen target rewarded
% choice        = 1 = play, 0 = pass;
% learningMat   = this can be anything. for each column of data in this
% matrix the model will fit an extra parameter...

% whichParams   = logical array saying which parameters you want to fit.
% startPoint    = fixed value for non-fit parameters, starting value forothers
% priorWidth    = vector of standard deviations of 0 mean prior on betas
% input.usePrior = logical specifying whether we want to use a hard-coded prior.
% input.pointEstFlag= flag that tells the code not to fit model with
                % fmincon but instead to compute the likelihood for the parameters in
                % startPoint.
% genDataFlag     = flag that determines whether you are generating data
% from the model (true) or fitting data (false). 


% output: maximum likelihood parameter estimates


% parameters:

% 1) inverse temperature
% 2) play bias
% 3) N parameters governing the effects of columns of matrix learningMat on
%    learning rate. First one should be intercept.

% clearvars -except selDat
% input = selDat;


tfStart = tic;
% Call fmincon to evaluate squared error in fitting a curve with a parameters initially set to starting point.
model = @flexLearningFunc;  % this is the function handle to the function that takes the parameters and outputs the thing we want to minimize
oldOpts = optimset('fmincon');
options=optimset(oldOpts, 'maxFunEvals', 10000000, 'MaxIter', 10000000,'Display', 'off');
[estimates, sse, ef, o, l, g, h] = fmincon(model, input.startPoint, [], [], [], [], input.lb, input.ub, [], options);
output=struct;
output.params=estimates;
[output.negLogLike, output.allLR, output.expP,output.ChoiceProb, new_input, output.logLike_woPrior, output.RPE]=learningFunc_REFITChicagoRWPH_freezeParams(estimates, input);


% frugFun accepts some inputs (params) and an array that tells it which
% inputs they are (wp)
    function [negLogLike, allLR, expP,ChoiceProb] = flexLearningFunc(params)  %input comes from fmincon (initially start_point)
        [negLogLike, allLR, expP,ChoiceProb] = learningFunc_REFITChicagoRWPH_freezeParams(params, input);
        
        tfEnd = toc(tfStart);
        % disp(['Elapsed time is ',num2str(currentTime)]);
        %sometimes graident decent gets stuck - if fmincon takes unusally
        %long, we stop...
        if tfEnd>180
            error('Timeout...');
        end
    end

end

