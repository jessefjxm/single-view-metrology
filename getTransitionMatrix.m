function H = getTransitionMatrix(x,y,real_world_coords)

% x , y: are the points selected the plane of the images
% real_world_coords: are the coordinates entered by the user

% Create Matrices

xy = [];
uv = [];
r = real_world_coords;

for i=1:4
    xy = [xy; r(i,1),r(i,2),0,1];
    uv = [uv; x(i),y(i),1];
end

fprintf("UV Matrix \n");
disp(uv);

fprintf("XY Matrix \n");
disp(xy);

H = 0;