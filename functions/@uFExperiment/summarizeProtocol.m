function summarizeProtocol(uFExp)

uFType = uFExp.uFType;
STIM_onset = uFExp.STIM_onset;
STIM_dur = uFExp.STIM_dur;
total_duration_exp = uFExp.total_duration_exp;


if uFType == 4
    STIM_Temp = [STIM_onset{1};STIM_dur{1}];
    which_odor = cellfun(@(x) length(x),STIM_onset(1));
    STIM_Temp(3,:) = ones;
elseif uFType == 8
    STIM_Temp = [cell2mat(STIM_onset);cell2mat(STIM_dur)];
    which_odor = cellfun(@(x) length(x),STIM_onset);
    STIM_Temp(3,:) = ones;
    I=1;
    for i=1:5
        STIM_Temp(3,I:I+which_odor(i)-1)=repmat(i,which_odor(i),1)';
        I=I+which_odor(i);
    end
else
    display('PROBLEM! you must define the uFType - 4 or 8 channels')
end


%sort according to timing
[STIM,I]=sort(STIM_Temp(1,:));
STIM=STIM_Temp(:,I);

% odor protocol
STIM_timing = zeros(1,total_duration_exp);
STIM_overlap = zeros(1,total_duration_exp);
for i=1:sum(which_odor)
    STIM_timing(STIM(1,i):STIM(1,i)+STIM(2,i)-1)=STIM(3,i);
    STIM_overlap(STIM(1,i):STIM(1,i)+STIM(2,i)-1)=STIM_overlap(STIM(1,i):STIM(1,i)+STIM(2,i)-1)+1;
end


% from original function
%STIM_Temp,STIM,STIM_timing,STIM_overlap,which_odor

% we put things back into the calling object
uFExp.STIM_Temp = STIM_Temp;
uFExp.STIM = STIM;
uFExp.STIM_timing = STIM_timing;
uFExp.STIM_overlap = STIM_overlap;
uFExp.which_odor = which_odor;


end

