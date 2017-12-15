function I = getTextureMaps(invH, filepath, P)
[~,filename,~] = fileparts(filepath);
im = imread(filepath);
% hint and crop
tform = projective2d(invH');
figure('Name','Cut Texture');
im1 = imwarp(im, tform);
[I,rect] = imcrop(im1);
close(gcf);
% get 3D real coordinate
coord = zeros(4,3);
coord(1,:) = [rect(1) rect(2) 1];
coord(2,:) = [rect(1)+rect(3) rect(2) 1];
coord(3,:) = [rect(1)+rect(3) rect(2)+rect(4) 1];
coord(4,:) = [rect(1) rect(2)+rect(4) 1];
% TODO: pos + Projection matrix = 3D pos
coord = get3DCoordinates(coord, P);
% save the cut texture
saveVRMLModel(I, coord, filepath);
end