% Cleanup
clear all; clc; close all;

% global variables
global mu; mu = 3.9915e14;
global r_E; r_E = 6378145;
global w_E; w_E = 7.2921159e-5; % rad/s
global g1; g1 = 1;
global g2; g2 = 1;
global g3; g3 = 1;
global u_max; u_max = 1;
global r_min; r_min = r_E+400e3;

global tbcoef; tbcoef = 1;

global r_des0;
global x0
global N; 

% Scenario
N = 10; % number of discretization points

r0 = [r_E+408e3;0;0];     % orbit at iss altitude
v0 = [0;sqrt(mu/r0(1));0];  % circular polar orbit
x0 = [r0;v0];
r_des0 = [0;6712e3;1000e3];

% stanford coordinates
% des_gc = deg2rad([37,-122]);
% r_des0 = gc2ECEF(des_gc(1),des_gc(2))*(r_E+408e3);
% r_des = rotz(w_E*T/pi*180)*r_des0;

% Guess Trajectory
t_guess = 25*60;
var_init = [guessTraj(r0,r_des0,t_guess);t_guess];

% define search bounds
v_max = 12e3;
lb = [-(1.5*r_E)*ones(3*N,1); -v_max*ones(3*N,1);-u_max*ones(3*N,1);0];
ub = [(1.5*r_E)*ones(3*N,1); v_max*ones(3*N,1); u_max*ones(3*N,1);10*3600];

options=optimoptions('fmincon','Display','iter','Algorithm','sqp','MaxFunctionEvaluations',100000,'MaxIterations',1000);
[var,Fval,convergence] = fmincon(@cost,var_init,[],[],[],[],lb,ub,@fmin_constraints,options); % Solving the problem
convergence % = 1, good
