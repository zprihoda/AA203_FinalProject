% AA203 Final Project
% Indirect Main

%% Clean up
clear; clc; close all;

%% Global Parameters
global mu; mu = 3.986e14;   % m^3*s^-2
global u_max; u_max = 10.0;    % m/s^2
global w_E; w_E = 7.2921159e-5; % rad/s
global g1; g1 = 1;
global g2; g2 = 1;
global g3; g3 = 1;

%% Other usedul parameters
R_E = 6371e3;

%% Scenario:
r0 = [R_E+408e3;0;0];     % orbit at iss altitude
v0 = [0;sqrt(mu/r0(1));0];  % circular polar orbit
x0 = [r0;v0];

global r_des;
r_des = [0;4.5776e6;5000e3];

%% Initial guess for z=[tf,p1(0),p2(0)]
tf = 3600;  % 1 hour
p1_0 = 2*ones(3,1);
p2_0 = 2*ones(3,1);
P0_guess = [tf;p1_0;p2_0];

%% Solve shooting problem
options=optimset('Display','iter','LargeScale','on','TolX',1e-6,'MaxIter',10000,'MaxFunEvals',10000);
[P0,FVAL,EXITFLAG]=fsolve(@(P0)shootingFunc(P0,x0),P0_guess,options);
EXITFLAG % 1 or 2 if convergence is achieved

%% Simulate and plot results
tf = P0(1);
z0 = [x0;P0(2:end)];

r_des_f = R3(tf)*r_des;

options = odeset('AbsTol',1e-9,'RelTol',1e-9);
[t,z] = ode113(@(t,z) Zdyn(t,z), [0 tf], z0, options);
u_arr = zeros(length(t),3);
for i = 1:length(t)
    u_arr(i,:) = getU(z(i,:));
end

r_arr = z(:,1:3);
v_arr = z(:,4:6);
p1_arr = z(:,7:9);
p2_arr = z(:,10:12);

figure()
subplot(311)
hold on;
plot(t,r_arr(:,1))
plot(t,ones(1,length(t))*r_des_f(1),'k--');
ylabel('x')
subplot(312)
hold on;
plot(t,r_arr(:,2))
plot(t,ones(1,length(t))*r_des_f(2),'k--');
ylabel('y')
subplot(313)
hold on;
plot(t,r_arr(:,3))
plot(t,ones(1,length(t))*r_des_f(3),'k--');
ylabel('z')

figure()
subplot(311)
plot(t,v_arr(:,1))
ylabel('v_x')
subplot(312)
plot(t,v_arr(:,2))
ylabel('v_y')
subplot(313)
plot(t,v_arr(:,3))
ylabel('v_z')

figure()
subplot(311)
plot(t,u_arr(:,1))
ylabel('u_x')
subplot(312)
plot(t,u_arr(:,2))
ylabel('u_y')
subplot(313)
plot(t,u_arr(:,3))
ylabel('u_z')
