function XZero = shootingFunc(X,x0)

tf = X(1);
p1_0 = X(2:4);
p2_0 = X(5:7);

% Integrating the adjoint equations
options = odeset('AbsTol',1e-9,'RelTol',1e-9);
[t,z] = ode113(@(t,z) Zdyn(t,z), [0 tf], [x0;p1_0;p2_0], options);

zf = z(end,:)';
XZero = boundaryConditions(zf,tf);
