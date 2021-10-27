function [Resp_to_cs] = statistical_compa(my_indiv,...
        MyFieldnames,DF_Score,cs,mi,Resp_to_cs)
    
for p=1:2 % which para
	for ph = 1:2 % which phase
        for o = 1:length(cs) % which CS

            my_i= o + 3*(p-1);
            mi= mi+1 ;
            vs = 1;

            % Compare resp to zero:
             Resp_to_cs{mi+1,1} = [MyFieldnames{1,o},' ',...
                 MyFieldnames{2,ph},' ',MyFieldnames{3,p}];

            [~,Resp_to_cs{mi+1,2}] = kstest(DF_Score{my_i,ph,vs}(my_indiv));
            [~,Resp_to_cs{mi+1,3}] = ttest(DF_Score{my_i,ph,vs}(my_indiv));
            [Resp_to_cs{mi+1,4},~] = signrank(DF_Score{my_i,ph,vs}(my_indiv));

            if ph == 1
            % Compare Pre and Post:
                 Resp_to_cs{o+p*3+20,1} = ['Pre vs Post ',...
                     MyFieldnames{1,o},' ',MyFieldnames{3,p}];
                 y = [DF_Score{my_i,1,vs}(my_indiv)-DF_Score{my_i,2,vs}(my_indiv)];

                [~,Resp_to_cs{o+p*3+20,2}] = kstest(y);
                [~,Resp_to_cs{o+p*3+20,3}] = ttest(y);
                [Resp_to_cs{o+p*3+20,4},~] = signrank(y);
            end
        end


        my_i= 1 + 3*(p-1);

        % Compare CS- and CS+:
        Resp_to_cs{ph+p*2+12,1} = ['CS+ vs CS- ',...
            MyFieldnames{2,ph},' ',MyFieldnames{3,p}];

        y = [DF_Score{my_i,ph,vs}(my_indiv)-DF_Score{my_i+1,ph,vs}(my_indiv)];
        [~,Resp_to_cs{ph+p*2+12,2}] = kstest(y);
        [~,Resp_to_cs{ph+p*2+12,3}] = ttest(y);
        [Resp_to_cs{ph+p*2+12,4},~] = signrank(y);


        % Compare Ctrl odor and CS+:
        Resp_to_cs{ph+p*2+16,1} = ['CS+ vs Ctrl odor ',...
            MyFieldnames{2,ph},' ',MyFieldnames{3,p}];

        y = [DF_Score{my_i,ph,vs}(my_indiv)-DF_Score{length(cs),ph,vs}(my_indiv)];
        [~,Resp_to_cs{ph+p*2+16,2}] = kstest(y);
        [~,Resp_to_cs{ph+p*2+16,3}] = ttest(y);
        [Resp_to_cs{ph+p*2+16,4},~] = signrank(y);


        % Compare diff CS- and CS+:
        Resp_to_cs{30+ph,1} = ['CS+ vs CS- relative resp'];


         % Caution: here 'ph' replaces 'vs'
         y = [(DF_Score{1,2,1+(ph-1)*3}(my_indiv)-(DF_Score{1,1,1+(ph-1)*3}(my_indiv)))- ...
             ((DF_Score{2,2,1+(ph-1)*3}(my_indiv)-(DF_Score{2,1,1+(ph-1)*3}(my_indiv))))];

        [~,Resp_to_cs{30+ph,2}] = kstest(y);
        [~,Resp_to_cs{30+ph,3}] = ttest(y);
        [Resp_to_cs{30+ph,4},~] = signrank(y);            

        % Anova test:
        
%         new_y = [DF_Score{1:2,:,4}]; % add my_indiv
%         new_y = new_y(my_indiv,:);
%         my_anova2=anova2(new_y);  

%         g1 = repmat(1:size(new_y,1),1,4);
%         g_tp = repmat(1:4,size(new_y,1),1);
%         g2 = g_tp(:);
%         g2(g2>2) = g2(g2>2)-2;
%         g3 = g_tp(:);
%         g3 = mod(g3,2);
%         new_y = new_y(:);
%         my_anovan=anovan(new_y,{g1,g2,g3}); 
        
    end
end