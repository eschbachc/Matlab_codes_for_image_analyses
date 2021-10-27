function [y,x]= ...
    about_this_stim(mySTIM_onset,fr_before_stim,frame_window,myDifMean_G,...
    frame_dur)
% finds the frames for F and F0, computes dF/F0 (y) w/ corresponding time
% series (x)

% time indexes for the whole stim
idx_t = frame_window + mySTIM_onset;

% time indexes for before the stim (-> to compute baseline fluo)
idx_0 = fr_before_stim + mySTIM_onset;

% baseline fluoresence (before stim):
y0 = nanmean(myDifMean_G(idx_0));

% normalize fluo to baseline fluo:
y = (myDifMean_G(idx_t)-y0)./y0;

%time serie:
x = 0:frame_dur:frame_dur*(size(y,2)-1);

end