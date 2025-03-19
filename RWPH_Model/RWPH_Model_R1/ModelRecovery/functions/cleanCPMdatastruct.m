function datastruct = cleanCPMdatastruct(datastruct)
% Removes bad trials (e.g. RT that's too short) and subjects (didn't do better than chance)

% keyboard

removeFastTrials = 0;
removeBadSubs = 1;

rtThreshold = 200;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove RT's that are too short
shortRTcount = [];
if removeFastTrials == 1
    for s = 1:length(datastruct)
        trialsToRemove_i = datastruct(s).rt <= rtThreshold;
        shortRTcount = cat(1,shortRTcount,sum(trialsToRemove_i));
        for ff = fieldnames(datastruct(s))'
            if size(datastruct(s).(char(ff)),1) == 160 && ~strcmp(char(ff),'trialNum')
                datastruct(s).(char(ff))(trialsToRemove_i,:) = nan;
            end
        end
    end
    % Remove entire subjects who have too many short RT trials
    datastruct(shortRTcount > 3*std(shortRTcount)) = [];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove entire subjects who did poorly on CP task
if removeBadSubs == 1
    datastruct([datastruct.goodCpSub_i]==0) = [];
end

end

