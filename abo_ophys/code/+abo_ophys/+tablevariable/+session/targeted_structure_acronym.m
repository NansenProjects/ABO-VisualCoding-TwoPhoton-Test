classdef targeted_structure_acronym < nansen.metadata.abstract.TableVariable
%TARGETED_STRUCTURE_ACRONYM Definition for table variable
%   Detailed explanation goes here
%
%   See also nansen.metadata.abstract.TableVariable
    
    properties (Constant)
        IS_EDITABLE = false
        DEFAULT_VALUE = {'N/A'}
    end
    
    methods
        function obj = targeted_structure_acronym(varargin)
            obj@nansen.metadata.abstract.TableVariable(varargin{:});
        end 
    end
    
end