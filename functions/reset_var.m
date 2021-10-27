function [MyColor,norm_frame_dur,time_before_stim,time_after_stim,...
    gap,stim_num,DF_tp,DF,Mean_tp,Peak_tp,Ampli_tp,Scores,Resp_to_odors,...
    Statistics, MyFieldnames,whichCS,l,Cumu_larv] = ...
    reset_var(N_plot,type)

% Define variables:
MyColor = hsv(N_plot) ; % define color code
norm_frame_dur = 0.2 ; % frame period used for interpolation
time_before_stim = 5 ; % in sec, used for stats and plot
time_after_stim = 5 ;  % in sec
gap = 0; % in sec

% Preallocate variables
stim_num = zeros(N_plot,2);
DF_tp =   cell(6,2,N_plot,6,2);
DF = struct();
Mean_tp = cell(6,2,N_plot,6,2);
Peak_tp = cell(6,2,N_plot,6,2);
Ampli_tp = cell(6,2,N_plot,6,2);

Scores = struct;
Scores.mean_indiv_events =   cell(3,2,N_plot,4,2);
Scores.mean_per_indiv =      cell(3,2,2);
Scores.var_per_indiv =       cell(3,2,2);
Scores.peak_indiv_events =   cell(3,2,N_plot,4,2);
Scores.peak_per_indiv =      cell(3,2,2);
Scores.var_peak_per_indiv =  cell(3,2,2);
Scores.ampli_indiv_events =   cell(3,2,N_plot,4,2);
Scores.ampli_per_indiv =      cell(3,2,2);
Scores.var_ampli_per_indiv =  cell(3,2,2);

Resp_to_odors = struct;
Resp_to_odors.before_training = [];
Resp_to_odors.after_training =  [];
Statistics = struct;
Statistics.RespToCS_pVal = [];
Statistics.Analysis_variance = [];

% Give names:
if contains(type,'train')
    MyFieldnames = {'CSp','CSm','ctrlodor';'pre','post',[];'mean','max','ampli'};
elseif contains(type,'costim')
    MyFieldnames = {'ethyl acetate','KC activ','';'on','off',[];'mean','max','ampli'};
else
    MyFieldnames = {'MEe1','EAe4','AMe3';'on','off',[];'mean','max','ampli'};
end

Statistics.RespToCS_pVal{1,2} = 'kstest' ; % test for normal distribution
Statistics.RespToCS_pVal{1,3} = 'ttest'  ; % if distri is normal
Statistics.RespToCS_pVal{1,4} = 'signrk' ; % if distri is not normal
whichCS = {'CSp','CSm'};

% Set counter to zero:
l=0 ;                  % Incremental idx: n of indiv in each group
Cumu_larv = 0 ;        % how many indiv total


