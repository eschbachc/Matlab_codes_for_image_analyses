function [Mean_tp,Peak_tp,Ampli_tp,DF_tp,Scores] = pool_over_regions(o,phase,...
                	indiv_id,y,fr_before_stim,fr_during_stim,...
                    Mean_tp,Peak_tp,Ampli_tp,DF_tp,Scores,stim_num,...
                    norm_frame_dur,frame_dur)
% 23/09/2021: added amplitude of response
                
% normalise the data over a new time series: norm_frame_dur                
y_fit = interp1(...
    frame_dur:frame_dur:frame_dur*length(y),y,...
    norm_frame_dur:norm_frame_dur:frame_dur*length(y)) ;         

% Store the fluo at the same location for the same stim event 
% (i.e. but different regions)  
if ~isempty(DF_tp{1,1,indiv_id,1})
    % Interpolate data if sizes of vectors are 1 datapoint different
     y_fit = Interp_Fit_to_Data0(y_fit,DF_tp{1,1,indiv_id,1}(1,:));
    % overwites the previous y_fit
end

DF_tp{o,phase,indiv_id,stim_num}(end+1,:) = y_fit;
           
% MEAN:                
Mean_tp{o,phase,indiv_id,stim_num}(end+1) = ...
    nanmean(y(fr_during_stim));

% average over the different regions:
Scores.mean_indiv_events{o,phase,indiv_id}(end+1) = ...
    nanmean(Mean_tp{o,phase,indiv_id,stim_num},2);
% average over the different stim events:
Scores.mean_per_indiv{o,phase}(indiv_id,:) = ...
    nanmean(Scores.mean_indiv_events{o,phase,indiv_id},2);
% variance over the different stim events:
Scores.std_mean_per_indiv{o,phase}(indiv_id,:) = nanstd...
    (Scores.mean_indiv_events{o,phase,indiv_id});


% PEAK:
Peak_tp{o,phase,indiv_id,stim_num}(end+1) = ...
    nanmax(y(fr_during_stim))-nanmax(y(fr_before_stim));

% average peak over the different regions:
Scores.peak_indiv_events{o,phase,indiv_id}(end+1) = nanmean(...
    Peak_tp{o,phase,indiv_id,stim_num},2);
% average peak over the different stim events:
Scores.peak_per_indiv{o,phase}(indiv_id,:) = nanmean(...
    Scores.peak_indiv_events{o,phase,indiv_id},2);
% variance over the different stim events:
Scores.std_peak_per_indiv{o,phase}(indiv_id,:) = nanstd(...
    Scores.peak_indiv_events{o,phase,indiv_id});


% AMPLITUDE:
Ampli_tp{o,phase,indiv_id,stim_num}(end+1) = ...
    abs(nanmax(smooth(y(fr_during_stim)))-nanmin(smooth(y(fr_during_stim))))-...
    abs(nanmax(smooth(y(fr_before_stim)))-nanmin(smooth(y(fr_before_stim))));

% amplitude over the different regions:
Scores.ampli_indiv_events{o,phase,indiv_id}(end+1) = nanmean(...
    Ampli_tp{o,phase,indiv_id,stim_num},2);
% average ampli over the different stim events:
Scores.ampli_per_indiv{o,phase}(indiv_id,:) = nanmean(...
    Scores.ampli_indiv_events{o,phase,indiv_id},2);
% variance over the different stim events:
Scores.std_ampli_per_indiv{o,phase}(indiv_id,:) = nanstd(...
    Scores.ampli_indiv_events{o,phase,indiv_id});


end