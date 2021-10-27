function [J,J_larv,J_step,Myj,j,cs,phase,t] = reset_counters


J = [];     % will take each single value of MyJ within a loop
J_larv = 0; % counts number of indiv within the loop
J_step = 0; % counts number of runs within the loop    
Myj = [];   % list runs for a given indiv
j= 0;      % will take each single value of Myj within a loop
cs = [];    % counter for stim presentation
phase = []; % counter for phase of the run (before/after training)
t = [];     % counter for time of stim presentation within a run (1 and 2)