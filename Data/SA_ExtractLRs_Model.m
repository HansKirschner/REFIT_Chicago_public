clear
load('Data/PLS_wGenPriors_Data_111110.mat')

%%
for a = 1:length(dstruct)

    ii      = 0;
    iiBG    = 0;
    iiGB    = 0;
    iiBN    = 0;
    iiGN    = 0;
    iiLC    = 0;
    iiHC    = 0;

    ProbError = nan(length(dstruct(a).Stimno),1);

    ProbError(dstruct(a).Prob > 50 & dstruct(a).outcome == 0) = 1;
    ProbError(dstruct(a).Prob < 50 & dstruct(a).outcome == 1) = 1;
    ProbError(dstruct(a).Prob > 50 & dstruct(a).outcome == 1) = 0;
    ProbError(dstruct(a).Prob < 50 & dstruct(a).outcome == 0) = 0;

    PrevProbError         = nan(length(dstruct(a).Stimno),1);
    PrevProbError(2:end)  = ProbError(1:end-1);

    % extract learning curves

    InfoStim1 = find(dstruct(a).Stimno == 1 & dstruct(a).SymStage == 1);
    InfoStim2 = find(dstruct(a).Stimno == 2 & dstruct(a).SymStage == 1);
    InfoStim3 = find(dstruct(a).Stimno == 3 & dstruct(a).SymStage == 1);

    Info1stReversls  = nan(9,1);

    if dstruct(a).Prob(InfoStim1(1)) ~= 50;Info1stReversls(1:3) = InfoStim1(1:3);end
    if dstruct(a).Prob(InfoStim2(1)) ~= 50;Info1stReversls(4:6) = InfoStim2(1:3);end
    if dstruct(a).Prob(InfoStim3(1)) ~= 50;Info1stReversls(7:9) = InfoStim3(1:3);end

    Info1stReversls(isnan(Info1stReversls))=[];

    for aqc = 1:2

        LRc_P(a).PcorrAcqisition(1,:) = dstruct(a).RL_LR(1:30);
        LRc_P(a).PcorrAcqisition(2,:) = dstruct(a).RL_LR(Info1stReversls(4):Info1stReversls(4)+29);


        LRc_P(a).PcorrfirstReversal(1,:) = dstruct(a).RL_LR(Info1stReversls(2):Info1stReversls(2)+29);
        LRc_P(a).PcorrfirstReversal(2,:) = dstruct(a).RL_LR(Info1stReversls(5):Info1stReversls(5)+29);

    end

    indexReversal = find(dstruct(a).ProbChange == 1);

    for i = 1:length(indexReversal)
        ii = ii +1;

        LRc_P(a).FractionChoice(ii,:) = dstruct(a).RL_LR(indexReversal(i):indexReversal(i)+29);
        if (dstruct(a).Prob(indexReversal(i)-1) > dstruct(a).Prob(indexReversal(i))) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)-1)) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)))
            iiGB = iiGB +1;
            LRc_P(a).FractionChoiceGoodtoBad(iiGB,:) = dstruct(a).RL_LR(indexReversal(i):indexReversal(i)+29);

        elseif (dstruct(a).Prob(indexReversal(i)-1) < dstruct(a).Prob(indexReversal(i)+1)) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)-1)) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)))
            iiBG = iiBG +1;
            LRc_P(a).FractionChoiceBadtoGood(iiBG,:) = dstruct(a).RL_LR(indexReversal(i):indexReversal(i)+29);

        elseif (dstruct(a).Prob(indexReversal(i)-1) > dstruct(a).Prob(indexReversal(i))) && isnan(dstruct(a).CorrectResp(indexReversal(i)-1)) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)))
            iiGN = iiGN +1;
            LRc_P(a).FractionChoiceGoodtoNeutral(iiGN,:) = dstruct(a).RL_LR(indexReversal(i):indexReversal(i)+29);

        elseif (dstruct(a).Prob(indexReversal(i)-1) < dstruct(a).Prob(indexReversal(i)+1)) && isnan(dstruct(a).CorrectResp(indexReversal(i)-1)) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)))
            iiBN = iiBN +1;
            LRc_P(a).FractionChoiceBadtoNeutral(iiBN,:) = dstruct(a).RL_LR(indexReversal(i):indexReversal(i)+29);

        end
    end

    for i = 1:length(indexReversal)
        ii = ii +1;

        if dstruct(a).Prob(indexReversal(i)+1) == 30 || dstruct(a).Prob(indexReversal(i)+1) == 70
            iiLC = iiLC +1;
            LRc_P(a).PCorrLC(iiLC,:) = dstruct(a).RL_LR(indexReversal(i):indexReversal(i)+29);

            LR_Peaks_PL(a).CP(iiLC) = dstruct(a).RL_LR(indexReversal(i)+1);
            LateLRs = dstruct(a).RL_LR(indexReversal(i)+10:indexReversal(i)+29);
            LR_Peaks_PL(a).PE(iiLC)  = mean(LateLRs(PrevProbError(indexReversal(i)+10:indexReversal(i)+29)==1));

        elseif dstruct(a).Prob(indexReversal(i)+1) == 20 || dstruct(a).Prob(indexReversal(i)+1) == 80
            iiHC = iiHC +1;
            LRc_P(a).PCorrHC(iiHC,:) = dstruct(a).RL_LR(indexReversal(i):indexReversal(i)+29);

        end
    end

end

%save("Data/LR_PLS.mat","LRc_P")
save("Data/LR_Peaks_PL.mat","LR_Peaks_PL")
%%
clear
load('Data/DrugS_wGenPrior_Data_111110.mat')

%%
for a = 1:length(dstruct)
    
    ii      = 0;
    iiBG    = 0;
    iiGB    = 0;
    iiBN    = 0;
    iiGN    = 0;
    iiLC    = 0;
    iiHC    = 0;

    ProbError = nan(length(dstruct(a).Stimno),1);

    ProbError(dstruct(a).Prob > 50 & dstruct(a).outcome == 0) = 1;
    ProbError(dstruct(a).Prob < 50 & dstruct(a).outcome == 1) = 1;
    ProbError(dstruct(a).Prob > 50 & dstruct(a).outcome == 1) = 0;
    ProbError(dstruct(a).Prob < 50 & dstruct(a).outcome == 0) = 0;

    PrevProbError         = nan(length(dstruct(a).Stimno),1);
    PrevProbError(2:end)  = ProbError(1:end-1);

    % extract learning curves

    InfoStim1 = find(dstruct(a).Stimno == 1 & dstruct(a).SymStage == 1);
    InfoStim2 = find(dstruct(a).Stimno == 2 & dstruct(a).SymStage == 1);
    InfoStim3 = find(dstruct(a).Stimno == 3 & dstruct(a).SymStage == 1);

    Info1stReversls  = nan(9,1);

    if dstruct(a).Prob(InfoStim1(1)) ~= 50;Info1stReversls(1:3) = InfoStim1(1:3);end
    if dstruct(a).Prob(InfoStim2(1)) ~= 50;Info1stReversls(4:6) = InfoStim2(1:3);end
    if dstruct(a).Prob(InfoStim3(1)) ~= 50;Info1stReversls(7:9) = InfoStim3(1:3);end

    Info1stReversls(isnan(Info1stReversls))=[];

    for aqc = 1:2

        LRc_D(a).PcorrAcqisition(1,:) = dstruct(a).RL_LR(1:30);
        LRc_D(a).PcorrAcqisition(2,:) = dstruct(a).RL_LR(Info1stReversls(4):Info1stReversls(4)+29);
        

        LRc_D(a).PcorrfirstReversal(1,:) = dstruct(a).RL_LR(Info1stReversls(2):Info1stReversls(2)+29);
        LRc_D(a).PcorrfirstReversal(2,:) = dstruct(a).RL_LR(Info1stReversls(5):Info1stReversls(5)+29);

    end

    indexReversal = find(dstruct(a).ProbChange == 1);

    for i = 1:length(indexReversal)
        ii = ii +1;

        LRc_D(a).FractionChoice(ii,:) = dstruct(a).RL_LR(indexReversal(i):indexReversal(i)+29);
        if (dstruct(a).Prob(indexReversal(i)-1) > dstruct(a).Prob(indexReversal(i))) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)-1)) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)))
            iiGB = iiGB +1;
            LRc_D(a).FractionChoiceGoodtoBad(iiGB,:) = dstruct(a).RL_LR(indexReversal(i):indexReversal(i)+29);

        elseif (dstruct(a).Prob(indexReversal(i)-1) < dstruct(a).Prob(indexReversal(i)+1)) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)-1)) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)))
            iiBG = iiBG +1;
            LRc_D(a).FractionChoiceBadtoGood(iiBG,:) = dstruct(a).RL_LR(indexReversal(i):indexReversal(i)+29);

        elseif (dstruct(a).Prob(indexReversal(i)-1) > dstruct(a).Prob(indexReversal(i))) && isnan(dstruct(a).CorrectResp(indexReversal(i)-1)) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)))
            iiGN = iiGN +1;
            LRc_D(a).FractionChoiceGoodtoNeutral(iiGN,:) = dstruct(a).RL_LR(indexReversal(i):indexReversal(i)+29);

        elseif (dstruct(a).Prob(indexReversal(i)-1) < dstruct(a).Prob(indexReversal(i)+1)) && isnan(dstruct(a).CorrectResp(indexReversal(i)-1)) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)))
            iiBN = iiBN +1;
            LRc_D(a).FractionChoiceBadtoNeutral(iiBN,:) = dstruct(a).RL_LR(indexReversal(i):indexReversal(i)+29);
        end
    end


     for i = 1:length(indexReversal)
        ii = ii +1;

        if dstruct(a).Prob(indexReversal(i)+1) == 30 || dstruct(a).Prob(indexReversal(i)+1) == 70
            iiLC = iiLC +1;
            LRc_D(a).PCorrLC(iiLC,:) = dstruct(a).RL_LR(indexReversal(i):indexReversal(i)+29);

            LR_Peaks_MA(a).CP(iiLC) = dstruct(a).RL_LR(indexReversal(i)+1);
            LateLRs = dstruct(a).RL_LR(indexReversal(i)+10:indexReversal(i)+29);
            LR_Peaks_MA(a).PE(iiLC)  = mean(LateLRs(PrevProbError(indexReversal(i)+10:indexReversal(i)+29)==1));


        elseif dstruct(a).Prob(indexReversal(i)+1) == 20 || dstruct(a).Prob(indexReversal(i)+1) == 80
            iiHC = iiHC +1;
            LRc_D(a).PCorrHC(iiHC,:) = dstruct(a).RL_LR(indexReversal(i):indexReversal(i)+29);

        end
    end

end

%save("Data/LR_DrugS.mat","LRc_D")
save("Data/LR_Peaks_MA.mat","LR_Peaks_MA")