clear all;

% Prompt user to select file to perform single view metrology on
filename = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'Select File to perform Single View Metrology on...');

% Force image to display in canvas and stay open
canvas.figure = figure;
imshow(filename);
hold on;

% Get Vanishing Points - Must Select Vanishing Points
h = msgbox('Select 8 Points to calculate vanishing points from - on the last point double click');
hold on;
[x,y] = getpts(canvas.figure);
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


% Set Origin

