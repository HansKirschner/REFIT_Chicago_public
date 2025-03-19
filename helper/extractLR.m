function   LearningCurve_all   = extractLR(dstruct)

LR = struct;

for a = 1:length(dstruct)

    ii      = 0;
  
    indexReversal = find(dstruct(a).ProbChange == 1);

    for i = 1:length(indexReversal)
        ii = ii +1;

        LR(a).FractionChoice(ii,:) = dstruct(a).LR(indexReversal(i):indexReversal(i)+29);
    end

end


LearningCurve_all       = nan(100,30);


for iii = 1:100

       LearningCurve_all(iii,:)   = nanmean([LR(iii).FractionChoice],1);

end