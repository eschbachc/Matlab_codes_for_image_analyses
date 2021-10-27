classdef uFExperiment < handle
    %SIEXPERIMENT Summary of this class goes here
    %   Detailed explanation goes here
    properties
        %1) Define default properties
        sample_rate = 1000;   %Hz
        total_duration_exp ; % in seconds sec, we will automatically generate it
        additional_final_exp_time = 10 ; % additional time to add at the end of experiment. Used to calculate final time
        
        visualize_protocol = 1 ; %1 = yes if you only want to vizualize protocol
        uFType = 4;  % either 4 or 8 channels
        
        STIM_onset;
        STIM_dur;
        
        LIGHT_onset;
        LIGHT_dur ;
        LIGHT_timing ;
        
        STIM_Temp;
        STIM;
        STIM_timing;
        STIM_overlap;
        which_odor;
        STIM_Protocol ;
        STIM_Protocol_exp_recorded ; % the protocol as it was recorded from the outputs
        
        v ;
        valves ;
        sorted_stimuli ;
        %MyLight_index;
        
%         LIGHT_Nrep=10;
%         LIGHT_duty=200;       %msec
%         LIGHT_noduty=400;     %msec

        
    end
    
    methods
        % external methods
        summarizeProtocol(uFExp);
        %uFType,STIM_onset,STIM_dur,total_duration_exp);

        function uFExp = uFExperiment(varargin)
            % {1} for odor 1, {2} for odor 2
            % for 4 channels, it will ignore any other odor besides {1}
%             uFExp.STIM_onset{1} = [20];      % sec
            %         STIM_dur{1}=[] ;         % duration in sec
            
            %         STIM_onset{2}=[];
            %         STIM_dur{2}=[] ;
            %
            %         STIM_onset{3}=[]   ;
            %         STIM_dur{3}=[]   ;
            %
            %         STIM_onset{4}=[] ;
            %         STIM_dur{4}=[]  ;
            %
            %         STIM_onset{5}=[] ;
            %         STIM_dur{5}=[]  ;
            
            if nargin < 3 
                disp('please provide minimal amount of information:');
                disp('use uFExperiment(uFType, STIM_onset,STIM_dur)');
            elseif nargin >= 3 % we got the correct amount!
                disp('we got 3!');
                uFExp.uFType = varargin{1};
                uFExp.STIM_onset = varargin{2};
                uFExp.STIM_dur = varargin{3};
                
                
                if nargin == 5
                    uFExp.LIGHT_onset = varargin{4};
                    uFExp.LIGHT_dur = varargin{5};
                end
                
                % let's find the max total time
                max_time = 0 ;
                for to = 1:length(uFExp.STIM_onset)
                    thisMax = max(uFExp.STIM_onset{to}) + max(uFExp.STIM_dur{to}) ;
                    if max_time < thisMax
                        max_time = thisMax;
                    end
                end
                
                for to = 1:length(uFExp.LIGHT_onset)
                    thisMax = uFExp.LIGHT_onset(to) + uFExp.LIGHT_dur(to) ;
                    if max_time < thisMax
                        max_time = thisMax;
                    end
                end
                
                
                disp(['Max time is ' , num2str(max_time)]);
                uFExp.total_duration_exp = max_time + uFExp.additional_final_exp_time;
                
                summarizeProtocol(uFExp);
                
                generateProtocol(uFExp);
                
                
            end
            
%             if isempty(uFExp.total_duration_exp)
%                 
%             end
        end
        
        function visualizeProtocol(uFExp)
            % plot
            
            %             if uFExp.visualize_protocol == 0 %only to vizualize the protocol
            
            close(findobj('type','figure','name','uf_visualization'));
            figure('name','uf_visualization');
            plot(1:uFExp.total_duration_exp,uFExp.STIM_timing,'m');
            hold on
            lightStimToPlot = -2 + uFExp.LIGHT_timing ;
            %plot(1/uFExp.sample_rate:1/uFExp.sample_rate:uFExp.total_duration_exp,uFExp.LIGHT_timing,'r');
            plot(1/uFExp.sample_rate:1/uFExp.sample_rate:uFExp.total_duration_exp,lightStimToPlot,'r');
            axis([0 uFExp.total_duration_exp -2 6])
            text(10,4,{['uF chip type is ',num2str(uFExp.uFType),' channels']});
            if max(uFExp.STIM_overlap) > 1 % don't continue if odors overlap
                text(6,1.5,'PROBLEM! odors overlap');
            elseif min(uFExp.STIM_Temp(1,:)) < 3  % don't run if odor is during initialisation
                text(3,1.5,['<- odor ',num2str(uFExp.STIM_Temp(3,find(uFExp.STIM_Temp(1,:)<3))),...
                    ' comes too early, min of 3 sec is necessary']);
            end
            
            %             end
        end
        
        function generateProtocol(uFExp)
            
            if max(uFExp.STIM_overlap) > 1 % don't continue if odors overlap
                display('PROBLEM! odors overlap');
            elseif min(uFExp.STIM_Temp(1,:)) < 3  % don't run if odor is during initialisation
                display(['PROBLEM! odor ',num2str(uFExp.STIM_Temp(3,find(uFExp.STIM_Temp(1,:)<3))),...
                    ' comes too early, min of 3 sec is necessary']);
            else % if all good then let's generate the output matrix
                
                %first we define the light protocol
                uFExp.LIGHT_onset = uFExp.LIGHT_onset * 1000; % converts in msec
                %uFExp.LIGHT_dur = LIGHT_Nrep * (LIGHT_duty + LIGHT_noduty);
                % create zero matrix for the timing
                uFExp.LIGHT_timing = zeros(1,uFExp.sample_rate * uFExp.total_duration_exp);
                for l=1:length(uFExp.LIGHT_onset)

                    onsetIdx = uFExp.LIGHT_onset(l); % we need to change this eventually since now we are confusing sample rate w/ frame rate
                    durationIdxs = uFExp.LIGHT_dur(l) * uFExp.sample_rate ;
                    uFExp.LIGHT_timing(onsetIdx:onsetIdx + durationIdxs ) = 1 ;
    
%                     
%                     I=1;
%                     J = uFExp.LIGHT_onset;
%                     
%                     
%                     
%                     for k=1:LIGHT_Nrep;
%                         MyLight_index{j}(I:I+LIGHT_duty-1) = J:J+LIGHT_duty-1;
%                         I = I+LIGHT_duty;
%                         J=J+LIGHT_duty+LIGHT_noduty;
%                     end
%                     
%                     
%                     LIGHT_timing(MyLight_index{1,j})=-1;
                end
%                 figure
%                 plot(uFExp.LIGHT_timing);

%                 uFExp.LIGHT_timing = LIGHT_timing;
                
                % Creates command for the valves
                STIM_Protocol = zeros(uFExp.sample_rate * uFExp.total_duration_exp,8); %preallocate
                % Attribute valves to stim (shouldn't be changed)
                v.Buffer = 7;
                v.SwitchB = 2;
                v.SwitchS = 3;
                v.Stim1 = 8;
                v.Stim2 = 1;
                v.Stim3 = 4;
                v.Stim4 = 5;
                v.Stim5 = 6;
                % Sort the stimuli according to the valves number
                stimuli = fieldnames(v);
                valves = cellfun(@(x) v.(stimuli{x}),{1,2,3,4,5,6,7,8})
                [sorted_valves,I]=sort(valves)
                for i=1:8
                    sorted_stimuli{i,1}=stimuli{I(1,i)}
                end
                
                %INITIALISATION PROTOCOL FOR 8 channel chip
                % Opens then close each valve 1 by 1 w/o exposing the larva to the odors
                STIM_Protocol(251:500,[v.Buffer v.SwitchB]) = 1;
                STIM_Protocol(501:750,[v.Buffer v.SwitchB]) = 0;
                STIM_Protocol(751:1000,[v.Buffer v.SwitchB v.SwitchS]) = 1;
                for i=1:5
                    MyField = ['Stim',num2str(i)];
                    STIM_Protocol(1001+(i-1)*250:1250+(i-1)*250,[v.Buffer v.SwitchB v.(MyField)]) = 1;
                end
                
                % STIMULATION PROTOCOL
                for i=1:sum(uFExp.which_odor)
                    MyField = ['Stim',num2str(uFExp.STIM(3,i))];
                    % prepare the odor
                    Updated_state = zeros(1,8);
                    Updated_state(1,[v.Buffer v.SwitchB v.(MyField)])=1;
                    ind = find(STIM_Protocol(:,v.Buffer),1, 'last'); %finds end of protocol
                    New_command = repmat(Updated_state,uFExp.STIM(1,i)*1000-1-ind,1);
                    STIM_Protocol(ind:ind+length(New_command)-1,:)= New_command;
                    % present the odor
                    Updated_state = zeros(1,8);
                    Updated_state(1,[v.Buffer v.SwitchS v.(MyField)])=1;
                    ind = find(STIM_Protocol(:,v.Buffer),1, 'last');
                    New_command = repmat(Updated_state,uFExp.STIM(2,i)*1000-1,1);
                    STIM_Protocol(ind:ind+length(New_command)-1,:)= New_command;
                end
                % end of the protocol:
                Updated_state = zeros(1,8);
                Updated_state(1,[v.Buffer v.SwitchS v.SwitchB])=1;
                ind = find(STIM_Protocol(:,v.Buffer),1, 'last');
                New_command = repmat(Updated_state,length(STIM_Protocol)-ind+1,1);
                STIM_Protocol(ind:end,:)= New_command;
                
                
                % we save our variables in the class
                uFExp.STIM_Protocol = STIM_Protocol;
                
                uFExp.sorted_stimuli = sorted_stimuli ;
                uFExp.v = v;
                uFExp.valves = valves;
                
                
            end
        end
        
        function plotValves(uFExp)
            figure ;
            plot(uFExp.STIM_Protocol(:,[uFExp.v.Buffer])*.5+uFExp.v.Buffer,'k');
            hold on
            plot(uFExp.STIM_Protocol(:,[uFExp.v.SwitchS])*.5+uFExp.v.SwitchS,'color',[0 .5 0]);
            hold on
            plot(uFExp.STIM_Protocol(:,[uFExp.v.SwitchB])*.5+uFExp.v.SwitchB,'k');
            for i=1:5
                MyField = ['Stim',num2str(i)];
                hold on
                plot(uFExp.STIM_Protocol(:,[uFExp.v.(MyField)])*.5+uFExp.v.(MyField),'color',[1-(i/10) i/8 i/8])
            end
            axis([0 uFExp.total_duration_exp*uFExp.sample_rate 0 9])
            set(gca,'yTickLabel',[' '; uFExp.sorted_stimuli;' '])
            text(10000,7,{[num2str(uFExp.uFType),' CHANNEL CHIP']})
            
        end
        
    end
        
    methods (Static)
    end
    
end




