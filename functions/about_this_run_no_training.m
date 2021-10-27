function [phase,cs,fr_before_stim,fr_during_stim,fr_after_stim,...
                myDifMean_G,myRawMean_G,frame_window]=...
    about_this_run_no_training(filename,T,title_gp,ROI,time_before_stim,...
    STIM_dur,STIM_onset,gap)

    % Classify run as 'bef'(ore training) or 'test' ***********************
    phase= 1*contains(filename,'bef')+ 2*contains(filename,'test');
    
    % Sort which odor is CS+ or CS-: [cs+ cs-] ****************************
    if contains(title_gp,'AM_18')
        cs = [3 2]; ctl = 1;
    elseif contains(title_gp,'EA_18')
        cs = [2 3]; ctl = 1;
    elseif contains(title_gp,'EA_17')
        cs = [1 2]; ctl = [];
    elseif contains(title_gp,'ME_17')
        cs = [2 1]; ctl = [];
    elseif contains(title_gp,'OC_17')
      cs = [2 3]; ctl = []; % CHECK NUMBERS
    elseif contains(title_gp,'AM_17')
      cs = [3 2]; ctl = [];
    elseif contains(title_gp,'costim')
        if ~isempty(STIM_onset{1})
            cs={{'STIM',1},{'LIGHT',1}}; ctl=[];% only 1 odor + 1 light stim
        elseif ~isempty(STIM_onset{2}) 
            cs={{'STIM',2},{'LIGHT',1}}; ctl=[];% only 1 odor + 1 light stim
        end
    else
      cs = {{'STIM',1},{'STIM',2},{'STIM',3}}; ctl=[];
      %       MEe1  1 -  EAe4  2 -  AMe3  3
    end
    cs = [cs ctl];
        
    % Find the frames for each stimulation ********************************
    [fr_during_stim,fr_before_stim,fr_after_stim,frame_window] =...
        which_frames(gap,time_before_stim,T.frame_dur,STIM_dur{1}(1),0);
    
    % Get averaged data from data file ************************************   
    if length(T.DifMean_G)>1
        myDifMean_G = T.DifMean_G{ROI}{1};
        myRawMean_G = T.MyMean_G{ROI}{1};
    else
        myDifMean_G = T.DifMean_G{1}{ROI};
        myRawMean_G = T.MyMean_G{1}{ROI};
    end
    
end