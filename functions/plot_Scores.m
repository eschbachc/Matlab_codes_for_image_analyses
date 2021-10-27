function plot_Scores(o,vs,l,c,k,DF_Score,MyColor,which_group,A)



for p= 1:2 % 2 Parameters: mean and area

    subplot(8,4,o+((p-1)*4)+(vs-1)*8)

    hold on
    plot(1:2,...
        [DF_Score{o+(p-1)*3,1,vs}(l),...
         DF_Score{o+(p-1)*3,2,vs}(l)],...
        '-o','color',MyColor(l,:),'linewidth',.8)
end

if o==1

    % Legend
    subplot(1,4,4)    
    rectangle(...
        'Position',[0,10-(l-c)*.5,.5,.2],...
        'Facecolor',MyColor(l,:),...
        'Linestyle','none') %[x y w h]
    text(1,10.05-(l-c)*.5,[A{which_group,2}{k},' ',A{which_group,1}])
    axis([0 13 3 13])  
    axis off
end