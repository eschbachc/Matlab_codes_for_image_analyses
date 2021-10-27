function resu = interpolate_and_average(My_datasets,frame_dur,t);
% ******* Interpolate data to new time basis ******
% * t = new time interval requested               *
% * My_datasets = cell containing the datasets    *
% *************************************************

total_duration = 0;

for N = 1:length(My_datasets)

    % find time frame:
    recording_time = frame_dur:frame_dur:frame_dur*length(My_datasets{N});
    interpol_time = t:t:max(recording_time);

    % find max duration:
    if total_duration < length(interpol_time)
        total_duration = length(interpol_time);
    end

    % interpolate
    if ~isempty(My_datasets)
        Interpolated_datasets{N,1} = interp1(recording_time, My_datasets{N}, interpol_time);
    else
        Interpolated_datasets{N,1} = []
    end
end

% make sure all interpolated datasets have same length:
for N = 1:length(My_datasets)
    if ~isempty(Interpolated_datasets{N,1})
        if length(Interpolated_datasets{N,1}) < total_duration
        Interpolated_datasets{N,1}(end+1:total_duration) = NaN;
        end     
    end    
end

% transform the cell into a matrix
Interpolated_datasets2 = cell2mat(Interpolated_datasets);

% calculate everything :-)
resu.Averaged_datasets = nanmean(Interpolated_datasets2,1);
resu.Stdev_datasets = nanstd(Interpolated_datasets2,1);
resu.N_datasets = sum(~isnan((Interpolated_datasets2)));
resu.total_var = nanvar(Interpolated_datasets2(:));
resu.Median_datasets = nanmedian(Interpolated_datasets2,1);