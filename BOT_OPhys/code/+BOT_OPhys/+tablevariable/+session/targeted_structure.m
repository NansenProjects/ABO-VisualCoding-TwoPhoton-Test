classdef targeted_structure < nansen.metadata.abstract.TableVariable
%TARGETED_STRUCTURE Definition for table variable
%   Detailed explanation goes here
%
%   See also nansen.metadata.abstract.TableVariable
    
    properties (Constant)
        IS_EDITABLE = false
        DEFAULT_VALUE = 'struct.empty'
    end
    
    methods
        function obj = targeted_structure(varargin)
            obj@nansen.metadata.abstract.TableVariable(varargin{:});
        end 
    end
    
end