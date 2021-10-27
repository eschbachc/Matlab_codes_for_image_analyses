% function to list files containing the keyword and not the antikeyword

function [Filenames] = list_files(MyPath,Fol,KeyWord,KeyWord_bis,AntiKeyWord,AntiKeyWord2)  
list_all_files = dir([MyPath,'/',Fol]);
[MyPath,'/',Fol];
for i = 1:length(list_all_files);
    logic(i) = and(and(~isempty(strfind(list_all_files(i).name, KeyWord)),...
        ~isempty(strfind(list_all_files(i).name, KeyWord_bis))),...
        and(isempty(strfind(list_all_files(i).name, AntiKeyWord)),...
        isempty(strfind(list_all_files(i).name, AntiKeyWord2))));
    % creates a logical array w/ KeyWords and not AntiKeyWords
    
end
Filenames=list_all_files(logical(logic)); % lists only folders w/ 
