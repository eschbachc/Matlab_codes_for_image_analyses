function make_legend(legend_text,legend_color)
% Add legend in the plot
% legend_text is a cell containing text (1 cell per box)
% ex: legend_text = {'Before','Test'};
% legend_color is a cell containing color code
%ex: legend_color = {'r','k'}; or {[0 0 0],[1 0 0]}

total = length(legend_text);
y_position = 10/total;
y_gap = 1/total;
axis([0 10 0 10])
axis off

for i = 1:total

    rectangle(...
        'Position',[1,y_position+i*y_gap,y_gap,y_gap/2],...
        'Facecolor',legend_color{i},...
        'Linestyle','none')%[x y w h]
    
    text(1.8,...
        y_position+i*y_gap+y_gap/4,...
        legend_text{i}) %(x,y,txt)

end