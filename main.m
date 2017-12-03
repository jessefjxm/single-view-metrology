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
delete(h);
% Display Selected Points
scatter(x,y,'blue','fill');
% Add points to an array to calculate vanishing points
points = [];
for i=1:8
    points = [points;[x(i),y(i),1]];
end
% Calculate Vanishing Points
fprintf("Calculating Vanishing Points\n");
vanishing_points = getVanishingPoints(points);
disp(vanishing_points);




% #################################################
% Select 4 points that correspond to the same plane
% #################################################
h = msgbox('Select 4 Points that are on the same plane');
[x,y] = getpts(canvas.figure);
while size(x) ~= 4
    h = msgbox('Select 4 Points that are on the same plane');
    [x,y] = getpts(canvas.figure);
end
delete(h);
scatter(x,y,'red','fill');

% Force user to enter real world coordinates
coords = [];
pos= inputdlg('Enter Real World Coordinate for 1st point(x,y) - example 1,1 ');
coords = [coords; str2num(pos{:})];
pos = inputdlg('Enter Real World Coordinate for 2nd point(x,y) - example 1,50');
coords = [coords; str2num(pos{:})];
pos = inputdlg('Enter Real World Coordinate for 3rd point(x,y) - example 50,50');
coords = [coords; str2num(pos{:})];
pos = inputdlg('Enter Real World Coordinate for 4th point(x,y) - example 50,1');
coords = [coords; str2num(pos{:})];

fprintf("Coords Entered (x,y)\n");
disp(coords);

% ################################################################
% COMPUTE TRANSITION MATRIX FROM COORDS and X,Y Values on Plane
% ################################################################

H = getTransitionMatrix(x,y,coords);

% ###############################################################
% GET REFERENCE POINTS
% ###############################################################

h = msgbox('Select 1 reference point');
[x_r1,y_r1] = getpts(canvas.figure);
while size(x_r1) ~= 1
    h = msgbox('Select 1 reference point');
    [x_r1,y_r1] = getpts(canvas.figure);
end
delete(h);
scatter(x_r1,y_r1,'green','fill');

h = msgbox('Select a 2nd reference point and then input the height');
[x_r2,y_r2] = getpts(canvas.figure);
while size(x_r2) ~= 1
    h = msgbox('Select a 2nd reference point and then input the height');
    [x_r2,y_r2] = getpts(canvas.figure);
end
delete(h);
scatter(x_r2,y_r2,'green','fill');

% ################################
% GET Texture Maps
% ################################


