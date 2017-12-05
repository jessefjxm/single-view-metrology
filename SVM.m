function varargout = SVM(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @SVM_OpeningFcn, ...
    'gui_OutputFcn',  @SVM_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
end

% --- Executes just before SVM is made visible.
function SVM_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for SVM
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% load default image
axes(handles.image)
matlabImage = imread('noimage.png');
image(matlabImage)
axis off
axis image;

global gh;
gh = handles;
end

% --- Outputs from this function are returned to the command line.
function varargout = SVM_OutputFcn(hObject, eventdata, handles)
% Get default command line output from handles structure
varargout{1} = handles.output;
end

% --- Executes on button press in loadImage.
function loadImage_Callback(hObject, eventdata, handles)
% get file
filename = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },'Select File to perform Single View Metrology on...');
% update image
axes(handles.image)
handles.im = image(imread(filename));
axis image;
hold all;
%handles.im.ButtonDownFcn = @image_ButtonDownFcn;
set(handles.im,'buttondownfcn',@image_ButtonDownFcn);
guidata(hObject, handles);
% init variables
global vpoints;
global plots;
global lines;
global reflength;
delete(plots(:));
delete(lines(:));
vpoints = [];
plots = [];
lines = [];
reflength = [];
% update text
textUpdate(0);
pause(1);
textUpdate(1);
end

% --- Executes on button press in showModel.
function image_ButtonDownFcn(hObject, eventdata)
global vpoints;
global plots;
global lines;
global reflength;
% draw point
if(size(vpoints,1) <= 8+4+2)
    % pick points
    x1 = eventdata.IntersectionPoint(1);
    y1 = eventdata.IntersectionPoint(2);
    vpoints = [vpoints;x1,y1,1];
end
% state machine
if(size(vpoints,1) <= 8)
    % ######################################################
    % Get Vanishing Points - Must Select Vanishing Points
    % ######################################################
    plots = [plots;plot(x1,y1,'*','color','b')];
    textUpdate(1);
    % draw lines
    vsize = size(vpoints,1);
    if(mod(vsize,2)==0)
        lines = [lines;plot(vpoints(vsize-1:vsize,1),vpoints(vsize-1:vsize,2),'--','LineWidth',1.5,'color','b')] ;
    end
    if (size(vpoints,1) == 8)
        textUpdate(2);
        % Calculate Vanishing Points
        delete(plots(:));
        vanishing_points = getVanishingPoints(vpoints);
        disp(vanishing_points);
        pause(1);
        textUpdate(3);
    end
elseif (size(vpoints,1) <= 8+1)
    % #################################################
    % Select oringinal planes
    % #################################################
    plots = [plots;plot(x1,y1,'.','color','red','LineWidth',2)];
    textUpdate(4);
elseif (size(vpoints,1) <= 8+1+3)
    plots = [plots;plot(x1,y1,'*','color','yellow')];
    textUpdate(4);
    % draw line
    vsize = size(vpoints,1);
    lines = [lines;plot([vpoints(9,1) vpoints(vsize,1)],[vpoints(9,2) vpoints(vsize,2)],'LineWidth',2,'color','yellow')] ;
    % get length
    len = inputdlg('Enter length of this reference line - example 50',...
        'Set Reference Length',1,{'50'});
    reflength = [reflength str2num(len{:})];
end
end

% -- state machine of text update
function textUpdate(status)
global gh;
global vpoints;
switch status
    case 0
        set(gh.status, 'String', 'Ready to Start');
        set(gh.status, 'ForegroundColor', [0 0.5 0]);
        set(gh.hint, 'String', sprintf('%s', 'Image loaded.'));
    case 1
        set(gh.status, 'String', sprintf('%s%d%s','1. Pick Vanish Points [',size(vpoints,1),'/8]'));
        set(gh.status, 'ForegroundColor', [0 0.5 0.75]);
        set(gh.hint, 'String', sprintf('%s\n\n%s\n\n%s',...
            'Click on the image to set a vanishing points.',...
            'Two points will form one vanishing line.',...
            'Please click 8 points to form 4 parrallel lines as cuboid edges.'));
    case 2
        set(gh.status, 'String', sprintf('%s','Calculating Vanishing Points'));
        set(gh.status, 'ForegroundColor', [0 0.5 0.5]);
        set(gh.hint, 'String', sprintf('%s',...
            'Calculating...Please wait.'));
    case 3
        set(gh.status, 'String', sprintf('%s%d%s','2. Pick Oringin Point [',size(vpoints,1)-8,'/1]'));
        set(gh.status, 'ForegroundColor', [0 0.25 0.5]);
        set(gh.hint, 'String', sprintf('%s\n\n%s\n\n%s\n\n%s',...
            'Now we need to select 1 oringin point at real coordinate.',...
            'Click on the image to set one point.',...
            'Note : we suggest pick one corner point as the oringin of axis.'));
    case 4
        set(gh.status, 'String', sprintf('%s%d%s','3. Set Reference Points [',size(vpoints,1)-8-1,'/3]'));
        set(gh.status, 'ForegroundColor', [0.5 0.25 0.5]);
        set(gh.hint, 'String', sprintf('%s\n\n%s\n\n%s',...
            'Now we need to set reference points to get real length info of the scenario.',...
            'Select 3 reference points for each axis (x,y,z), then input the length of each line.',...
            'Axis order: X->Y->Z.'));
    otherwise
        set(gh.status, 'String', 'Waiting for an Image');
        set(gh.status, 'ForegroundColor', [1 0 0]);
        set(gh.hint, 'String', sprintf('%s\n\n%s',...
            'Every things start with loading a image.',...
            'Please press the ''Load Image'' button.'));
end
end

% --- Executes on button press in xyplane.
function xyplane_Callback(hObject, eventdata, handles)
end

% --- Executes on button press in xzplane.
function xzplane_Callback(hObject, eventdata, handles)
end

% --- Executes on button press in yzplane.
function yzplane_Callback(hObject, eventdata, handles)
end
    
% --- Executes on button press in showModel.
function showModel_Callback(hObject, eventdata, handles)
end