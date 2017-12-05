function I2 = getTextureMaps(invH, im, filename)
% hint and crop
tform = projective2d(invH');
B = imwarp(im, tform);
h = msgbox({'Now you need to select the texture area and cut it out.' ...
    'First select the texture region by moving the cursor,'...
    'Then do [Right Click -> Crop Image]'}, 'Cut Texture','help');
I2 = imcrop(B);
% save the cut texture
pos = [handles.ThreeDpos;1:size(handles.ThreeDpos,2)];
saveTexture(I2, pos, filename);
end