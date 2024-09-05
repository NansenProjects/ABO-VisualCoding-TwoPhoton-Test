function varargout = viewFov(sessionObject, varargin)
%VIEWFOV Summary of this function goes here
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
    
    imageStack = nansen.stack.ImageStack(sessionObject.max_projection);
    imageStack.MetaData.SizeX = size(sessionObject.max_projection, 2);
    imageStack.MetaData.SizeY = size(sessionObject.max_projection, 1);
    imageStack.MetaData.PhysicalSizeX = 400/imageStack.MetaData.SizeX;
    imageStack.MetaData.PhysicalSizeY = 400/imageStack.MetaData.SizeY;

    % get factor from fov size?
    % sessionObject.nwb_metadata.fov

    h = imviewer(imageStack);
    h.showScalebar()

end


function S = getDefaultParameters()
    
    S = struct();
    % Add more fields:

end