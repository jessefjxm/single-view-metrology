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

% Print Vanishing Points Selected
fprintf("Vanishing Points\n");
for i=1:8
    fprintf("(%d,%d)\n",x(i),y(i));
end

% Calculate Vanishing points from selected points 
getVanishingPoints(x,y);
