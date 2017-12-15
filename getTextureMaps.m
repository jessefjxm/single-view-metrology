function I = getTextureMaps(invH, filepath, P, origin, plane)
im = imread(filepath);
% hint and crop
tform = projective2d(invH');
figure('Name','Cut Texture');
im1 = imwarp(im, tform);
[I,rect] = imcrop(im1);
close(gcf);
% get 3D real coordinate
coord = get3DCoordinates(rect, P, origin, tform, plane);
% save the cut texture
saveVRMLModel(I, coord, filepath, plane);
end