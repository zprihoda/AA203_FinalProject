function H = hamiltonianFunc(z)
    % Load Variables
    global g3 mu;
    r = z(1:3);
    v = z(4:6);
    p1 = z(7:9);
    p2 = z(10:12);
    u = getU(z);
    
    % Compute hamiltonian
    t1 = g3*sum(abs(u));
    t2 = dot(p1,v);
    t3 = dot(p2,u-mu*r/norm(r)^3);
    H = t1+t2+t3;