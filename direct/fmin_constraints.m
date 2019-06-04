% Function providing equality and inequality constraints
% ceq(var) = 0 and c(var) \le 0
function [c,ceq] = fmin_constraints(var)
    global N;
    global T;
    global u_max;
    global r_min;
    global x0;
    global mu;
    
    % load variables
    r1 = var(1:N); r2 = var(N+1:2*N); r3 = var(2*N+1:3*N); 
    v1 = var(3*N+1:4*N); v2 = var(4*N+1:5*N); v3 = var(5*N+1:6*N);
    u1 = var(6*N+1:7*N); u2 = var(7*N+1:8*N); u3 = var(8*N+1:9*N);

    % inequalitiy constraints
    c = [abs(u1)-u_max; abs(u2)-u_max; abs(u3)-u_max;
        r_min - vecnorm([r1,r2,r3]')'];
    
    % Computing dynamical constraints via the Hermite-Simpson rule
    dt = 1.0*T/(1.0*N);
    ceq = [];
    for i = 1:N-1
        % Evaluate 
        ri = [r1(i);r2(i);r3(i)];
        vi = [v1(i);v2(i);v3(i)] + [u1(i);u2(i);u3(i)];
        
        % propogate orbit
        [rf,vf] = twobody1(mu/1000^3,dt,ri/1000,vi/1000);
        x_prop = [rf*1000,vf*1000]'; 
        
        % constraint
        x_ii = [r1(i+1);r2(i+1);r3(i+1);v1(i+1);v2(i+1);v3(i+1)];
        ceq(6*(i-1)+1:6*i) = x_ii - x_prop;
    end

    % initial and final conditions
    x_init = [r1(1);r2(1);r3(1);v1(1);v2(1);v3(1)]; 
    ceq(6*(N-1)+1:6*N) = x_init-x0;
