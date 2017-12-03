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

fprintf('UV Matrix \n');
disp(uv);

fprintf('XY Matrix \n');
disp(xy);

fprintf('Computing Transition Matrix from above matrices\n');

A = zeros(8,9);

for i= 1:4
    x = uv(i,1);
    y = uv(i,2);
    rx = xy(i,1);
    ry = xy(i,2);
    
    A(2*i-1,:) = [x, y, 1, 0, 0, 0, -rx*x, -rx*y, -rx];
    A(2*i, :) = [0, 0, 0, x, y, 1, -ry*x, -ry*y, -ry];
end

A = A' * A;
[~,~,d] = svd(A);

H = reshape(d(:,9), 3, 3)'

end