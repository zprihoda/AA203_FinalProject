function plotGroundTrack(var)
    global N r_des;
    
    % load things
    r1 = var(1:N)/1000; r2 = var(N+1:2*N)/1000; r3 = var(2*N+1:3*N)/1000; 

    % plot ground track
    [xEC,yEC,zEC] = CRF2TRF(r1,r2,r3);
    [h,phi,lam] = ECEF2gd(xEC,yEC,zEC); 
    
    lam = lam/pi * 180;
    phi = phi/pi * 180;
    
    figure() 
    plot(lam,phi,'LineWidth',2)
    hold on

    % plot desired position
    [xEC,yEC,zEC] = CRF2TRF(r_des(1),r_des(2),r_des(3));
    [h,phi,lam] = ECEF2gd(xEC,yEC,zEC); 
    lam = lam/pi * 180;
    phi = phi/pi * 180;
    plot(lam,phi,'rx','LineWidth',2)
    
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