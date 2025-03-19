function [ MO ] = AGFHK_Model_Details( MO, CM, M, DataByGLM, vp, ModN )
% keyboard
%%

if max(abs(CM.Coefficients.tStat))<1500 % && max(abs(RtFit.Coefficients.Estimate)) < 10
    N = fieldnames(DataByGLM);
    for c = 1 : length(N)
        N2 = fieldnames(DataByGLM.(N{c}));
        for c2 = 1 : length(N2)
            MO.(ModN).Overall.(N{c})(vp).(N2{c2}) = DataByGLM.(N{c}).(N2{c2});
        end
    end
    Rem_p = CM.Coefficients;
    MO.(ModN).VPn(vp) = vp;
    MO.(ModN).R2(vp) = CM.Rsquared.Ordinary;
    MO.(ModN).BIC(vp) = CM.ModelCriterion.BIC;
    MO.(ModN).correlation(vp,:,:) = corrcoef(M.DesignM{1:end,1:end-1},'rows','complete');
    for c = 1 : size(Rem_p,1)-1
         MO.(ModN).p(vp).(strrep([CM.CoefficientNames{c+1}], ':', '_'))   = Rem_p{c+1,4};
         MO.(ModN).t(vp).(strrep([CM.CoefficientNames{c+1}], ':', '_'))   = Rem_p{c+1,3};
         MO.(ModN).b(vp).(strrep([CM.CoefficientNames{c+1}], ':', '_'))   = Rem_p{c+1,1};
    end
else
    display('Unlikely model fit found. Excluding subject..')
    pause
end

