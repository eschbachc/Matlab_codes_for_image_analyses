function [Resp_to_odors]=significant_response2(indiv_stim,indiv_id,...
    Resp_to_odors)
        
%   Scores.mean_indiv_events{o,phase,indiv_id,vs}(end+1)

% Is there a resp to the odors before training (used to select individuals)?

% Pool all 3 odors before training:
 y= [indiv_stim{1,1,indiv_id},...
    indiv_stim{2,1,indiv_id},...
    indiv_stim{3,1,indiv_id}];
% Test against zero: 
[~,Resp_to_odors.before_training(indiv_id,1)] = ttest(y,...
    zeros(1,length(y)),'Tail','right');  


% [~,Resp_ctrl_odor_beg(indiv_id,1)] = ttest(Resp_ctrl_odor{indiv_id,1},...
%     zeros(size(Resp_ctrl_odor{indiv_id,1})),'Tail','right');  

% Is there resp to the odors after training (also used to select indiv)?

% Pool all 3 odors after training:
 y= [indiv_stim{1,2,indiv_id},...
    indiv_stim{2,2,indiv_id},...
    indiv_stim{3,2,indiv_id}];
% Test against zero: 
[~,Resp_to_odors.after_training(indiv_id,1)] = ttest(y,...
    zeros(1,length(y)),'Tail','right');  

% [~,Resp_odor_test(indiv_id,1)] = ttest(y,...
%     zeros(1,length(y)),'Tail','right');  
% 
% [~,Resp_ctrl_odor_test(indiv_id,1)] = ttest(Resp_ctrl_odor{indiv_id,2},...
%     zeros(size(Resp_ctrl_odor{indiv_id,2})),'Tail','right');