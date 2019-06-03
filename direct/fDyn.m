%AA203 Project
% Dynamics function for satellite point mass in Earth orbit
function [Xdot] = fDyn(X,u)
    global mu;

    r = X(1:3);
    v = X(4:6);
    
    % dynamics
    rdot = v;
    vdot = -mu/norm(r)^3 * r + u;
    Xdot = [rdot;vdot];
end