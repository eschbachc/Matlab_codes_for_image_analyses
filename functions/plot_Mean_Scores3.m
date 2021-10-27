function plot_Mean_Scores3(p,o,phase,Scores,whichCS,my_indiv,...
    color,markersize,linewidth)

hold on
Fieldnames1 = {'mean_per_indiv','peak_per_indiv','ampli_per_indiv'};
Fieldnames2 = {'mean','peak - baseline','ampli - baseline'};
myfield = Fieldnames1{p};
mytitle = {'on','off'};

if length(my_indiv)==1
    errorbar(1.5+my_indiv*.1,...
    Scores.(myfield){o,phase}(my_indiv),...
    Scores.(['std_',myfield]){o,phase}(my_indiv),...
    'o','color',color,...
    'Markerfacecolor',color,...
    'Markersize',markersize,...
    'linewidth',linewidth); 
else
    errorbar(3,...
    nanmean(Scores.(myfield){o,phase}(my_indiv)),...
    nanstd(Scores.(myfield){o,phase}(my_indiv)),...
    'o','color',color,...
    'Markerfacecolor',color,...
    'Markersize',markersize,...
    'linewidth',linewidth); 
    % was {o,1}...
    line([.5,3],[0,0],'Color','k','linewidth',.5) % zero line
    ylabel(Fieldnames2{p})
end

% Title
title([whichCS,'-',mytitle{phase}])

box off
% axis([0.7 1.3 -1 4.5]) 
axis auto


% if p==1
%     ylabel('Mean')
% elseif p==2
%     ylabel('Peak')                    
% end
