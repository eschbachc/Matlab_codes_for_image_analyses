function plot_Mean_Scores2(vs,p,o,Scores,whichCS,cs,my_indiv)
hold on

errorbar([.9;2.1],...
[nanmean(Scores{o,1,vs}(my_indiv));...
nanmean(Scores{o,2,vs}(my_indiv))],...
[nanstd(Scores{o,1,vs}(my_indiv)); ...
nanstd(Scores{o,2,vs}(my_indiv))], ...
'-o','color',[0 0 0],...
'Markerfacecolor',[0 0 0],'linewidth',1.5); 

line([.5,3],[0,0],'Color','k','linewidth',.5) % zero line

% Title
title(whichCS{1,o})

box off
axis([0.7 2.3 -1.8 5.2]) 
if and(o==1,p==1)
    ylabel('Mean')
elseif and(o==1,p==2)
    ylabel('Peak')                    
end
