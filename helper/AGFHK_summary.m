function [output] = AGFHK_summary(i)
%function that prints summary statistics for all numerical fields of an input of type struct or table.
%Returns a new structure that contains the same fieldnames and in order from 1 to n:
    % 1 = mean
    % 2 = SD
    % 3 = SEM
    % 4 = median
    % 5 = min
    % 6 = max
    % 7 = numel
    % 8 = number of nans (removed for calculation of all values)
    % 9 = number of non-nans
    % 10= p value from KS test for normality (after centering)
    % 11= p value for t-test vs zero
%If a fieldname is 'GLM', then function assumes that data is from a gitGLM model (run within different subjects) and plots a summary plot.
%%

scalefactor = 2.4; %just increases the distance of the axes to avoid overlap with the legend
clc
FN = fieldnames(i); 
k = 0;
Bonferroni=length(FN);
if ~isfield(i,'GLM')
    for c = 1 : length(FN)
        CV = [i.(FN{c})]; %current values
        M = nanmean(CV);
        M2 = nanmedian(CV);
        Mini = min(CV);
        Maxi = max(CV);
        SD = std(CV);
        Num_NaN = sum(isnan(CV));
        Not_Nan = numel(CV) - sum(isnan(CV));
        [~,p]=kstest(CV-nanmean(CV));
        [~,p2,~,stats]=ttest(nanrem(CV));
        if Not_Nan>2
            SEM = SD / sqrt(Not_Nan-1);
        end
        disp(['Fieldname: ' FN{c} ' - mean = ' num2str(M) ' ± ' num2str(SD) ' SD and ' num2str(SEM) ' SEM'])
        disp(['Range = ' num2str(Mini) ' - ' num2str(Maxi) ', median = ' num2str(M2)])
        disp(['Numel = ' num2str(numel(CV)) ' containing ' num2str(Num_NaN) ' NaNs and p vs 0 = ' num2str(p2) ' (bonf=' num2str(p2*Bonferroni) '), t = ' num2str(stats.tstat) ' with df = ' num2str(stats.df)])
        if p < 0.05
            disp(['KS test for normality is not passed (p = ' num2str(p) ').'])
        else
            disp(['KS test for normality is compatible with normality (p = ' num2str(p) ').'])
        end
        disp('***')
        disp(' ')
    end
else %Assuming that data is result of single GLM analyses
    for c = 1 : length(FN)
        if ~strcmp(FN{c},'GLM')
            k=k+1;
            L1(k) = {strrep(FN{c},'_',' ')};
            T(k) = mean(i.(FN{c}));
            SE(k) = std(i.(FN{c}))./sqrt(numel(i.(FN{c}))-1);
            [~,p(k), ci(k,:),stats] = ttest(i.(FN{c}));
            Range(k,1) = min(i.(FN{c}));
            Range(k,2) = max(i.(FN{c}));
            tval(k) = stats.tstat;
            DF(k)=stats.df;
            if p(k)>=1
                P{c} = [L1{k} ': p = 1 (after correction)'];
            elseif p(k) > 0.001
                P{k} = [L1{k} ': p = ' num2str(round(p(k)*10000)/10000)];
            elseif p(k)==0
                P{k} = [L1{k} ': p = 0 (within machine precision)'];
            else %find the right p value exponent
                sp = 1;pval=-3;
                while sp
                    if p(k) < 10^pval & p(k) >= 10^(pval-1)
                        sp=0;
                    else
                        pval=pval-1;
                    end;
                end;
                P{k} = [L1{k} ': p < 10^{' num2str(pval) '}'];
            end;
        end;
    end;
    
    close all;
    HC=1;
    figure; hFig = figure(1); set(gcf,'Visible', 'on'); 
    set(hFig, 'Position', [100 100 1300 900])%
    set(hFig,'PaperPositionMode','Auto')
    figureSize = get(gcf,'Position');
    NeededRows = ceil((length(L1)-1)/4)+2;
    hand(HC)=subplot(NeededRows,4,[1:8]); hold(gca, 'on');
    barwitherr(SE, T)
    a=gca;
    set(gca, 'XTick', 1:numel(L1), 'XTickLabel', L1);
    ylabel('Regression weights (a.u.)')
    AGF_rotateXLabels( gca(), 45 )
    hold(a, 'on')
    colors = hsv(numel(T));
    for c = 1:numel(T)
        bar(c, T(c), 'parent', a, 'facecolor', colors(c,:));
    end
    if abs(min(T)) > abs(max(T))
        legend({' ' ' ' P{:}}, 'Location', 'SouthEast', 'FontSize', 14)
        a.YLim(1) = a.YLim(1)*scalefactor;
    else
        legend({' ' ' '  P{:}}, 'Location', 'NorthEast', 'FontSize', 14)
        a.YLim(2) = a.YLim(2)*scalefactor;
    end;
    title(['Summary plot for: ' inputname(1)])
    
    disp(' ');disp(' ');
    for c = 1 : length(T)
        disp([L1{c} ' mean: ' num2str(T(c)) ', CI: ' num2str(ci(c,1)) ' - ' num2str(ci(c,2))])
        disp(['p-value: ' num2str(p(c)) ', t-value: ' num2str(tval(c)), ', df = ' num2str(DF(c))])
        disp(['Range = ' num2str(Range(c,1)) ' to ' num2str(Range(c,2))])
        disp('***')
        disp(' ')
    end;
    if isfield(i.GLM,'LL')
        disp(['Average Log Likelihood for complete model: ' num2str(mean([i.GLM.LL]))])
    end;    
end;
return