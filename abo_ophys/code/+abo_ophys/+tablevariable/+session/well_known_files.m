classdef well_known_files < nansen.metadata.abstract.TableVariable
%WELL_KNOWN_FILES Definition for table variable
%   Detailed explanation goes here
%
%   See also nansen.metadata.abstract.TableVariable
    
    properties (Constant)
        IS_EDITABLE = false
        DEFAULT_VALUE = 'struct.empty'
    end
    
    methods
        function obj = well_known_files(varargin)
            obj@nansen.metadata.abstract.TableVariable(varargin{:});
        end 
    end
    
end