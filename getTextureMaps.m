function I2 = getTextureMaps(invH, im)
% hint and crop
tform = projective2d(invH');
B = imwarp(im, tform);
warning('off', 'Images:initSize:adjustingMag');
h = msgbox({'Now you need to select the texture area and cut it out.' ...
    'First select the texture region by moving the cursor,'...
    'Then do [Right Click -> Crop Image]'}, 'Cutting Image','help');
I2 = imcrop(B);

% save the cut texture
pos = [handles.ThreeDpos;1:size(handles.ThreeDpos,2)];
if ~exist('handles.imgName', 'var')
    saveTexture(I2, pos, 'model');
else
    saveTexture(I2, pos, handles.imgName);
end

end


function cutTexture_Callback(hObject, eventdata, handles)
handles = guidata(hObject);
str = get(hObject, 'String');
val = get(hObject,'Value');

if ~exist('handles.P', 'var')
    msgbox('You haven''t define reference planes yet!', 'Error','error');
else
    im = handles.g;
    switch str{val}
        case 'X-Y'
            invH = inv(handles.Hxy);
        case 'Y-Z'
            invH = inv(handles.Hyz);
        case 'X-Z'
            invH = inv(handles.Hxz);
    end
    getTextureMaps(invH, im);
    guidata(hObject, handles);
end

end