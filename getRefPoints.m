function [ref_xy,ref_uv] = getRefPoints(x1,y1,x2,y2,height,H)
ref_uv = [];
ref_xy = [];


a = H * [x1 y1 1]';
a = a ./ a(3);

ref_uv = [ref_uv;[x1 y1 1]];
ref_xy = [ref_xy;[a(1) a(2) 0 1]];

ref_uv = [ref_uv; [x2 y2 1]];
v = ref_xy;
v(3) = height;
ref_xy = [ref_xy; v];

end
