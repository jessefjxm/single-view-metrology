function I = getTextureMaps(invH, filepath)
[~,filename,~] = fileparts(filepath);
im = imread(filepath);
% hint and crop
tform = projective2d(invH');
figure('Name','Cut Texture');
[I,rect] = imcrop(imwarp(im, tform));
close(gcf);
% get 3D real coordinate
coord = zeroes(4,3);
coord(1) = [rect(1) rect(2) 1];
coord(2) = [rect(1)+rect(3) rect(2) 1];
coord(3) = [rect(1)+rect(3) rect(2)+rect(4) 1];
coord(4) = [rect(1) rect(2)+rect(4) 1];
% TODO: pos + Projection matrix = 3D pos
% save the cut texture
saveVRMLModel(I, coord, filepath);
end