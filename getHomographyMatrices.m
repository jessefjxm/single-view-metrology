function [homxy,homxz,homyz] = getHomographyMatrices(p)

homxy = [p(:,1),p(:,2),p(:,4)];
homxz = [p(:,1),p(:,3),p(:,4)];
homyz = [p(:,2),p(:,3),p(:,4)];

fprintf('Homography Matrix xy\n');
disp(homxy);

fprintf('Homography Matrix xz\n');
disp(homxz);

fprintf('Homography Matrix yz\n');
disp(homyz);

end