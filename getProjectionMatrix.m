function P = getProjectionMatrix(origin,ref_points,ref_lengths,vanishing_points,VPx,VPy,VPz)
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
%Vx = vanishing_points(:,1); 
%Vy = vanishing_points(:,2);
%Vz = vanishing_points(:,3);

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

Ax = ((VPx - Rx) \ (Rx - Ov )) / RLenx;
Ay = ((VPy - Ry) \ (Ry - Ov )) / RLeny;
Az = ((VPz - Rz) \ (Rz - Ov )) / RLenz;

% Create Projection Matrix
P = [VPx*Ax, VPy*Ay, VPz*Az, Ov];
P = [P(:,1) -P(:,2) -P(:,3) P(:,4)]; 

fprintf('Projection Matrix\n');
disp(P);

end
