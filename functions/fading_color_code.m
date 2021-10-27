function MyFadingColor = fading_color_code(DF_tp_subset,my_stim,MyColor)

b1 = {DF_tp_subset};
b2 = length(b1)-sum(cellfun(@isempty,b1));

% Define color code that fades with stim presentation

MyFadingColor =[repmat(MyColor,1,b2+2-my_stim),...
    repmat(ones(size(MyColor)),1,my_stim)];

MyFadingColor = [mean(MyFadingColor(:,1:3:b2*4),2),...
    mean(MyFadingColor(:,2:3:b2*4),2),...
    mean(MyFadingColor(:,3:3:b2*4),2)];