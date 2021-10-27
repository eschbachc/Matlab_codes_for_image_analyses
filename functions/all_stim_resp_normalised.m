function [y,I] = all_stim_resp_normalised(...
mySTIM_onset,time_before_stim,myDifMean_G,...
frame_dur,mySTIM_dur,cs,y)

% Find all the frames preceeding all stim (for baseline fluo):
for o = 1:length(cs)
    
    idx_0(o,:) = round([...
        mySTIM_onset{cs(o)}(1) - time_before_stim;...
        mySTIM_onset{cs(o)}(1);...
        mySTIM_onset{cs(o)}(2) - time_before_stim;...
        mySTIM_onset{cs(o)}(2)]/...
        frame_dur);

end

% Baseline fluorescence (average fluo before all stim)
for o = 1:length(cs)

    y0 = [nanmean(myDifMean_G(idx_0(o,1):idx_0(o,2)));...
        nanmean(myDifMean_G(idx_0(o,3):idx_0(o,4)))];    

end

my_y1 = cell(length(cs)*2,1);

for o = 1:length(cs)
    
% Find the frames during odor presentation
    idx_1(o,:) = round([...
        mySTIM_onset{cs(o)}(1);...
        mySTIM_onset{cs(o)}(1) + mySTIM_dur{cs(o)}(1);...
        mySTIM_onset{cs(o)}(2);...
        mySTIM_onset{cs(o)}(2) + mySTIM_dur{cs(o)}(2)]...
        /frame_dur);
    
%Normalize each resp to overall baseline fluo
    % at 1st stim presentation:
    my_y1{o*2-1}  = (myDifMean_G(...
        idx_1(o,1):idx_1(o,2))- y0(1))./y0(1);
    % at 2nd stim presentation:
    my_y1{o*2}  = (myDifMean_G(...
        idx_1(o,3):idx_1(o,4))- y0(2))./y0(2);
end

% average all odor responses:
I= interpolate_and_average(my_y1,frame_dur,frame_dur);

% take the peak resp:
y1 = nanmax(I.Averaged_datasets);

% normalise dF/F0 by this peak response:
if y1<0
    y=[];
    disp('baseline fluo is negative!');
else
    y = y./y1;
end