function XZero = boundaryConditions(z,tf)
    % load variables    
    global g1 g2 r_des w_E
    r = z(1:3);
    v = z(4:6);
    p1 = z(7:9);
    p2 = z(10:12);
    
    % determie desired position
    r_des_f = R3(tf)*r_des;
     
    % obtain boundary conditions
    bc1 = g2*r/norm(r-r_des_f) - p1;
    bc2 = -p2;
    
    tmp = sum((r-r_des_f).*(R3dot(tf)*r_des))/norm(r-r_des_f);
    bc3 = dot(p1,v) + g1 - g2*w_E*tmp;
    
    % form output array
    XZero = [bc1;bc2;bc3];
end

function Rdot = R3dot(tf)
    global w_E;
    theta = w_E*tf;
    
    Rdot = w_E * [-sin(theta), cos(theta), 0;
                  -cos(theta),-sin(theta), 0;
                            0,          0, 0];
end