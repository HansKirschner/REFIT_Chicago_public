clear

files = dir(['results/' '*_Sym*.mat']);

models = {'Model_110100' 'Model_111100' 'Model_111110' 'Model_111111'};

for sim = 1:length(files)

    load(['results/' files(sim).name])


    for m = 1:4

        [minValue,index] = min(ModelE.([models{m} '_Data']).Compare_BIC);
        EP.(models{m})(sim,:) = zeros(1,4);
        EP.(models{m})(sim,index) = 1;

    end
end

%%
%%% PLOT %%%
ExProb(1,:) = mean(EP.Model_110100,1);
ExProb(2,:) = mean(EP.Model_111100,1);
ExProb(3,:) = mean(EP.Model_111110,1);
ExProb(4,:) = mean(EP.Model_111111,1);


figure(1);clf;
imagesc(ExProb)
%set(gca,'clim',[0 100])
set(gca,'xTick', [],'xticklabel',[]);
set(gca,'yTick', [],'yticklabel',[]);
colorbar

fig = gcf;
fig.PaperUnits = 'centimeters';
fig.PaperPosition = [0 0 12 12]; 
colormap('parula')
h = gcf;
print2pdf(fullfile(pwd,'Figures',['ModelRecovery.pdf']),h,300)


