function u = getU(z)
    global g3 u_max
    p2 = z(10:12);
    u = zeros(3,1);
    for i = 1:3
        if g3 < p2(i)
            u(i) = -u_max;
        elseif -g3 > p2(i)
            u(i) = u_max;
        else
            u(i) = 0;
        end
    end