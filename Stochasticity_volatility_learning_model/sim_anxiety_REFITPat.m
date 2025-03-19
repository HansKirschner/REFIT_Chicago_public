function sim_anxiety_REFITPat(s0_lesioned,nsimu)

% The code for the stochasticity and volatility leanring model is adopted from 
% Piray & Daw 2021 (https://www.nature.com/articles/s41467-021-26731-9).

path('helper/',path);

% loop over stimuli
for s = 1 :3 

    [p_task,out_cometask,tvolatile,tstable]=data_REFITChigaco(s);
   
    parameters = struct('nparticles',100,'x0_unc',1,'lambda_v',.2,'lambda_s',.2,'v0',.1,'s0',.1,'s0_lesioned',s0_lesioned);
    config = struct('tvolatile',tvolatile,'tstable',tstable,'N',length(p_task),'state',p_task,'p_task',p_task,'out_cometask',out_cometask,'rng_id',0,'nsim',nsimu,'model_parameters',parameters);                 
                
    rng(config.rng_id);
    N = config.N;
    nsim = config.nsim;    
    
    vol = nan(N,nsim);
    stc = nan(N,nsim);
    lr = nan(N,nsim);
    val = nan(N,nsim);
    
    vols = cell(1,2);
    stcs = cell(1,2);
    lrs = cell(1,2);
    vals = cell(1,2);        
    lnames = {'Healthy', sprintf('%s lesion',def('stc'))};            
    groups = {'Control','Anxious'};   
    
    for j=1:2
        for i=1:nsim
            o = timeseriesREFIT(config);
            [vol(:,i),stc(:,i),lr(:,i),val(:,i)] = model_pf(o,config.model_parameters,lnames{j});
        end                
        vols{j} = vol;
        stcs{j} = stc;
        lrs{j} = lr;
        vals{j} = val;
    end

    sim = struct('config',config,'specs',{groups},...
                 'vols',{vols},'stcs',{stcs},'lrs',{lrs},'vals',{vals});
    
    nsim    = sim.config.nsim;
    ncond   = length(sim.lrs);

    mx  = nan(ncond,4);
    ex  = nan(ncond,4);
    mx_lr  = nan(ncond,4);
    ex_lr  = nan(ncond,4);

    x   = nan(nsim,ncond*2);
    xlr = nan(nsim,ncond*2);

    SimChocie = cell(1,2);
    simchoice = nan(length(sim.config.p_task),i);

    for j=1:ncond
        for i=1:nsim
            val = sim.vals{j}(:,i);
            lr  = sim.lrs{j}(:,i);
            [x(i,:),xlr(i,:),~,~,simchoice(:,i)] = performance_REFITChicago(sim.config.p_task,val,lr);
        end

        mx(j,:) = median(x);
        ex(j,:) = se_median(x);

        mx_lr(j,:) = median(xlr);
        ex_lr(j,:) = se_median(xlr);

        SimChocie{j} = simchoice;

    end

    sim = struct('config',config,'specs',{groups},...
                 'vols',{vols},'stcs',{stcs},'lrs',{lrs},'vals',{vals},...
                 'mx',mx,'ex',ex,'mx_lr',mx_lr,'ex_lr',ex_lr,'simChoice',{SimChocie});

    save(['simulations/REFITChicago_S' num2str(s) '.mat'],'sim');    
end

%keyboard

% vol_all         = cell(1,2);
% stcs_all        = cell(1,2);
% vals_all        = cell(1,2);
% mx_all          = cell(1,2);
% ex_all          = cell(1,2);
% mx_lr_all       = cell(1,2);
% ex_lr_all       = cell(1,2);
% 
% SimChocie_all   = cell(1,2);
% 
% state           = [];  
% 
% for s = 1:3
% 
%     load(['simulations/REFITChicago_S' num2str(s) '.mat'])
% 
%     state = [state;sim.config.p_task];
%     
%     for j = 1:2
%         vol_all{j}          = [vol_all{j};sim.vols{j}];
%         stcs_all{j}         = [stcs_all{j};sim.stcs{j}];
%         vals_all{j}         = [vals_all{j};sim.vals{j}];
%         mx_all{j}           = [mx_all{j};sim.mx(j,:)];
%         ex_all{j}           = [ex_all{j};sim.ex(j,:)];
%         mx_lr_all{j}        = [mx_lr_all{j};sim.mx_lr(j,:)];
%         ex_lr_all{j}        = [ex_lr_all{j};sim.ex_lr(j,:)];
% 
%         SimChocie_all{j}    = [SimChocie_all{j};sim.simChoice{j}];
% 
%     end
% 
% end
% 
% save("simulations/simChoice_REFIT_Pat.mat","SimChocie_all")
% 
% N       = size(vals_all{1},1);
% vol     = nan(N,2);
% stc     = nan(N,2);
% val     = nan(N,2);
% e_vol   = nan(N,2);
% e_stc   = nan(N,2);
% e_val   = nan(N,2);
% 
% mx      = nan(2,4);
% ex      = nan(2,4);
% 
% mx_lr   = nan(2,4);
% ex_r    = nan(2,4);
% 
% for j = 1:2
%     
%     vol(:,j) = mean(vol_all{j},2);
%     stc(:,j) = mean(stcs_all{j},2);
%     val(:,j) = mean(vals_all{j},2);
%     e_vol(:,j) = serr(vol_all{j},2);
%     e_stc(:,j) = serr(stcs_all{j},2);
%     e_val(:,j) = serr(vals_all{j},2);
% 
%     mx(j,:)    = nanmean(mx_all{j},1);
%     ex(j,:)    = nanmean(ex_all{j},1);
% 
%     mx_lr(j,:)    = nanmean(mx_lr_all{j},1);
%     ex_lr(j,:)    = nanmean(ex_lr_all{j},1);
% 
% end
% 
% 
% col = def('col_br');
% nr = 3;
% nc = 2;
% xstr = {def('lr'), def('vol'), def('stc')};
% set(0,'defaultAxesFontSize',20);
% 
% subplots = 1:6;
% figure(1);clf;
% Nline = nan;
% ii = [2 1];
% [hx] = plot_signal(nr,nc,subplots(1),{ val(:,ii)},{zeros(N,2)},{'Estimated reward'},'',Nline,[],'',col(ii,:));
% hold on;
% plot(hx, state,'color',.6*ones(1,3),'linewidth',2);
% h(1) = hx;
% 
% subplot(3,2,2)
% barwitherr(ex_lr',mx_lr');
% ylabel('learning rate')
% 
% 
% [hx, hp] = plot_signal(nr,nc,subplots(3:4),{ vol(:,ii), stc(:,ii)},{e_vol(:,ii), e_stc(:,ii)},xstr(2:3),'',nan,[],'',col);
% 
% subplot(3,2,5)
% barwitherr(ex',mx');
% ylabel('Performance')


end

 
