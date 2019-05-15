%% Orbit Trace %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;clc;

% start date
Year = 2018;
Month = 2;
Day = 1;
MJD = Cal2MJD(Year,Month,Day);
% lookup
dUT1 = 196.5014E-3;

% satellite position and speed
R = [-2827.4 -8916.9 -2340.8]; % km
V = [4.6567 3.2251 -5.9629]; % km/s

% orbital elements
[a,e,in,o,w,nu] = ECI2OE(R,V);
Eo = acos((e+cos(nu))/(1+e*cos(nu)));
Mo = Eo - e*sin(Eo);

% simulink
phi_gs = 0;
lam_gs = 0;
R_gs_ECEF = zeros(1,3);

% elapsed time
Ts = 24; % h
Ts = Ts*3600;
dt = 1;
ep = 10^-10;
mu = 3.986*10^5; % km3/s2
n = sqrt(mu/a^3);
M = Mo;
p = a*(1-e^2);
sim('Eanom.slx')

% plot
rE = 6378.1;
[X,Y,Z] = ellipsoid(0,0,0,rE,rE,rE,20);
figure
surface(X,Y,Z,'FaceColor',[0.4, 0.615, 0.980],'EdgeColor','black');
view (3);
alpha(1)
hold on
plot3(xEC,yEC,zEC,'-o','MarkerIndices',1:3600:length(xEC)-1,'Color','red','Linewidth',.1)
grid on;
axis equal
xlabel('X [km]')
ylabel('Y [km]')
zlabel('Z [km]')
title('Molniya 3-31 orbit wrt ECEF')

lam = lam/pi()*180;
phi = phi/pi()*180;

for j = 1:length(lam)-1
    if abs(lam(j)-lam(j+1)) > 180
        br = j;
        break
    end
end

figure
% Plot your groundtrack here
% plot(lam,phi,'-o','MarkerIndices',1:3600:length(xEC)-1)
plot(lam(1:j),phi(1:j),'-o','MarkerIndices',1:3600:j)
hold on
plot(lam(j+1:end),phi(j+1:end))
hold on

% Load and plot MATLAB built-in Earth topography data
load('topo.mat', 'topo');
topoplot = [topo(:, 181:360), topo(:, 1:180)];
contour(-180:179, -90:89, topoplot, [0, 0], 'black');

axis equal
grid on
xlim([-180, 180]);
ylim([-90, 90]);
xlabel('Longitude [\circ]');
ylabel('Latitude [\circ]');

%% functions
function MJD = Cal2MJD(Y,M,D)
    if M <= 2
        y = Y - 1;
        m = M + 12;
    else
        y = Y;
        m = M;
    end
    
    if Y > 1582
       B = [y/400] - [y/100] + [y/4];
    elseif Y < 1582
       B = -2 + [(y+4716)/4] - 1179;
    end
    if Y == 1582 
        if M < 10
            B = -2 + [(y+4716)/4] - 1179;
        elseif M > 10
            B = [y/400] - [y/100] + [y/4];
        end
        if M == 10
            if D <= 4
                B = -2 + [(y+4716)/4] - 1179;
            elseif D >= 10
                B = [y/400] - [y/100] + [y/4];
            end
        end
    end
        
    MJD = 365*y - 679004 + floor(B) + floor(30.6001*(m+1)) + D;
end
function [a,e,in,o,w,nu] = ECI2OE(r,v)
% From Vallado 112 - 116
    mu = 3.986*10^5; % km3/s2
    K = [0 0 1];
    h = cross(r,v);
    mag_h = sqrt(h(1)^2+h(2)^2+h(3)^2);
    W = h/mag_h;
    vec_n = cross(K,h);
    mag_n = sqrt(vec_n(1)^2+vec_n(2)^2+vec_n(3)^2);
    mag_v = sqrt(v(1)^2+v(2)^2+v(3)^2);
    mag_r = sqrt(r(1)^2+r(2)^2+r(3)^2);
    ep = (mag_v^2)/2-(mu/mag_r);
    vec_e = ((mag_v^2-(mu/mag_r))*r-(sum(r.*v)*v))/mu;
e = sqrt(vec_e(1)^2+vec_e(2)^2+vec_e(3)^2);
    
    if e ~= 1
a = -mu/(2*ep);
p = a*(1-e^2);
    else
a = inf;
p = mag_h^2/mu;
    end
    
in = acos(W(3));
o = acos(vec_n(1)/mag_n);
    if vec_n(2) < 0
        o = 2*pi() - o;
    end
w = acos(sum(vec_n.*vec_e)/(mag_n*e));
    if vec_e(3) < 0
        w = 2*pi() - w;
    end
nu = acos(sum(vec_e.*r)/(e*mag_r));
    if (sum(r.*v)) < 0 
        nu = 2*pi() - nu;
    end
    
    % Special Cases
w_true = acos(vec_e(1)/e);
    if vec_e(2) < 0
        % Elliptical equatorial
        w_true = 2*pi() - w_true;
    end
u = acos(sum(vec_n.*r)/(mag_n*mag_r));
    if r(3) < 0
        % Circular inclined
        u = 2*pi() - u;
    end
lam_true = acos(r(1)/mag_r);
    if r(2) < 0
        % Circular equatorial
        lam_true = 2*pi()-lam_true;
    end
    
    in = in/pi()*180;
    o = o/pi()*180;
    w = w/pi()*180;
    nu = nu/pi()*180;
end
