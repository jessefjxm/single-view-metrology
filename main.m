% Prompt user to select file to perform single view metrology on
filename = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'Select File to perform Single View Metrology on...');

% Force image to display in canvas and stay open
canvas.figure = figure;
imshow(filename);
hold on;

% Prompt Message Box for User to Select Vanishing Points

vanishing_points = 0;
vanishing.pt = [];

% @param type: Used to for user through selection of various points
% 0 = Capture vanishing points
% 1 = Capture Origin
% 2 = Capture Plane 1 - Compute Transform Matrix
% 3 = Capture Plane 1 T - Use Transform Matrix + Points to get Plane
% 4 = Capture Plane 2
% 5 = Capture Plane 2 T - Use Transform Matrix + Points to get Plane
% 6 = Capture Plane 3
% 7 = Capture Plane 3 T - Use Transform Martrix + Points to get Plane

capture_input(0);

function capture_input(type)
    
    if type == 0
        h0 = msgbox('Select 8 Vanishing Points');
   
        
        % Number of Points selected = 8 set type to 1 and call
        % capture_input
        type = 1;
        capture_input(type);
    elseif type == 1
        h1 = msgbox('Select the origin');
        type = 2
        capture_input(type);
    elseif type == 2
        h2 = msgbox('Select 4 Points for Plane 1');
        type = 3;
        capture_input(type);
    elseif type == 3
        h = msgbox('Select 4 Points for Plane 1 again');
        type = 4;
        capture_input(type);
    elseif type == 4
        h = msgbox('Select 4 Points for Plane 2');
        type = 5;
        capture_input(type);
    elseif type == 5
        h = msgbox('Select 4 Points for Plane 2 again');
        type = 6;
        capture_input(type);
    elseif type == 6
        h = msgbox('Select 4 Points for Plane 3');
        type = 7;
        capture_input(type);
    elseif type == 7
        h = msgbox("Select 4 Points for Plane 3 again")
        %capture_input(canvas.figure);
        % Done
    end
   
        

end

