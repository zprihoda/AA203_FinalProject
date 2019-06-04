function plotGroundTrack(var)
    global N r_des0 w_E;
    
    % load things
    r1 = var(1:N); r2 = var(N+1:2*N); r3 = var(2*N+1:3*N);
    T = var(end);
    time = linspace(0,T,N);
    r_des = R3(-w_E*T)*r_des0;

    for i = 1:N
        GMST = time(i)*w_E;
        [xEC(i),yEC(i),zEC(i)] = CRF2TRF(GMST,r1(i),r2(i),r3(i));
    end
    [h,phi,lam] = ECEF2gd(xEC,yEC,zEC);
    [h2,phi2,lam2] = ECEF2gd(r_des(1),r_des(2),r_des(3));
    lam = lam/pi()*180; lam2 = lam2/pi()*180;
    phi = phi/pi()*180; phi2 = phi2/pi()*180;

    figure
% Plot your groundtrack here
plot(lam,phi,'LineWidth',2)
hold on
plot(lam2,phi2,'rx','MarkerSize',8,'LineWidth',2)
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
    title('Ground Track','FontSize',35')
end