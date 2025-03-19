function [mainEffect,groupDiff] = cpm_stats(var_this,i_group,varNum)
%Given two variables, report all the relevant stats for nature human
%behavior

% compare play vs pass for a variable
if varNum==2
    
    if length(i_group) ~= size(var_this,1), error('Data length not matched!'); end
    
    var1 = var_this(:,1);
    var2 = var_this(:,2);
    
    % Stats for main effect
    mainEffect = struct;
    [~,mainEffect.p,mainEffect.ci,stats_effect] = ttest(var1,var2);
    mainEffect.t = stats_effect.tstat;
    mainEffect.df = stats_effect.df;
    mainEffect.d = computeCohen_d(var1,var2,'paired');
    
    % Test for group difference
    groupDiff = struct;
    [~,groupDiff.p,groupDiff.ci,stats_gd] = ttest2(var1(i_group==1)-var2(i_group==1),var1(i_group==2)-var2(i_group==2));
    groupDiff.t = stats_gd.tstat;
    groupDiff.df = stats_gd.df;
    groupDiff.d = computeCohen_d(var1(i_group==1)-var2(i_group==1),var1(i_group==2)-var2(i_group==2),'independent');
    
    
% compare significance of slope
elseif varNum==1
    mainEffect = struct;
    [~,mainEffect.p,mainEffect.ci,stats_effect] = ttest(var_this);
    mainEffect.t = stats_effect.tstat;
    mainEffect.df = stats_effect.df;
    mainEffect.d = nanmean(var_this)/nanstd(var_this);
    mainEffect.mean = nanmean(var_this);
    
    % Test for group difference
    groupDiff = struct;
    [~,groupDiff.p,groupDiff.ci,stats_gd] = ttest2(var_this(i_group==1),var_this(i_group==2));
    groupDiff.t = stats_gd.tstat;
    groupDiff.df = stats_gd.df;
    groupDiff.d = computeCohen_d(var_this(i_group==1),var_this(i_group==2),'independent');
    
end

end

