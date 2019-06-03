function var = guessTraj(r0,r_des)
    global N mu;
    dist_av = (norm(r0)+norm(r_des))/2;
    theta_diff = acos(dot(r0,r_des)/(norm(r0)*norm(r_des)));
    theta_arr = linspace(0,theta_diff,N);
    normal_vec = cross(r0,r_des);
    normal_vec = normal_vec/norm(normal_vec);
    r_dir = r0/norm(r0);

    v_mag = sqrt(mu/dist_av);


    x_arr = zeros(6,N);
    for i = 1:N
        R = axang2rotm([normal_vec;theta_arr(i)]');
        ri = dist_av*(R*r_dir);
        v_dir = cross(normal_vec, ri/norm(ri));
        vi = v_dir*v_mag;
        x_arr(:,i) = [ri;vi];
    end
    x_guess = reshape(x_arr',[6*N,1]);
    var = [x_guess;zeros(3*N,1)];
    
    if 0
        figure()
        hold on;
        plot3(x_arr(1,:),x_arr(2,:),x_arr(3,:),'k');
        plot3(x_arr(1,end),x_arr(2,end),x_arr(3,end),'r*')
        rE = 6378.1e3; 
        [X,Y,Z] = ellipsoid(0,0,0,rE,rE,rE,20);
        surface(X,Y,Z)
        xlabel('x')
        ylabel('y')
        zlabel('z')
        view(3)
    end
end