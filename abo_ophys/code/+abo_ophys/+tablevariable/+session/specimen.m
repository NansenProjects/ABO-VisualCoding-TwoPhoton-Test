classdef specimen < nansen.metadata.abstract.TableVariable
%SPECIMEN Definition for table variable
%   Detailed explanation goes here
%
%   See also nansen.metadata.abstract.TableVariable
    
    properties (Constant)
        IS_EDITABLE = false
        DEFAULT_VALUE = 'struct.empty'
    end
    
    methods
        function obj = specimen(varargin)
            obj@nansen.metadata.abstract.TableVariable(varargin{:});
        end 
    end
    
end