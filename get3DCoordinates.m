function coord = get3DCoordinates(refc, P, origin, tform, plane)
[orinx, oriny] = transformPointsInverse(tform, origin(1,:), origin(2,:))
refc
refcoord = [refc(1)-orinx refc(2)-oriny refc(4) refc(4)];
coord = zeros(4,3);
switch plane
    case 'XY'
        coord(1,:) = [refcoord(1) refcoord(2) 1];
        coord(2,:) = [refcoord(1)+refcoord(3) refcoord(2) 1];
        coord(3,:) = [refcoord(1)+refcoord(3) refcoord(2)+refcoord(4) 1];
        coord(4,:) = [refcoord(1) refcoord(2)+refcoord(4) 1];
    case 'XZ'
        coord(1,:) = [refcoord(1) 1 refcoord(2)];
        coord(2,:) = [refcoord(1)+refcoord(3) 1 refcoord(2)];
        coord(3,:) = [refcoord(1)+refcoord(3) 1 refcoord(2)+refcoord(4)];
        coord(4,:) = [refcoord(1) 1 refcoord(2)+refcoord(4)];        
    case 'YZ'
        coord(1,:) = [1 refcoord(1) refcoord(2)];
        coord(2,:) = [1 refcoord(1)+refcoord(3) refcoord(2)];
        coord(3,:) = [1 refcoord(1)+refcoord(3) refcoord(2)+refcoord(4)];
        coord(4,:) = [1 refcoord(1) refcoord(2)+refcoord(4)];
end
coord
end