classdef fail_eye_tracking < nansen.metadata.abstract.TableVariable
%FAIL_EYE_TRACKING Definition for table variable
%   Detailed explanation goes here
%
%   See also nansen.metadata.abstract.TableVariable
    
    properties (Constant)
        IS_EDITABLE = false
        DEFAULT_VALUE = false
    end
    
    methods
        function obj = fail_eye_tracking(varargin)
            obj@nansen.metadata.abstract.TableVariable(varargin{:});
        end 
    end
    
end