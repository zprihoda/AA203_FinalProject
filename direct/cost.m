% Cost of the problem
function c = cost(var)
global N;
global g1; 
global g2;
global g3;
global r_des0;
global w_E;


% Note that var = [y;v;m;u]
r1 = var(1:N); r2 = var(N+1:2*N); r3 = var(2*N+1:3*N); 
v1 = var(3*N+1:4*N); v2 = var(4*N+1:5*N); v3 = var(5*N+1:6*N);
u1 = var(6*N+1:7*N); u2 = var(7*N+1:8*N); u3 = var(8*N+1:9*N);
T = var(end);

U = [u1;u2;u3];
rf = [r1(end); r2(end); r3(end)];

r_des = R3(-w_E*T)*r_des0;

% Put here the cost
c = g1*T + g2*norm(rf - r_des) + g3*sum(abs(U));