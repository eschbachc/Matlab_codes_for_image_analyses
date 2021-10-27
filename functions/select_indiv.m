function [selected_indiv] = select_indiv(l,Resp_to_odors,pvalue1,pvalue2)
% Uses previously computed p-values and sets a criteria to discard 
% the individuals not responding at the beginning or end of experiment

all_indiv = 1:l; %l = total number of indiv
                
selected_indiv = all_indiv(and(...
    Resp_to_odors.before_training(:,1) < pvalue1,...
    Resp_to_odors.after_training(:,1) < pvalue2));