function [x,y] = getVP(x,y)

    x1 = x(1);
    y1 = y(1);
    x2 = x(2);
    y2 = y(2);
    
    lines=zeros(3,3);
    lines(:, end+1) = real(cross([x1 y1 1]', [x2 y2 1]'));
    
    % compute vp (3x1 vector in homogeneous coordinates)    
    M = zeros(3,3);
    for i = 1: size(lines,2)
        M(1,1) = M(1,1)+lines(1,i)*lines(1,i);
        M(1,2) = M(1,2)+lines(1,i)*lines(2,i);
        M(1,3) = M(1,3)+lines(1,i)*lines(3,i);
        M(2,1) = M(2,1)+lines(1,i)*lines(2,i);
        M(2,2) = M(2,2)+lines(2,i)*lines(2,i);
        M(2,3) = M(2,3)+lines(2,i)*lines(3,i);
        M(3,1) = M(3,1)+lines(1,i)*lines(3,i);
        M(3,2) = M(3,2)+lines(2,i)*lines(3,i);
        M(3,3) = M(3,3)+lines(3,i)*lines(3,i); 
    end
    
    [vp,~] = eigs(M,1,'SM');
	x = vp(1)/vp(3);
	y = vp(2)/vp(3);
    
    
    
end