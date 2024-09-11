classdef experiment_container < nansen.metadata.abstract.TableVariable
%EXPERIMENT_CONTAINER Definition for table variable
%   Detailed explanation goes here
%
%   See also nansen.metadata.abstract.TableVariable
    
    properties (Constant)
        IS_EDITABLE = false
        DEFAULT_VALUE = 'struct.empty'
    end
    
    methods
        function obj = experiment_container(varargin)
            obj@nansen.metadata.abstract.TableVariable(varargin{:});
        end 
    end
    
end