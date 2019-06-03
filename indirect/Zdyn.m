% Dynamics of the problem
function zdot = Zdyn(t,z)
    global mu;
    r = z(1:3);
    v = z(4:6);
    p1 = z(7:9);
    p2 = z(10:12);
    u = getU(z);
    
    % dynamics
    rdot = v;
    vdot = -mu/norm(r)^3 * r + u;
    xdot = [rdot;vdot];
    
    % costate equation
    p1dot = p2*mu/norm(r)^3 - 3*mu*r/norm(r)^5 * dot(p2,r);
    p2dot = -p1;
    pdot = [p1dot;p2dot];
    
    % Combine
    zdot = [xdot;pdot];
    