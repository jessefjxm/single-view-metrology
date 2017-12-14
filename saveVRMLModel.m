function saveVRMLModel(texture, coord, filepath)
dimension = 3;
% input texture name
textureName = inputdlg('Give this texture a name [without need suffix]:','Set Texture Name');
texturePath = sprintf('%s.png',textureName{1});
imwrite(texture, texturePath);

% create vrml file if not exist
[~,name,~] = fileparts(filepath);
fullFileName = strcat(name,'.wrl');
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
for i = 1:size(coord,1)
    fprintf(fid, '     %9.5f %9.5f %9.5f, \n', coord(i,1),coord(i,2),coord(i,3));
end
fprintf(fid, '\n   ]\n   }\n   coordIndex [\n    ');
for i = 1:dimension
    fprintf(fid, '%i,', i-1);
end
fprintf(fid, '%i,', -1);
fprintf(fid, '\n   ]\n   texCoord TextureCoordinate {\n    point [\n');
fprintf(fid, '     %3.2f %3.2f,\n', 0, 0);
fprintf(fid, '     %3.2f %3.2f,\n', 1, 0);
fprintf(fid, '     %3.2f %3.2f,\n', 1, 1);
fprintf(fid, '     %3.2f %3.2f,\n', 0, 1);
fprintf(fid, '\n    ]\n   }\n   texCoordIndex [\n    ');
for i = 1:dimension
    fprintf(fid, '%i,', i-1);
end
fprintf(fid, '%i,', -1);
% tail
fprintf(fid, '\n   ]\n   solid FALSE\n  }\n}');
fclose(fid);

msgbox('Texture saved!','Success');
end