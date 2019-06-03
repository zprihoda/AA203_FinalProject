function plotResult(var)
    N = length(var)/9;
    r1 = var(1:N); r2 = var(N+1:2*N); r3 = var(2*N+1:3*N); 
    
    figure()
    hold on;
    plot3(r1(:),r2(:),r3(:),'k');
    plot3(r1(end),r2(end),r3(end),'r*')
    rE = 6378.1e3; 
    [X,Y,Z] = ellipsoid(0,0,0,rE,rE,rE,20);
    surface(X,Y,Z)
    xlabel('x')
    ylabel('y')
    zlabel('z')
    view(3)
end