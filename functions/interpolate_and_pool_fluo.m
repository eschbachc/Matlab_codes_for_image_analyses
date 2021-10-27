 function [y,x,eb] = interpolate_and_pool_fluo(...
    my_y,norm_frame_dur,l)


y_tp = interpolate_and_average(...
    my_y,...
    norm_frame_dur,...
    norm_frame_dur);

y= y_tp.Averaged_datasets;

eb= y_tp.Stdev_datasets/sqrt(l);

x=0:norm_frame_dur:norm_frame_dur*(length(y)-1);