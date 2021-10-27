function [MyJ,J_idx] = list_individuals(list_A,Dir_Names)

b=0;

% List N# of ROIs per exp (will loop for the same exp if many ROIs)
for b1 = 1: size(list_A,1)% number of groups

    for b2=1:3-sum(cellfun(@isempty,{list_A{b1,2:4}}))
        
        b= b+1; % Increases for individual repeats
        
        % vector listing the individual indices (can have repeats)
        MyJ(b)= find(strcmp({Dir_Names.name},list_A{b1,1})); 
        
        % Creates a vector of repeat per larva, e.g. [1 2 1 2 3...]
        J_idx(b) = b2; 
    end
    
end
