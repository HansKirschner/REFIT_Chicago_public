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

        LRc_P(a).PcorrAcqisition(1,:) = dstruct(a).CorrectResp(1:30);
        LRc_P(a).PcorrAcqisition(2,:) = dstruct(a).CorrectResp(Info1stReversls(4):Info1stReversls(4)+29);


        LRc_P(a).PcorrfirstReversal(1,:) = dstruct(a).CorrectResp(Info1stReversls(2):Info1stReversls(2)+29);
        LRc_P(a).PcorrfirstReversal(2,:) = dstruct(a).CorrectResp(Info1stReversls(5):Info1stReversls(5)+29);

    end

    indexReversal = find(dstruct(a).ProbChange == 1);

    for i = 1:length(indexReversal)
        ii = ii +1;

        LRc_P(a).FractionChoice(ii,:) = dstruct(a).CorrectResp(indexReversal(i):indexReversal(i)+29);
        if (dstruct(a).Prob(indexReversal(i)-1) > dstruct(a).Prob(indexReversal(i))) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)-1)) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)))
            iiGB = iiGB +1;
            LRc_P(a).FractionChoiceGoodtoBad(iiGB,:) = dstruct(a).choice(indexReversal(i):indexReversal(i)+29);

        elseif (dstruct(a).Prob(indexReversal(i)-1) < dstruct(a).Prob(indexReversal(i)+1)) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)-1)) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)))
            iiBG = iiBG +1;
            LRc_P(a).FractionChoiceBadtoGood(iiBG,:) = dstruct(a).choice(indexReversal(i):indexReversal(i)+29);

        elseif (dstruct(a).Prob(indexReversal(i)-1) > dstruct(a).Prob(indexReversal(i))) && isnan(dstruct(a).CorrectResp(indexReversal(i)-1)) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)))
            iiGN = iiGN +1;
            LRc_P(a).FractionChoiceGoodtoNeutral(iiGN,:) = dstruct(a).choice(indexReversal(i):indexReversal(i)+29);

        elseif (dstruct(a).Prob(indexReversal(i)-1) < dstruct(a).Prob(indexReversal(i)+1)) && isnan(dstruct(a).CorrectResp(indexReversal(i)-1)) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)))
            iiBN = iiBN +1;
            LRc_P(a).FractionChoiceBadtoNeutral(iiBN,:) = dstruct(a).choice(indexReversal(i):indexReversal(i)+29);

        end
    end

    for i = 1:length(indexReversal)
        ii = ii +1;

        if dstruct(a).Prob(indexReversal(i)+1) == 30 || dstruct(a).Prob(indexReversal(i)+1) == 70
            iiLC = iiLC +1;
            LRc_P(a).PCorrLC(iiLC,:) = dstruct(a).CorrectResp(indexReversal(i):indexReversal(i)+29);

        elseif dstruct(a).Prob(indexReversal(i)+1) == 20 || dstruct(a).Prob(indexReversal(i)+1) == 80
            iiHC = iiHC +1;
            LRc_P(a).PCorrHC(iiHC,:) = dstruct(a).CorrectResp(indexReversal(i):indexReversal(i)+29);

        end
    end

end
       
save("Data/LR_Choice_PLSV2.mat","LRc_P")


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

        LRc_D(a).PcorrAcqisition(1,:) = dstruct(a).CorrectResp(1:30);
        LRc_D(a).PcorrAcqisition(2,:) = dstruct(a).CorrectResp(Info1stReversls(4):Info1stReversls(4)+29);
        

        LRc_D(a).PcorrfirstReversal(1,:) = dstruct(a).CorrectResp(Info1stReversls(2):Info1stReversls(2)+29);
        LRc_D(a).PcorrfirstReversal(2,:) = dstruct(a).CorrectResp(Info1stReversls(5):Info1stReversls(5)+29);

    end

    indexReversal = find(dstruct(a).ProbChange == 1);

    for i = 1:length(indexReversal)
        ii = ii +1;

        LRc_D(a).FractionChoice(ii,:) = dstruct(a).CorrectResp(indexReversal(i):indexReversal(i)+29);
        if (dstruct(a).Prob(indexReversal(i)-1) > dstruct(a).Prob(indexReversal(i))) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)-1)) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)))
            iiGB = iiGB +1;
            LRc_D(a).FractionChoiceGoodtoBad(iiGB,:) = dstruct(a).choice(indexReversal(i):indexReversal(i)+29);

        elseif (dstruct(a).Prob(indexReversal(i)-1) < dstruct(a).Prob(indexReversal(i)+1)) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)-1)) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)))
            iiBG = iiBG +1;
            LRc_D(a).FractionChoiceBadtoGood(iiBG,:) = dstruct(a).choice(indexReversal(i):indexReversal(i)+29);

        elseif (dstruct(a).Prob(indexReversal(i)-1) > dstruct(a).Prob(indexReversal(i))) && isnan(dstruct(a).CorrectResp(indexReversal(i)-1)) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)))
            iiGN = iiGN +1;
            LRc_D(a).FractionChoiceGoodtoNeutral(iiGN,:) = dstruct(a).choice(indexReversal(i):indexReversal(i)+29);

        elseif (dstruct(a).Prob(indexReversal(i)-1) < dstruct(a).Prob(indexReversal(i)+1)) && isnan(dstruct(a).CorrectResp(indexReversal(i)-1)) && ~isnan(dstruct(a).CorrectResp(indexReversal(i)))
            iiBN = iiBN +1;
            LRc_D(a).FractionChoiceBadtoNeutral(iiBN,:) = dstruct(a).choice(indexReversal(i):indexReversal(i)+29);
        end
    end


     for i = 1:length(indexReversal)
        ii = ii +1;

        if dstruct(a).Prob(indexReversal(i)+1) == 30 || dstruct(a).Prob(indexReversal(i)+1) == 70
            iiLC = iiLC +1;
            LRc_D(a).PCorrLC(iiLC,:) = dstruct(a).CorrectResp(indexReversal(i):indexReversal(i)+29);

        elseif dstruct(a).Prob(indexReversal(i)+1) == 20 || dstruct(a).Prob(indexReversal(i)+1) == 80
            iiHC = iiHC +1;
            LRc_D(a).PCorrHC(iiHC,:) = dstruct(a).CorrectResp(indexReversal(i):indexReversal(i)+29);

        end
    end

end

save("Data/LR_Choice_DrugSV2.mat","LRc_D")


