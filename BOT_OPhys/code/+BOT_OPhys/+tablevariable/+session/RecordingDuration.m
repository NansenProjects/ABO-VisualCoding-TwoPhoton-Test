function value = RecordingDuration(sessionObject)
%RECORDINGDURATION Get value for RecordingDuration
%   Detailed explanation goes here
    
    % Initialize output value with the default value.
    value = {'N/A'};                 % Please do not edit this line
    
    % Return default value if no input is given (used during config).
    if nargin < 1; return; end	% Please do not edit this line
    
    
    % Insert your code here:
    t = sessionObject.fluorescence_timestamps;

    interval = t(end)-t(1);
    value = char(interval);
    
end

