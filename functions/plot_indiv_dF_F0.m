function plot_indiv_dF_F0(plot_idx,CS_name,MyColor,indiv_name,gp_name,...
      my_axis,stim_duration,time_before_stim,phase,y,x,linewidth,draw,titl)
%(plot_idx,CS_name,MyColor,indiv_name,gp_name,my_axis,stim_duration,time_before_stim,phase,y,x,linewidth,draw)

% Title of the plot
if plot_idx == 1 & titl==1
    title({CS_name,'',[indiv_name,'  ',gp_name]})
elseif plot_idx == 1
    title({CS_name,' ',' '})
elseif titl==1
    title([indiv_name,'  ',gp_name])
end

% Axis
axis(my_axis)   
axis off

% Show time and fluo scale
line([1 3],[1 1],'color',[0 0 0],'linewidth',0.5);
line([1 1],[1 1.5],'color',[0 0 0],'linewidth',0.5);
text(2.5,.95,'2s') %(x,y,txt)
text(.1,1.6,'0.5') %(x,y,txt)
text(.2,.95,'0') %(x,y,txt)

% Plot the fluorescence
plot(x,y,'color',MyColor(plot_idx,:),'linewidth',linewidth);

if draw == 1
    y_twentieth = (my_axis(4) - my_axis(3))/25;
    % Add rectangle for the stimulation
    rectangle('Position',...
        [time_before_stim, my_axis(3)+ y_twentieth,stim_duration,y_twentieth],...
        'Facecolor',MyColor(plot_idx,:),...
        'Linestyle','none')%[x y w h]
end

end