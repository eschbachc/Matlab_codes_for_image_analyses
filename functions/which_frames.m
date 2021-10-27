function [fr_during_stim,fr_before_stim,fr_after_stim,frame_window] =...
    which_frames(gap,time_before_stim,frame_dur,STIM_dur,STIM_onset)

% Find the frames for each stimulation

my_stim_onset = round(STIM_onset/frame_dur);
my_stim_dur = round(STIM_dur/frame_dur);

% First frame to take
frame_start = -round(time_before_stim/frame_dur);

% Last frame to take:
frame_end = my_stim_dur + round((time_before_stim)/frame_dur);

% List of the frames to take
fr_before_stim = frame_start+my_stim_onset+1 : my_stim_onset;
fr_during_stim = my_stim_onset+1+gap : my_stim_onset+my_stim_dur+gap;
fr_after_stim = my_stim_onset+my_stim_dur+gap+1 : frame_end+my_stim_onset;
frame_window = frame_start:frame_end;
