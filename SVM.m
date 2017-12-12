function varargout = SVM(varargin)
clc;
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
handles.filepath = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },'Select File to perform Single View Metrology on...');
% update image
axes(handles.image)
handles.im = image(imread(handles.filepath));
axis image;
hold all;
set(handles.im,'buttondownfcn',{@image_ButtonDownFcn,handles});
guidata(hObject, handles);
set(handles.showModel,'Enable','on') ;
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
function image_ButtonDownFcn(hObject, eventdata, handles)
global vpoints;
global plots;
global lines;
global reflength;
global vanishing_points;
if(size(vpoints,1) > 8+1+3)
    return
end
% pick points
x1 = eventdata.IntersectionPoint(1);
y1 = eventdata.IntersectionPoint(2);
vpoints = [vpoints;x1,y1,1];

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
    % Select oringin point
    % #################################################
    plots = [plots;plot(x1,y1,'.','color','red','LineWidth',2)];
    textUpdate(4);
elseif (size(vpoints,1) <= 8+1+3)
    % #################################################
    % Set reference point and length
    % #################################################
    plots = [plots;plot(x1,y1,'*','color','yellow')];
    textUpdate(4);
    % draw line
    vsize = size(vpoints,1);
    lines = [lines;plot([vpoints(9,1) vpoints(vsize,1)],[vpoints(9,2) vpoints(vsize,2)],'LineWidth',2,'color','yellow')] ;
    % get length
    len = inputdlg('Enter length of this reference line - example 50',...
        'Set Reference Length',1,{'50'});
    reflength = [reflength str2num(len{:})];
    if(size(vpoints,1) == 8 + 1 + 3)
        % #################################################
        % Calculation projection & Homography matrix
        % #################################################
        set(handles.xyplane,'Enable','on') ;
        set(handles.xzplane,'Enable','on') ;
        set(handles.yzplane,'Enable','on') ;
        % Pull out origin from vpoints structure
        origin = [];
        origin = [origin; [vpoints(9,1) vpoints(9,2) 1]];
        % Pull out reference points from vpoints structure
        ref_points = [];
        for i=10:12
            % Build x y z matrix
            ref_points = [ref_points; [vpoints(i,1) vpoints(i,2) 1]];
        end
        % Create Projection Matrix
        handles.projection_matrix = getProjectionMatrix(origin,ref_points,reflength,vanishing_points);
        [handles.HomXY,handles.HomXZ,handles.HomYZ] = getHomographyMatrices(handles.projection_matrix);
        guidata(hObject, handles);
        % update hint
        textUpdate(5);
    end
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
        set(gh.hint, 'String', sprintf('%s\n%s\n%s',...
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
        set(gh.hint, 'String', sprintf('%s\n%s\n%s\n%s',...
            'Now we need to select 1 oringin point at real coordinate.',...
            'Click on the image to set one point.',...
            'Note : we suggest pick one corner point as the oringin of axis.'));
    case 4
        set(gh.status, 'String', sprintf('%s%d%s','3. Set Reference Points [',size(vpoints,1)-8-1,'/3]'));
        set(gh.status, 'ForegroundColor', [0.5 0.25 0.5]);
        set(gh.hint, 'String', sprintf('%s\n%s\n%s',...
            'Now we need to set reference points to get real length info of the scenario.',...
            'Select 3 reference points for each axis (x,y,z), then input the length of each line.',...
            'Axis order: X->Y->Z.'));
    case 5
        set(gh.status, 'String', sprintf('%s','4. Cut Texture'));
        set(gh.status, 'ForegroundColor', [0.5 0.5 0.5]);
        set(gh.hint, 'String', sprintf('%s\n%s\n%s\n\n%s\n%s',...
            'Now you need to select the texture area and cut it out.',...
            'Click 3 Plane buttons shown above [X-Y, X-Z, Y-Z] to work on one of the transformed plane.',...
            'In each plane, you need to first select the texture region by moving the cursor, then do [Right Click -> Crop Image]'),...
            'After all textures were cut, you can click Show Model button to take a view.');
    otherwise
        set(gh.status, 'String', 'Waiting for an Image');
        set(gh.status, 'ForegroundColor', [1 0 0]);
        set(gh.hint, 'String', sprintf('%s\n%s',...
            'Every things start with loading a image.',...
            'Please press the ''Load Image'' button.'));
end
end

% --- Executes on button press in xyplane.
function xyplane_Callback(hObject, eventdata, handles)
I = getTextureMaps(handles.HomXY, handles.filepath);
end

% --- Executes on button press in xzplane.
function xzplane_Callback(hObject, eventdata, handles)
I = getTextureMaps(handles.HomXZ, handles.filepath);
end

% --- Executes on button press in yzplane.
function yzplane_Callback(hObject, eventdata, handles)
I = getTextureMaps(handles.HomYZ, handles.filepath);
end

% --- Executes on button press in showModel.
function showModel_Callback(hObject, eventdata, handles)
[path,name,~] = fileparts(handles.filepath);
fullFileName = strcat(path,'\',name,'.wrl');
if ~exist(fullFileName, 'file')
    msgbox({'Model haven''t been created!'}, 'Error','warn');
else
    uiopen(fullFileName,1);
end
end
