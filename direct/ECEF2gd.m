function [h,phi,lam] = ECEF2gd(xEC,yEC,zEC)
    
    lam = zeros(length(xEC),1);
    phi = zeros(length(xEC),1);
    h = zeros(length(xEC),1);
    
    for i = 1:length(xEC)
        R = [xEC(i), yEC(i), zEC(i)];
        rE = 6378.1; % km
        eE = 0.0818;
        lam(i) = atan2(R(2),R(1));
        r = norm(R);

        tol = 10E-10;
        d_phi = 1;
        phi_1 = asin(R(3)/r);
        N_1 = 0;

        while d_phi > tol
            N_1 = rE/sqrt(1-eE^2*sin(phi_1)^2);
            phi_2 = atan2(R(3)+N_1*eE^2*sin(phi_1),sqrt(R(1)^2+R(2)^2));
            d_phi = abs(phi_2-phi_1);
            phi_1 = phi_2;
        end

        phi(i) = phi_1;
        h(i) = sqrt(R(1)^2+R(2)^2)/cos(phi(i))-N_1;
    end
end