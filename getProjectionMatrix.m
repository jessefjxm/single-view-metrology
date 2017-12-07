function P = getProjectionMatrix(origin,ref_points,ref_lengths,vanishing_points)
fprintf('Calculating Projection Matrix based on the following...\n');
    

fprintf('Origin\n')
disp(origin);

fprintf('Reference Points\n')
disp(ref_points);

fprintf('Reference Lengths\n');
disp(ref_lengths);

fprintf('Vanishing Points\n');
disp(vanishing_points);

% #########################################################
% Scaling Factor Step - Is this actually necessary though?
% #########################################################

% Setup vanishing point matrix into x, y, z, vectors
Vx = vanishing_points(:,1); 
Vy = vanishing_points(:,2);
Vz = vanishing_points(:,3);

% Setup reference point Matrix into x, y, z, vectors
Rx = ref_points(:,1);
Ry = ref_points(:,2);
Rz = ref_points(:,3);

% Setup Origin matrix into x,y,z vector
Ov = origin(:);

% Setup Length Variables
RLenx = ref_lengths(1);
RLeny = ref_lengths(2);
RLenz = ref_lengths(3);

Ax = ((Vx - Rx) \ (Rx - Ov )) / RLenx;
Ay = ((Vy - Ry) \ (Ry - Ov )) / RLeny;
Az = ((Vz - Rz) \ (Rz - Ov )) / RLenz;

% Create Projection Matrix
P = [Vx*Ax, Vy*Ay, Vz*Az, Ov];
P = [P(:,1) -P(:,2) -P(:,3) P(:,4)]; 

fprintf('Projection Matrix\n');
disp(P);

end
