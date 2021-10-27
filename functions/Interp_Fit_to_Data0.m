function [I_d1] = Interp_Fit_to_Data0(Data1,Data0)
% Interpolates data to fit 2 datasets of different lengths*************************


if length(Data0)-length(Data1)>1
    disp(['the set is smaller by ',num2str(abs(length(Data1) - ...
       length(Data0))),' datapoints -> add NaNs']);

   % Interpolate the dataset:
    Data1(end:length(Data0)) = NaN;       
    I_d1 = Data1;

elseif abs(length(Data0)-length(Data1))<3
%     disp('the set differs by 1 or 2 datapoints -> interpolate')

    % Interpolate the shortest dataset:
    I_d1 = ...
        interp1(1:length(Data1),Data1,1:length(Data0));
    
elseif length(Data0)==length(Data1)
%     disp('the lengths of the datasets already fit.')   
    
    % Do nothing:
    I_d1 = Data1 ; 

else
    disp(['the set is not supposed to be ',num2str(abs(length(Data1) - ...
       length(Data0))),' datapoints bigger than Data0!!']);
   
end
  
