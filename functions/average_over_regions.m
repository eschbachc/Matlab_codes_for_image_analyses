function [DF_Score_tp,DF_Score] = average_over_regions(...
                	o,phase,indiv_id,vs,y,fr_during_stim,...
                    DF_Score_tp,DF_Score,fr_before_stim)


% average fluo:
DF_Score_tp{o,phase,indiv_id,vs}(end+1) = ...
    nanmean(y(fr_during_stim));


% average over the different regions:
DF_Score{o,phase,vs}(indiv_id,:) = ...
    nanmean(DF_Score_tp{o,phase,indiv_id,vs},2);

% peak fluo:
DF_Score_tp{o+3,phase,indiv_id,vs}(end+1) = ...
    nanmax(y(fr_during_stim))-...
    nanmax(y(fr_before_stim));

% average over the different regions:
DF_Score{o+3,phase,vs}(indiv_id,:) = ...
    nanmean(DF_Score_tp{o+3,phase,indiv_id,vs},2);

end