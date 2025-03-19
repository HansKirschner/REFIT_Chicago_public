path('helper/',path);

% load data
vol_all         = cell(1,2);
stcs_all        = cell(1,2);
vals_all        = cell(1,2);
mx_all          = cell(1,2);
ex_all          = cell(1,2);
mx_lr_all       = cell(1,2);
ex_lr_all       = cell(1,2);

SimChocie_all   = cell(1,2);

state           = [];  

for s = 1:3

    load(['simulations/REFITChicago_S' num2str(s) '.mat'])

    state = [state;sim.config.p_task];
    
    for j = 1:2
        vol_all{j}          = [vol_all{j};sim.vols{j}];
        stcs_all{j}         = [stcs_all{j};sim.stcs{j}];
        vals_all{j}         = [vals_all{j};sim.vals{j}];
        mx_all{j}           = [mx_all{j};sim.mx(j,:)];
        ex_all{j}           = [ex_all{j};sim.ex(j,:)];
        mx_lr_all{j}        = [mx_lr_all{j};sim.mx_lr(j,:)];
        ex_lr_all{j}        = [ex_lr_all{j};sim.ex_lr(j,:)];

        SimChocie_all{j}    = [SimChocie_all{j};sim.simChoice{j}];

    end

end

save("simulations/simChoice_REFIT_Pat.mat","SimChocie_all")

N       = size(vals_all{1},1);
vol     = nan(N,2);
stc     = nan(N,2);
val     = nan(N,2);
e_vol   = nan(N,2);
e_stc   = nan(N,2);
e_val   = nan(N,2);

mx      = nan(2,4);
ex      = nan(2,4);

mx_lr   = nan(2,4);
ex_r    = nan(2,4);

for j = 1:2
    
    vol(:,j) = mean(vol_all{j},2);
    stc(:,j) = mean(stcs_all{j},2);
    val(:,j) = mean(vals_all{j},2);
    e_vol(:,j) = serr(vol_all{j},2);
    e_stc(:,j) = serr(stcs_all{j},2);
    e_val(:,j) = serr(vals_all{j},2);

    mx(j,:)    = nanmean(mx_all{j},1);
    ex(j,:)    = nanmean(ex_all{j},1);

    mx_lr(j,:)    = nanmean(mx_lr_all{j},1);
    ex_lr(j,:)    = nanmean(ex_lr_all{j},1);

end

highoutcomenoiseinfo = state == .3 | state == .7;

col = def('col_br');
nr = 2;
nc = 2;
xstr = {def('lr'), def('vol'), def('stc')};
set(0,'defaultAxesFontSize',20);


figure(1);clf;
subplots = 1:4;
Nline = nan;
ii = [2 1];
[h1] = plot_signal(nr,nc,subplots(1),{ vol(:,ii)},{zeros(N,2)},{'Volatility'},'',Nline,[],'',col(ii,:));
hold on;
%plot(hx, state,'color',.6*ones(1,3),'linewidth',2);
shade_the_back(highoutcomenoiseinfo, [0.5, 0.5, 0.5], 1:length(state))
set(h1, 'FontSize', 20);

[h2] = plot_signal(nr,nc,subplots(2),{ stc(:,ii)},{zeros(N,2)},{'Stochasticity'},'',Nline,[],'',col(ii,:));
hold on;
%plot(hx, state,'color',.6*ones(1,3),'linewidth',2);
shade_the_back(highoutcomenoiseinfo, [0.5, 0.5, 0.5], 1:length(state))
set(h2, 'FontSize', 20);


subplot(2,3,4)
% swap colums so that early learning phase is first
ex_lr(:, [1, 2]) = ex_lr(:, [2, 1]);
mx_lr(:, [1, 2]) = mx_lr(:, [2, 1]);

barwitherr(ex_lr(:,1:2)',mx_lr(:,1:2)');
ylabel('Learning rate')
ylim([.2,1])

subplot(2,3,5)
% swap colums so that early learning phase is first
ex(:, [1, 2]) = ex(:, [2, 1]);
mx(:, [1, 2]) = mx(:, [2, 1]);

barwitherr(ex(:,1:2)',mx(:,1:2)');
ylabel('Performance')
ylim([.5,1])

subplot(2,3,6)
load('simulations/EtaInfo.mat')
seEta = [se(EtaControl),se(EtaLeasion)];
Eta = [mean(EtaControl),mean(EtaLeasion)];

barwitherr(seEta,Eta);
ylabel('Eta')
ylim([.1,.25])

h=gcf;
h.Position=[-2256         171        1425         806];
print2pdf(fullfile(pwd,'Figures',['MSFig_StochaVolM.pdf']),h,300)




ttestout(EtaLeasion,EtaControl,1);




