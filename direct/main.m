% Cleanup
clear; clc; close all;

% global variables
global N; N = 500; % Choose here the number of discretization points
global mu; mu = 3.9915e14;
global r_E; r_E = 6378145;
global w_E; w_E = 7.2921159e-5; % rad/s
global g1; g1 = 1;
global g2; g2 = 1;
global g3; g3 = 1;
global u_max; u_max = 1;
global r_min; r_min = r_E+400e3;

global r_des;
global x0
global T;

% Scenario
T = 3600;

r0 = [r_E+408e3;0;0];     % orbit at iss altitude
v0 = [0;sqrt(mu/r0(1));0];  % circular polar orbit
x0 = [r0;v0];
r_des0 = [0;r_E+408e3;0];
r_des = R3(w_E*T)*r_des0;

% Guess Trajectory
var_init = guessTraj(r0,r_des);

% define search bounds
v_max = 12e3;
lb = [zeros(3*N,1); -v_max*ones(3*N,1);-u_max*ones(3*N,1)];
ub = [(1.5*r_E)*ones(3*N,1); v_max*ones(3*N,1); u_max*ones(3*N,1)];

options=optimoptions('fmincon','Display','iter','Algorithm','sqp','MaxFunctionEvaluations',100000,'MaxIterations',100000);
[var,Fval,convergence] = fmincon(@cost,var_init,[],[],[],[],lb,ub,@fmin_constraints,options); % Solving the problem
convergence % = 1, good
