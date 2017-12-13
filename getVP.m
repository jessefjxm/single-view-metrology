function [Vpx,Vpy,Vpz] = getVP(vanishing_points)
    % Compute X Parrelel Line VP's (3x1 vector in homogeneous coordinates) 
    x1 = vanishing_points(1,1);
    y1 = vanishing_points(1,2);
    x2 = vanishing_points(2,1);
    y2 = vanishing_points(2,2);
    x3 = vanishing_points(3,1);
    y3 = vanishing_points(3,2);
    x4 = vanishing_points(4,1);
    y4 = vanishing_points(4,2);
    
    lines=zeros(3,0);
    lines(:,1) = real(cross([x1 y1 1]', [x2 y2 1]'));
    lines(:,2) = real(cross([x3 y3 1]', [x4 y4 1]'));
       
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
    Vpx = [x; y; 1];
    
    % Compute Y Parrelel Line VP's (3x1 vector in homogeneous coordinates) 
    x1 = vanishing_points(5,1);
    y1 = vanishing_points(5,2);
    x2 = vanishing_points(6,1);
    y2 = vanishing_points(6,2);
    x3 = vanishing_points(7,1);
    y3 = vanishing_points(7,2);
    x4 = vanishing_points(8,1);
    y4 = vanishing_points(8,2);
    
    lines=zeros(3,0);
    lines(:,1) = real(cross([x1 y1 1]', [x2 y2 1]'));
    lines(:,2) = real(cross([x3 y3 1]', [x4 y4 1]'));
    
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
    Vpy = [x; y; 1];
    
    
    
     % Compute Z Parrelel Line VP's (3x1 vector in homogeneous coordinates) 
    x1 = vanishing_points(9,1);
    y1 = vanishing_points(9,2);
    x2 = vanishing_points(10,1);
    y2 = vanishing_points(10,2);
    x3 = vanishing_points(11,1);
    y3 = vanishing_points(11,2);
    x4 = vanishing_points(12,1);
    y4 = vanishing_points(12,2);
    
    lines=zeros(3,0);
    lines(:,1) = real(cross([x1 y1 1]', [x2 y2 1]'));
    lines(:,2) = real(cross([x3 y3 1]', [x4 y4 1]'));
    
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
    Vpz = [x; y; 1];
    
end