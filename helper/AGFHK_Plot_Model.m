function [  ] = AGFHK_Plot_Model( data, term, labels, PMset )
%%
%Function that returns data from a GLM model binned by observations and
%their interactions.
%
%INPUT:
%'data'         table for GLM (observation is last column). Else: Can be a summary structure of individual within subjects regressions.
%'term'         model specification in Wilkinson notation. NOTE: Currently
%                 only supports up two 3-way interactions!
%'labels'       labels for entries (if dichotomous) in order lower to
%                 higher value as cell array of cells {{'congruent' 'incongruent'} {'short' 'long'}}
%'PMset'        A structure with the following (possible) fields:
%   .Confidence     confidence interval (e.g., 0.95), 0 = sem, 1 = SD
%   .CIalpha
%   .Normalise
%   .filetype
%   .PlotSingle
%   .ModPval        This simply multiplies p values (e.g., set to number of regressors for Bonferroni correction)
%   .Fdisp
%   .UseT           Use 't' (= t statistic) or 'b' (= regression weight) from regression
%   .Colormap       String for the colormap to use ('hsv', 'winter' etc). Default: 'parula'
%   .plotpath       If set, output will be saved to this path.
%   .savename       If set, output will be saved under this name (otherwise uses title)
%   .AddAnalysis    Plots some additional analysis, like correlations between paraemters across population, test for effects of model fit
%These following values only work, if a summary structure is provided (otherwise run a second level regression on the data itself)
%   .Group1         This is a numeric vector (e.g., [1:10]) of subjects to include in the analysis (all others are discarded)
%   .Group2         If this is another numeric vector, both groups are compared
%   .GroupNames     Cell of names for groups {'a' 'b'}, otherwise default is {'Group1'  'Group2'}
% keyboard
%%

Confidence      = 0;            % CI for shades, 0 = sem, 1 = SD
CIalpha         = 0.05;
Normalise       = 0;            % Do not normalise design matrix
filetype        = 'pdf';
PlotSingle      = 0;
ModPval         = 1;
Fdisp           = 1;
UseT            = 't'; %Use t stats for summar as default.
AddStr          = '';
Group1          = [];
Group2          = [];
GroupNames      = {};
UseColormap     = 'parula';
Plottype        = 'bars';
AddAnalysis     = 0;

if isfield(PMset, 'Confidence');  Confidence     = PMset.Confidence;     end
if isfield(PMset, 'CIalpha');     CIalpha        = PMset.CIalpha;        end
if isfield(PMset, 'Normalise');   Normalise      = PMset.Normalise;      end
if isfield(PMset, 'filetype');    filetype       = PMset.filetype;       end
if isfield(PMset, 'PlotSingle');  PlotSingle     = PMset.PlotSingle;     end
if isfield(PMset, 'ModPval');     ModPval        = PMset.ModPval;        end
if isfield(PMset, 'Fdisp');       Fdisp          = PMset.Fdisp;          end
if isfield(PMset, 'UseT');        UseT           = PMset.UseT;           end
if isfield(PMset, 'Group1');      Group1         = PMset.Group1;         end
if isfield(PMset, 'Group2');      Group2         = PMset.Group2;         end
if isfield(PMset, 'GroupNames');  GroupNames     = PMset.GroupNames;     end
if isfield(PMset, 'Colormap');    UseColormap    = PMset.Colormap;       end
if isfield(PMset, 'AddAnalysis'); AddAnalysis    = PMset.AddAnalysis;    end

%%
if isstruct(data)
    %Note: If input is a summary structure, the fieldnames have to be 'Summary' and 'Regression'
    Dt = data.Summary;
    FN=fieldnames(Dt);
    model = data.Regression; nVP=length(model.VPn);
    term = model.modelspec;
    if strcmp(UseT,'b')
        FNr = fieldnames(model.b); %note:fieldnames for b, p, and t need to have the same order
    else
        FNr = fieldnames(model.t);
    end
    
    %Display some information and create dummy names if groups are supplied
    if Fdisp
        if isempty(Group1)
            disp(['Input is summary of first level regressions with ' num2str(length(FNr)) ' regressors and ' num2str(nVP) ' subjects.']);
            G1 = 1 : nVP;
        elseif ~isempty(Group1) && isempty(Group2)
            G1 = Group1; nVP = length(G1);
            if isempty(GroupNames)
                GroupNames{1} = 'Group1';
            end
            disp(['Input is summary of first level regressions with ' num2str(length(FNr)) ' regressors. Using ' num2str(nVP) ' subjects of group ' GroupNames{1} '.']);
        elseif ~isempty(Group1) && ~isempty(Group2)
            G1 = Group1;
            if isempty(GroupNames)
                GroupNames = {'Group1' 'Group2'};
            end
            disp(['Input is summary of first level regressions with ' num2str(length(FNr)) ' regressors.'])
            disp(['Comparing ' num2str(length(Group1)) ' subjects of group ' GroupNames{1} ' to ' num2str(length(Group2)) ' subjects of group ' GroupNames{2} '.']);
            if sum(ismember(Group1, Group2))>0
                disp('***** Warning: Groups have overlapping entries. Is that intended? *****')
                pause(3)
            end
        end
        disp(['Using ' UseT ' values from previous regressions.'])
    end
    if isfield(model,'BIC'); AddStr = [AddStr ' av. BIC: ' num2str(mean([model.BIC(G1)]))]; end
    if isfield(model,'R2');  AddStr = [AddStr ' av. R2: ' num2str(mean([model.R2(G1)]))]; end
    if ~isempty(Group2)
        if isfield(model,'BIC'); AddStr = [AddStr ' for group ' GroupNames{1} ' and av. BIC: ' num2str(mean([model.BIC(Group2)]))]; end
        if isfield(model,'R2');  AddStr = [AddStr ' av. R2: ' num2str(mean([model.R2(Group2)]))  ' for group ' GroupNames{2}]; end
    end
    
    %%
    for c = 1 : length(FN)
        %Average over Summary data
        FN2 = fieldnames(Dt.(FN{c}));
        for c2 = 1 : length(FN2)
            if isempty(Group2)
                Unsort = [Dt.(FN{c}).(FN2{c2})];
                D.(FN{c}).(FN2{c2}) = [nanmean(Unsort(G1*4-3)) nanmedian(Unsort(G1*4-3)) nanstd(Unsort(G1*4-3)) nVP];
            else
                Unsort = [Dt.(FN{c}).(FN2{c2})];
                D.(FN{c}).([FN2{c2} '_' GroupNames{1}]) = [nanmean(Unsort(G1*4-3)) nanmedian(Unsort(G1*4-3)) nanstd(Unsort(G1*4-3)) length(G1)];
                D.(FN{c}).([FN2{c2} '_' GroupNames{2}]) = [nanmean(Unsort(Group2*4-3)) nanmedian(Unsort(Group2*4-3)) nanstd(Unsort(Group2*4-3)) length(Group2)];
            end
        end
        
        %Get model information
        Temp = [model.(UseT).(FNr{c})];
        if isempty(Group2)
            if ~isempty(structfind(model.(UseT),FNr{c},[])) %thre are empty values in this regressor of first level inputs
                disp(['Warning: Factor ' FNr{c} ' has less values than group size...'])
                T(c,1) = nanmean(Temp);
                [~,p(c),cit,stats] = ttest(Temp, [], 'Alpha', CIalpha);                
            else
                T(c,1) = nanmean(Temp(G1));
                [~,p(c),cit,stats] = ttest(Temp(G1), [], 'Alpha', CIalpha);
            end
        else
            T(c,1) = nanmean(Temp(G1)) - nanmean(Temp(Group2)); %always subtract group2 from group1
            [~,p(c),cit,stats] = ttest2(Temp(G1),Temp(Group2), 'Alpha', CIalpha);
        end
        CiS(c,:) = cit;
        Ci(c,:) = cit-T(c,1);
        L1{c} = FN{c};
        L1{c} = strrep(L1{c},'_',' ');
        if length(Temp) < length([model.(UseT).(FNr{1})])
            Temp = [Temp nan(1,abs(length(Temp)-length([model.(UseT).(FNr{1})])))];
        end
        Overall(:,c) = Temp;
    end
    if ModPval~= 1
       disp(['Performing p-value correction with factor: ' num2str(ModPval)]) 
       p = p.*ModPval;
       p(p>1)=1;
    end
    
else %Run a separate second level model
    nVP = size(data,1);
    D = AGF_Eval_Model(data, term, labels);
    
    if Normalise
        data = normaliseT(data);
    end
    if isfield(PMset, 'catvars')
        model = fitglm(data,term,'CategoricalVars',PMset.catvars);
    else
        model = fitglm(data,term);
    end
    FN=fieldnames(D);
    
    if isfield(PMset, 'PlotB')
        T = model.Coefficients.Estimate(2:end);
        CiS = coefCI(model, CIalpha);
        CiS = CiS(2:end,:);
        Ci(:,1)=CiS(:,1)-T;
        Ci(:,2)=CiS(:,2)-T;
    else
        T = model.Coefficients.tStat(2:end);
        CiS = coefCI(model, CIalpha);
        Ci(:,1)=CiS(2:end,2)./model.Coefficients.SE(2:end)-T;
    end

    p=model.Coefficients.pValue(2:end).*ModPval;
    for c = 2 : length(model.CoefficientNames)
        L1{c-1} = model.CoefficientNames{c};
        L1{c-1} = strrep(L1{c-1},'_',' ');
    end
end
%%
if Confidence>0 && Confidence<1
    CString = [num2str(Confidence*100) '% CI'];
    ConfFactor = norminv(1+(0.5-(1-Confidence/2)),0,1);  % if confidence is set to calculate CI, scale factor for SE calculation
elseif Confidence==0
    ConfFactor = 1;
    CString = 'SE';
elseif Confidence==1
    ConfFactor = sqrt(nVP-1);
    CString = 'SD';
end

P{1}=' '; P{2}=' ';
for c = 1 : length(p)
    if p(c)>=1
        P{c+2} = [L1{c} ': p = 1 (after correction)'];
    elseif p(c) > 0.001
        P{c+2} = [L1{c} ': p = ' num2str(round(p(c)*10000)/10000)];
    elseif p(c)==0
        P{c+2} = [L1{c} ': p = 0 (within machine precision)'];
    else %find the right p value exponent
        sp = 1;pval=-3;
        while sp
            if p(c) < 10^pval & p(c) >= 10^(pval-1)
                sp=0;
            else
                pval=pval-1;
            end
        end
        P{c+2} = [L1{c} ': p < 10^{' num2str(pval) '}'];
    end
end
NeededRows = ceil(c/4)+2;

%%
%close all; figure; 
clf
HC=1; RemR = 0;
hFig = figure(1); set(gcf,'Visible', 'on'); 
set(hFig, 'Position', [100 100 1800 1400])%
set(hFig,'PaperPositionMode','Auto')
figureSize = get(gcf,'Position');
hand(HC)=subplot(NeededRows,4,[1:8]); hold(gca, 'on');
if strcmp(Plottype,'box') %boxplot
    boxplot(Overall,'BoxStyle','filled')
    a=gca; hold(a, 'on')
    hLegend = legend(findall(gca,'Tag','Box'), P(3:end));
else
    if length(T) == 1
        RemR = 1;
        T(2) = 0; Ci(2,:) = [0 0];
    end
    barwitherr(Ci, T)
    a=gca;
    hold(a, 'on')
    colors = eval([UseColormap '(numel(T))']);
    for i = 1:numel(T)
        bar(i, T(i), 'parent', a, 'facecolor', colors(i,:));
    end
    if abs(min(T)) > abs(max(T))
        legend(P, 'Location', 'SouthEast', 'FontSize', 14)
    else
        legend(P, 'Location', 'NorthEast', 'FontSize', 14)
    end
end
if RemR; T(2) = []; Ci(2,:) = []; end %remove extra entries to get bawitherr to work
set(gca, 'XTick', 1:numel(L1), 'XTickLabel', AGF_prune_string(L1,15), 'XLim', [0.2 length(T)+5]);
ylabel('Regression weights (a.u.)')
AGF_rotateXLabels( gca(), 45 )

if ~isempty(GroupNames) && isempty(Group2)
    title([GroupNames{1} ' - Dependent variable: ' strrep(term(1:regexp(term,'~')-1), '_', ' ') AddStr], 'FontSize', 18)
else
    title(['Dependent variable: ' strrep(term(1:regexp(term,'~')-1), '_', ' ') AddStr], 'FontSize', 18)
end
AllTitles(1).Title = [strrep(term(1:regexp(term,'~')-1), '_', ' ') ' _Overview'];HC=HC+1;

if Fdisp
    disp(' ');disp(' ');
    for c = 1 : length(T)
        disp([L1{c} ' value: ' num2str(T(c)) ' and p-value: ' num2str(p(c)) ' CI: ' num2str(CiS(c,1)) ' - ' num2str(CiS(c,2))])
    end
end

%%

Pn = 8;
Tightness = 0.15; %this precentage is added to the y limits
for c = 1 : length(p)
    clear V Conf
    Pn = Pn + 1;
    %%
    hand(HC)=subplot(NeededRows,4,[Pn]); hold(gca, 'on');
    FN2 = fieldnames(D.(FN{c}));
    for i = 1 : length(FN2)
        V(i) = D.(FN{c}).(FN2{i})(1);
        if isempty(Group2) || ~isstruct(data)
            Conf(i) = ConfFactor * D.(FN{c}).(FN2{i})(3) / sqrt(nVP-1);
        else
            if ~mod(i,2) %group 1
                Conf(i) = ConfFactor * D.(FN{c}).(FN2{i})(3) / sqrt(length(G1)-1);
            else
                Conf(i) = ConfFactor * D.(FN{c}).(FN2{i})(3) / sqrt(length(Group2)-1);
            end
        end
    end

   
    barwitherr(Conf, V)
    axis tight
    
    %adjust plot limits
    [Max_Val, Max_Pos] = max(V+Conf);
    [Min_Val, Min_Pos] = min(V-Conf);
    if Min_Val / hand(HC).YLim(1) >= 1
        hand(HC).YLim(1) = hand(HC).YLim(1) + hand(HC).YLim(1)*Tightness;
    end
    if Max_Val / hand(HC).YLim(2) >= 1
        hand(HC).YLim(2) = hand(HC).YLim(2) + hand(HC).YLim(2)*Tightness;
    end

    %Cut off parts of plot for better visibility
    if min(hand(HC).YLim)>=0 %all entries are larger than 0
        hand(HC).YLim=[min(V)-max(Conf)*(1+Tightness) hand(HC).YLim(2)*(1+Tightness)];
    elseif max(hand(HC).YLim)<=0 %all entries are smaller than 0
        hand(HC).YLim=[hand(HC).YLim(1)*(1+Tightness) max(V)+max(Conf)*(1+Tightness)];
    else
        hand(HC).YLim=[sign(hand(HC).YLim).*abs(hand(HC).YLim).*(1+Tightness)];
    end
    hand(HC).YLim=[min(V-Conf) max(V+Conf)];
    

    %%
    a=gca;
    set(gca, 'XTick', 1:numel(FN2), 'XTickLabel', strrep(FN2,'_',' '));
    ylabel(strrep(term(1:regexp(term,'~')-1),'_',' '))
    AGF_rotateXLabels( gca(), 45 )
    hold(a, 'on')
    colors = eval([UseColormap '(numel(V))']);
    for i = 1:numel(V)
        bar(i, V(i), 'parent', a, 'facecolor', colors(i,:));
    end
    title(strrep(FN{c},'_',' '), 'FontSize', 18)
    AllTitles(HC).Title = [strrep(term(1:regexp(term,'~')-1), '_', ' ')  ' ' strrep(FN{c},'_',' ')];
    HC=HC+1;
    
    if Fdisp
        disp(' ');
        for c2 = 1 : length(V)
            disp([FN2{c2} ': ' num2str(V(c2)) ' CI: ' num2str(Conf(c2))])
        end
    end
end

if isfield(PMset, 'plotpath')
    %adjust the size for printing
    set(hFig,'Units','Points');
    pos = get(hFig,'Position');
    set(hFig,'PaperPositionMode','Auto','PaperUnits','points','PaperSize',[pos(3), pos(4)])
    if ~isfield(PMset, 'savename')
        saveas (hFig,[PMset.plotpath  'Model for ' strrep(term(1:regexp(term,'~')-1), '_', ' ') ],filetype);
    else
        saveas (hFig,[PMset.plotpath PMset.savename],filetype);
    end
end
%%
%Save individual images (may be better for publications etc.
if PlotSingle
    %Test if 'Singles' subfolder exists, otherwise create
    if ~exist([PMset.plotpath  '/singles/'])
        mkdir([PMset.plotpath  '/singles/']);
    end
    
    for c = 1 : HC-1
        pfig = figure;
        hax_new = copyobj(hand(c), pfig);
        set(hax_new, 'Position', get(0, 'DefaultAxesPosition'));
        if ~isfield(PMset, 'savename')
            saveas (pfig,[PMset.plotpath  '/singles/' AllTitles(c).Title], filetype);
        else
            saveas (pfig,[PMset.plotpath  '/singles/' PMset.savename ' ' AllTitles(c).Title], filetype);
        end
        close(pfig);
    end
end
 %keyboard
%%
if isfield(PMset, 'AddAnalysis') && length(T) > 1
    if PMset.AddAnalysis
        z = length(FNr); s = 2;
        if z==2
            z=3;
        end
        for c = 1: length(FNr)
            m(:,c) = [model.(UseT).(FNr{c})]';
        end
        EC = figure;
        ecornerplot(m,'names',L1)
        if isfield(PMset, 'plotpath')
            %adjust the size for printing
            set(EC,'Units','Points');
            pos = get(EC,'Position');
            set(EC,'PaperPositionMode','Auto','PaperUnits','points','PaperSize',[pos(3), pos(4)])
            if ~isfield(PMset, 'savename')
                saveas (EC,[PMset.plotpath  'Model for ' strrep(term(1:regexp(term,'~')-1), '_', ' ') ' cornerplot'],filetype);
            else
                saveas (EC,[PMset.plotpath PMset.savename ' cornerplot'],filetype);
            end
        end
        
        
        %%
        hADD = figure;
        set(hADD, 'Position', [100 100 1800 1400])%
        set(hADD,'PaperPositionMode','Auto')
        subplot(s,z,1)
        histogram(model.R2)
        gridxy(median(model.R2))
        gridxy(mean(model.R2),'Color','r')
        title('Historgam of R2 values')
        
        for c = 1 : 2
            subplot(s,z,1+c)
            if c == 1
                AC_plot = squeeze(max(squeeze(model.correlation)));
                mini    = squeeze(min(squeeze(model.correlation)));
                AC_plot(triu(AC_plot,1)~=0) = mini(triu(mini,1)~=0);
                t = 'max / min correlation';
            else
                t = 'mean correlation';
                AC_plot = squeeze(mean(squeeze(model.correlation)));
            end

            imagesc(AC_plot, [-1 1]); 
            axis tight; set(gca, 'XTick', [1 : length(L1)],  'YTick', [1 : length(L1)], 'XTickLabel', AGF_prune_string(L1, 13), 'YTickLabel', AGF_prune_string( L1, 13))
            title(t);
            AGF_rotateXLabels(gca,30);
            for col = 1 : size(AC_plot,1)
                for row = 1 : 1 : size(AC_plot,2)
                    if col~=row
                        text(col,row,num2str(AGF_round2decimals(AC_plot(row,col),2)),'HorizontalAlignment','center','FontSize',9)
                    end
                end
            end
        end
        
        

        for c =  1 : length(FNr)
            subplot(s,z,z+c)
            scatter(m(:,c),model.R2)
            title(['R2 vs ' L1{c}])
            ylabel('R2');xlabel('parameter estimate');
            refline
        end
        
         if isfield(PMset, 'plotpath')
            %adjust the size for printing
            set(hADD,'Units','Points');
            pos = get(hADD,'Position');
            set(hADD,'PaperPositionMode','Auto','PaperUnits','points','PaperSize',[pos(3), pos(4)])
            if ~isfield(PMset, 'savename')
                saveas (hADD,[PMset.plotpath  'Model for ' strrep(term(1:regexp(term,'~')-1), '_', ' ') ' Add Analysis R2'],filetype);
            else
                saveas (hADD,[PMset.plotpath PMset.savename ' Add Analysis R2'],filetype);
            end
        end
        
    end
end

