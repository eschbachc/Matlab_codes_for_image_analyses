function  save_it_all(MyPath2save,which_group,Statistics,N_plot,type,h)

% Define size of figure 2 and 5
for f=1
    figure(f)
    set(gcf,'PaperPosition',[.01 .01 12 N_plot*4],'color','w'); %Position plot rect [left, bottom, width, height]
    set(gcf, 'PaperSize', [12 N_plot*4]); %Set the paper to have width 5 and height 5.        
end
for f=2
    figure(f)
    set(gcf,'PaperPosition',[.01 .01 25 h*5],'color','w'); %Position plot rect [left, bottom, width, height]
    set(gcf, 'PaperSize', [25 h*5]); %Set the paper to have width 5 and height 5.        
end
for f=3
    figure(f)
    set(gcf,'PaperPosition',[.01 .01 10 10],'color','w'); %Position plot rect [left, bottom, width, height]
    set(gcf, 'PaperSize', [10 10]); %Set the paper to have width 5 and height 5.        
end

% Save figures
for f=1:3 
%     print('-vector','-dpdf',figure(f));
	saveas(figure(f),[MyPath2save,which_group(1:7),'_',...
        type,'_',num2str(f),'.pdf']); %Save figure
end

% Save statistics
save([MyPath2save,which_group(1:7),'_',type,'_Statistics_2016_'],...
    'Statistics');
