function plotResult(var,var_init)
    global N T r_des
    
    % plot obtained traj
    dt = 1.0*T/(1.0*N);
    r1 = var(1:N); r2 = var(N+1:2*N); r3 = var(2*N+1:3*N); 
    u1 = var(6*N+1:7*N); u2 = var(7*N+1:8*N); u3 = var(8*N+1:9*N);
    
    t_arr = 0:dt:T-dt;
    
    % plot initial guess
    r1_init = var_init(1:N); r2_init = var_init(N+1:2*N); r3_init = var_init(2*N+1:3*N); 
    
    figure()
    hold on;
    plot3(r1(:),r2(:),r3(:),'k','LineWidth',2);
    plot3(r1_init(:),r2_init(:),r3_init(:),'r','LineWidth',2);
    plot3(r_des(1), r_des(2), r_des(3), 'r*','LineWidth',2)
    rE = 6378.1e3; 
    [X,Y,Z] = ellipsoid(0,0,0,rE,rE,rE,20);
    surface(X,Y,Z)
    xlabel('x')
    ylabel('y')
    zlabel('z')
    view(3)
    title('Orbit Trajectory','FontSize',35)
    legend('Optimal Solution','Initial Guess','location','northeast')
    
    figure()
    hold on;
    plot(t_arr,u1,'LineWidth',2)
    plot(t_arr,u2,'LineWidth',2)
    plot(t_arr,u3,'LineWidth',2)
    legend('u1','u2','u3')
    xlabel('t (s)')
    ylabel('u (m/s)')
    title('Control Trajectory','FontSize',35)
end