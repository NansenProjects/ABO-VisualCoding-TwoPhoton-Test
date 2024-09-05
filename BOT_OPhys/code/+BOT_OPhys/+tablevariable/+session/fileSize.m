function value = fileSize(sessionObject)
%FILESIZE Get value for fileSize
%   Detailed explanation goes here
    
    % Initialize output value with the default value.
    value = nan;                 % Please do not edit this line
    
    % Return default value if no input is given (used during config).
    if nargin < 1; return; end	% Please do not edit this line
    
    
    % Insert your code here:
    fileInfo = sessionObject.info.well_known_files;
    names = arrayfun(@(s) s.well_known_file_type.name, fileInfo, 'UniformOutput', 0);
    isNwb = strcmp(names, 'NWBOphys');

    fileInfo = fileInfo(isNwb);
    fileUrl = strjoin({'http://api.brain-map.org', fileInfo.download_link}, '/');
    
    value = round( bot.util.getWebFileSize(fileUrl) / 1024 / 1024 );

    
end

