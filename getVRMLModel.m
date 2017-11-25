function getVRMLModel(modelPath)
uiopen(modelPath,1);
end

function saveTexture(texture, pos, imgName)
% input texture coord
valstring = input({'Please type the coordinates of this texture in the model.'...
    '[Form] x,y,z [e.g.] 100,50,200'}, 's');
valparts = regexp(valstring, '[ ,]', 'split');
coord = str2double(valparts);
coordSize = size(coord, 2);
% input texture name
textureName = input({'Give this texture a name:'...
    '[Note] No need to input the file format suffix'}, 's');
texturePath = strcat(textureName,'.jpg');
imwrite(texture, texturePath);

% create if not exist
fullFileName = strcat(imgName,'.wrl');
if ~exist(fullFileName, 'file')
    fid = fopen(fullFileName,'w');
    fprintf(fid,strcat('#VRML V2.0 utf8\nWorldInfo \{  title \"','Single-view Metrology of','\" \}'));
    fclose(fid);
end

% header
fid = fopen(fullFileName,'a');
fprintf(fid, '\n Shape {\n  appearance Appearance {\n   texture ImageTexture {\n   url "');
fprintf(fid, texturePath);
fprintf(fid, '"\n  }  \n  }\n   geometry IndexedFaceSet {\n   coord Coordinate {\n   point [\n');
% add new shape
for i = 1:coordSize
    cur = coord(i);
    fprintf(fid, '     %9.5f %9.5f %9.5f, \n', pos(1,cur),pos(2,cur),pos(3,cur));
end
fprintf(fid, '\n   ]\n   }\n   coordIndex [\n    ');
for i = 1:coordSize
    fprintf(fid, '%i,', i-1);
end
fprintf(fid, '%i,', -1);
fprintf(fid, '\n   ]\n   texCoord TextureCoordinate {\n    point [\n');
for i = 1:coordSize
    fprintf(fid, '     %3.2f %3.2f,\n', texCoor(1,i), texCoor(2,i));
end
fprintf(fid, '\n    ]\n   }\n   texCoordIndex [\n    ');
for i = 1:coordSize
    fprintf(fid, '%i,', i-1);
end
fprintf(fid, '%i,', -1);
% tail
fprintf(fid, '\n   ]\n   solid FALSE\n  }\n}');
fclose(fid);

% response to user
h = msgbox('VRML Model Saved','Success');
end