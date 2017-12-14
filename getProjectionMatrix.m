function P = getProjectionMatrix(origin,ref_points,ref_lengths,VPx,VPy,VPz)
fprintf('Calculating Projection Matrix based on the following...\n');

fprintf('Origin\n')
disp(origin);

fprintf('Reference Points\n')
disp(ref_points);

fprintf('Reference Lengths\n');
disp(ref_lengths);

fprintf('Vanishing Points\n');
%disp(vanishing_points);

% #########################################################
% Scaling Factor Step - Is this actually necessary though?
% #########################################################

% Setup vanishing point matrix into x, y, z, vectors
%Vx = vanishing_points(:,1);
%Vy = vanishing_points(:,2);
%Vz = vanishing_points(:,3);

% Setup reference point Matrix into x, y, z, vectors
Rx = ref_points(1,:);
Rx = Rx(:);

Ry = ref_points(2,:);
Ry = Ry(:);

Rz = ref_points(3,:);
Rz = Rz(:);

% Setup Origin matrix into x,y,z vector
Ov = origin(:);

% Setup Length Variables
RLenx = ref_lengths(1);
fprintf("Ref Len X\n");
disp(RLenx);

RLeny = ref_lengths(2);
fprintf("Ref Len Y\n");
disp(RLeny);

RLenz = ref_lengths(3);
fprintf("Ref Len Z\n");
disp(RLenz);

fprintf("Reference Point X\n");
disp(Rx);

fprintf("Reference Point Y\n");
disp(Ry);

fprintf("Reference Point Z\n");
disp(Rz);

%Scaling
Ax = ((VPx - Rx) \ (Rx - origin))/RLenx;
fprintf("Scaling Ax\n");
disp(Ax);

Ay = ((VPy - Ry) \ (Ry - origin))/RLeny;
fprintf("Scaling Ay\n");
disp(Ay);

Az = ((VPz - Rz) \ (Rz - origin))/RLenz;
fprintf("Scaling Az\n");
disp(Az);

% Create Projection Matrix
%P = [VPx*Ax, VPy*Ay, VPz*Az, Ov];
P = [VPx, VPy, VPz, Ov];
P = [P(:,1) -P(:,2) -P(:,3) P(:,4)]; 

fprintf('Projection Matrix\n');
disp(P);

end
