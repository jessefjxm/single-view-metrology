function [Hxy,Hxz,Hyz,P] = getHomographyMatrices(refX,refY,refZ,refXlen,refYlen,refZlen,vX,vY,vZ,O)
fprintf('Origin\n');
disp(O);

fprintf('Ref Length X\n');
disp(refXlen);

fprintf('Ref Length Y\n');
disp(refYlen);

fprintf('Ref Length Z\n');
disp(refZlen);

fprintf('Reference Point X\n');
disp(refX);

fprintf('Reference Point Y\n');
disp(refY);

fprintf('Reference Point Z\n');
disp(refZ);

% scaling factor
a_x = ((vX - refX) \ (refX - O))/refXlen;
a_y = ((vY - refY) \ (refY - O))/refYlen;
a_z = ((vZ - refZ) \ (refZ - O))/refZlen;

fprintf('Scaling Result Ax \n');
disp(a_x);

fprintf('Scaling Result Ay\n');
disp(a_y);

fprintf('Scaling Result Az\n');
disp(a_y);

% Projection Matrix P
P = [vX * a_x, vY * a_y, vZ * a_z, O];
P = [P(:,1) -P(:,2) P(:,3) P(:,4)];

fprintf('Projection Matrix\n');
disp(P)

% Homography Matrix H
Hxy = [P(:,1),P(:,2),P(:,4)];
Hxz = [P(:,1),P(:,3),P(:,4)];
Hyz = [P(:,2),P(:,3),P(:,4)];
fprintf('Homography XY\n')
disp(Hxy)
fprintf('Homography XZ\n')
disp(Hxz)
fprintf('Homography YZ\n')
disp(Hyz)

end