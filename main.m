close all;
clc;

% Prompt user to select file to perform single view metrology on
filename = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'Select File to perform Single View Metrology on...');

% Force image to display in canvas and stay open
canvas.figure = figure;
imshow(filename);
hold on;

% ######################################################
% Get Vanishing Points - Must Select Vanishing Points
% ######################################################
h = msgbox('Select 8 Points to calculate vanishing points from - on the last point double click');
hold on;
[x,y] = getpts(canvas.figure); % This allows user to click points.
while size(x) ~= 8
    h = msgbox('You MUST select 8 points - on the last point double click');
    hold on;
    [x,y] = getpts(canvas.figure);
end

fprintf(" Adding selected points to a single array\n\n");
points = [];
for i=1:8
    points = [points;[x(i),y(i),1]];
end

% Calculate Vanishing Points
fprintf("Calculating Vanishing Points\n");
vanishing_points = getVanishingPoints(points);
s = size(vanishing_points);
fprintf("Size of Vanishing Point Structure after call calculations- %dx%d\n",s(1),s(2));

% ####################
% Get Origin
% ####################
h = msgbox('Select Origin Point - double click the point on the image');
[x,y] = getpts(canvas.figure);
while(size(x) ~= 1)
    h = msgbox('You MUST select ONE origin point point - double click the point on the image');
    [x,y] = getpts(canvas.figure);
end
fprintf('Origin = %dx%d\n',x,y);

% ##############################
% Select Points for Plane 1
% ##############################
h = msgbox('Select Plane 1 points - This should be 4 points - double click on the 4th');
[x,y] = getpts(canvas.figure);
while size(x) ~= 4
    h = msgbox('Select Plane 1 points - This should be 4 points - double click on the 4th');
    [x,y] = getpts(canvas.figure);
end
% Force user to enter actual dimension for coordinates just selected
coords_plane1 = [];
coords_plane1 = [coords_plane1; inputdlg('Enter position for x1 - example 0')];
coords_plane1 = [coords_plane1; inputdlg('Enter position for y1 - example 0')];
coords_plane1 = [coords_plane1; inputdlg('Enter position for x2 - example 50')];
coords_plane1 = [coords_plane1; inputdlg('Enter position for y2 - example 50')];
fprintf("Coords Entered for Plane 1\n");
disp(coords_plane1);

% COMPUTE TRANSITION MATRIX

% SELECT TEXTURE PLANE



% #############################
% Select Points for Plane 2
% #############################
h = msgbox('Select Plane 2 points - This should be 4 points - double click on the 4th');
[x,y] = getpts(canvas.figure);
while size(x) ~= 4
    h = msgbox('Select Plane 2 points - This should be 4 points - double click on the 4th');
    [x,y] = getpts(canvas.figure);
end

% Force user to enter actual dimension for coordinates just selected
coords_plane2 = [];
coords_plane2 = [coords_plane2; inputdlg('Enter position for x1 - example 0')];
coords_plane2 = [coords_plane2; inputdlg('Enter position for y1 - example 0')];
coords_plane2 = [coords_plane2; inputdlg('Enter position for x2 - example 50')];
coords_plane2 = [coords_plane2; inputdlg('Enter position for y2 - example 50')];
fprintf("Coords Entered for Plane 2\n");
disp(coords_plane2);

% COMPUTE TRANSITION MATRIX

% SELECT TEXTURE PLANE


% ###############################
% Select Points for Plane 3
% ###############################
h = msgbox('Select Plane 3 points - This should be 4 points - double click on the 4th');
[x,y] = getpts(canvas.figure);
while size(x) ~= 4
    h = msgbox('Select Plane 3 points - This should be 4 points - double click on the 4th');
    [x,y] = getpts(canvas.figure);
end

% Force user to enter actual dimension for coordinates just selected
coords_plane3 = [];
coords_plane3 = [coords_plane3; inputdlg('Enter position for x1 - example 0')];
coords_plane3 = [coords_plane3; inputdlg('Enter position for y1 - example 0')];
coords_plane3 = [coords_plane3; inputdlg('Enter position for x2 - example 50')];
coords_plane3 = [coords_plane3; inputdlg('Enter position for y2 - example 50')];
fprintf("Coords Entered for Plane 3\n");
disp(coords_plane3);

% COMPUTE TRANSITION MATRIX

% SELECT TEXTURE PLANE

% ################################
% Compute Texture MAps
% ################################


