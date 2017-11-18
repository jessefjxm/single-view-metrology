function getVRMLModel()

end

function saveTextureChange(textureImageName, pos, coord, modelFileName)
% default file name
if nargin < 4
    modelFileName = 'model';
end

% create if not exist
fullFileName = strcat(modelFileName,'.wrl');
if ~exist(fullFileName, 'file')
    fid = fopen(fullFileName,'w');
    fprintf(fid,strcat('#VRML V2.0 utf8\nWorldInfo \{  title \"','Single-view Metrology of','\" \}'));
    fclose(fid);
end

% add new shape
fid = fopen(fullFileName,'a');
fprintf(fid, '\n Shape {\n  appearance Appearance {\n   texture ImageTexture {\n   url "');
fprintf(fid, textureImageName);
fprintf(fid, '"\n  }  \n  }\n   geometry IndexedFaceSet {\n   coord Coordinate {\n   point [\n');

num_coord = size(coord, 2);
for i = 1:num_coord
    cur = coord(i);
    fprintf(fid, '     %9.5f %9.5f %9.5f, \n', pos(1,cur),pos(2,cur),pos(3,cur));
end
fprintf(fid, '\n   ]\n   }\n   coordIndex [\n    ');
for i = 1:num_coord
    fprintf(fid, '%i,', i-1);
end
fprintf(fid, '%i,', -1);
fprintf(fid, '\n   ]\n   texCoord TextureCoordinate {\n    point [\n');
for i = 1:num_coord
    fprintf(fid, '     %3.2f %3.2f,\n', texCoor(1,i), texCoor(2,i));
end
fprintf(fid, '\n    ]\n   }\n   texCoordIndex [\n    ');
for i = 1:num_coord
    fprintf(fid, '%i,', i-1);
end
fprintf(fid, '%i,', -1);
fprintf(fid, '\n   ]\n   solid FALSE\n  }\n}');
fclose(fid);
end