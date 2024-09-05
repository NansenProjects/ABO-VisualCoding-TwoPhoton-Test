classdef well_known_files < nansen.metadata.abstract.TableVariable ...
        & nansen.metadata.abstract.TableColumnFormatter
%DataLocation Controls behavior of table cells containing datalocation items.
%
%   
    
    properties (Constant)
        IS_EDITABLE = false
        DEFAULT_VALUE = struct.empty
    end

    
    properties
        % Value is a struct of relative pathstrings to well known files.
        % Value struct
    end
   
    methods
        function obj = well_known_files(S)
            if nargin < 1; S = struct.empty; end
            obj@nansen.metadata.abstract.TableVariable(S);
            
            try
                structArray = [obj.Value];
            catch
                structArray = {obj.Value};
            end

            if isa(structArray, 'struct')
                assert( all( arrayfun(@isstruct, structArray)), 'Value must be a struct')
            elseif isa(structArray, 'cell')
                structArray(cellfun(@isempty,structArray)) = {struct.empty};
                assert( all( cellfun(@isstruct, structArray)), 'Value must be a struct')
            end
        end
    end
   
    methods
        
        function str = getCellDisplayString(obj)
        %getCellDisplayString Get character vector to display in table cell
            
            % todo: vectorize
            
            % Assume that the current datalocation model is valid. This
            % is a weak assumption, since it is in theory possible to have
            % a call this function with values from sessions/metatables
            % that are not part of the current project...
            
            str = cell(numel(obj), 1);
            
            cacheDir = getpref('BrainObservatoryToolbox', 'CacheDirectory');

            for i = 1:numel(obj)
                
                [names, paths] = deal(cell(size(obj(i).Value)));
                
                for j = 1:numel(obj(i).Value)
                    paths{j} = obj(i).Value(j).path;
                    names{j} = obj(i).Value(j).well_known_file_type.name;
                end
            
                numFiles = numel(names);
                
                thisStr = '<html>';

                for j = 1:numFiles
                    thisFilePath = fullfile(cacheDir, paths{j});
                    if isempty( thisFilePath )
                        tmpStr = obj.getIconHtmlString('dot_none');
                    elseif isfile( thisFilePath )
                        tmpStr = obj.getIconHtmlString('dot_on');
                    else
                        tmpStr = obj.getIconHtmlString('dot_off');
                    end

                    thisStr = strcat(thisStr, tmpStr);
                end

                if numFiles == 0
                    thisStr = sprintf('%d Files', numFiles);
                end
                
                str{i} = thisStr;
            end
            
        end
       
        function str = getCellTooltipString(obj)
        %getCellTooltipString Get character vector to display as tooltip
        
            fileInfo = obj.Value;
            
            if isa(fileInfo, 'cell')
                fileInfo = fileInfo{1};
            end
            
            if isempty(fileInfo)
                str = '';
            else
                
                % Create a html formatted string from values in struct
                str = cell(size(fileInfo));
                strtab = '&nbsp;&nbsp;&nbsp;&nbsp;';
                for i = 1:numel(fileInfo)
                    str{i} = sprintf('%s<br/>%s Filepath: %s<br />%s', ...
                        fileInfo(i).well_known_file_type.name, ...
                        strtab, fileInfo(i).path );
                end
                
                str = strjoin(str, '<br /><br />'); % Add blank line between data locations
                str = sprintf('<html><div align="left"> %s </div>', str);
                                
            end
        end
        
    end

    methods (Static)
        
        function str = getIconHtmlString(iconName, iconSize)
        %getIconHtmlString Return html string for icon with given name
        %
        %   str = <CLASSNAME>.getIconHtmlString(iconName)
        %
        %   str = <CLASSNAME>.getIconHtmlString(iconName, iconSize)
        %
        %   Input:
        %       iconName : 'dot_on' | 'dot_off'
        
            if nargin < 2
                iconSize = 16;
            end
                    
            iconPath = fullfile(nansen.rootpath, 'code', '+nansen', '+metadata', '+tablevar', '_symbols');
            iconPath = fullfile(iconPath, sprintf('%s.png', iconName));
            
            sizeSpec = sprintf('width="%d" height="%d"', iconSize, iconSize);
            str = sprintf('<img src="file:%s" %s margin="0">', iconPath, sizeSpec);
            
        end
        
    end
    
end