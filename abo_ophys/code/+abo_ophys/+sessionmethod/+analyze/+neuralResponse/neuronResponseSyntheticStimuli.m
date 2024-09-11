function varargout = neuronResponseSyntheticStimuli(sessionObject, varargin)
%NEURONRESPONSESYNTHETICSTIMULI Summary of this function goes here
%   Detailed explanation goes here


% % % % % % % % % % % % % % CUSTOM CODE BLOCK % % % % % % % % % % % % % % 
% Create a struct of default parameters (if applicable) and specify one or 
% more attributes (see nansen.session.SessionMethod.setAttributes) for 
% details.
    
    % Get struct of parameters from local function
    params = getDefaultParameters();
    
    % Create a cell array with attribute keywords
    ATTRIBUTES = {'serial', 'unqueueable'};   

    
% % % % % % % % % % % % % DEFAULT CODE BLOCK % % % % % % % % % % % % % % 
% - - - - - - - - - - Please do not edit this part - - - - - - - - - - - 
    
    % Create a struct with "attributes" using a predefined pattern
    import nansen.session.SessionMethod
    fcnAttributes = SessionMethod.setAttributes(params, ATTRIBUTES{:});
    
    if ~nargin && nargout > 0
        varargout = {fcnAttributes};   return
    end
    
    % Parse name-value pairs from function input.
    params = utility.parsenvpairs(params, [], varargin);
    
    
% % % % % % % % % % % % % % CUSTOM CODE BLOCK % % % % % % % % % % % % % % 
% Implementation of the method : Add your code here:    

    stimulusNames = sessionObject.stimulus_list;
    if ~any(strcmp(stimulusNames, params.stimulus_type))
        if strcmp(params.stimulus_type, 'drifting_gratings')
            error('This session does not have drifting grating stimulus conditions. Select a session with stimulus name Three Session A.')
        elseif strcmp(params.stimulus_type, 'static_gratings')
            error('This session does not have static grating stimulus conditions.')
        end
    end

    timestamps = sessionObject.fluorescence_timestamps;
    traces = sessionObject.fluorescence_traces_dff;

    % get the stimulus information for drifting grating responses
    driftingGratings = sessionObject.getStimulusTable(params.stimulus_type);
    
    % use a utility function to estimate single-trial responses for each stimulus
    responses = bot.util.StimulusAlignedResp(driftingGratings, traces);
    
    % locate "blank" stimulus presentations
    blankPresentations = driftingGratings.blank_sweep == 1;
    
    % extract neural responses to blank presentations
    blankResponses = mean(responses(blankPresentations, :),'omitnan');
    
    % subtract blank responses
    responsesCorrected = responses - blankResponses;
    

    % get a list of unique stimulus parameters and assign a stimulus ID to each presentation
    driftingGratingsTbl = timetable2table(driftingGratings,"ConvertRowTimes",false);
    [uniqueStimuli, ~, presentationStimID] = unique(driftingGratingsTbl(:, 1:2), 'rows');
    
    % find NAN stimuli and remove them
    nanStimuli = isnan(uniqueStimuli.temporal_frequency);
    uniqueStimuli = uniqueStimuli(~nanStimuli, :);
    numStimuli = size(uniqueStimuli, 1);
    numROIs = size(responsesCorrected, 2);
    
    % preallocate arrays
    singleTrialResponses = cell(numStimuli, 1);
    meanStimulusResponses = nan(numStimuli, numROIs);
    varStimulusResponses = nan(numStimuli, numROIs);
    
    % collect single-trial responses for each stimulus
    for stimulusID = 1:size(uniqueStimuli, 1)
        % find the presentations of this stimulus
        theseTrials = presentationStimID == stimulusID;
        
        % collect all the fluorescence responses for this stimulus into a cell array
        singleTrialResponses{stimulusID} = responsesCorrected(theseTrials, :);
        
        % estimate response statistics for this stimulus
        meanStimulusResponses(stimulusID, :) = mean(singleTrialResponses{stimulusID},'omitnan');
        varStimulusResponses(stimulusID, :) = var(singleTrialResponses{stimulusID},'omitnan');
    end
    
    % visualize the mean responses
    figure;
    imagesc(meanStimulusResponses' * 100);
    xlabel('Stimulus  ID');
    ylabel('ROI ID');
    title('Visually evoked responses')
    caxis([0 10]);
    ax = colorbar;
    ylabel(ax, 'dF/F0 (%)')

end


function S = getDefaultParameters()
    
    S = struct();
    S.stimulus_type = 'drifting_gratings';
    S.stimulus_type_ = {'drifting_gratings', 'static_gratings'};
    % Add more fields:

end