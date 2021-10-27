%list folders containing keyword but not keyword_bis

function [Dir_Names] = list_dir2(MyPath,KeyWord,AKeyWord2,AKeyWord3)  
list_all_dir = dir(MyPath);
    % remove non-folders
for i = length(list_all_dir):-1:1
    if ~list_all_dir(i).isdir
        list_all_dir(i) = [];
    continue
    end 
end 
for i = 1:length(list_all_dir);

    logic(i) = and(and(~isempty(strfind(list_all_dir(i).name, KeyWord)),...
        isempty(strfind(list_all_dir(i).name, AKeyWord2))),...
        isempty(strfind(list_all_dir(i).name, AKeyWord3))); 
end

Dir_Names=list_all_dir(logical(logic)); % lists only folders w/ AND w/o
