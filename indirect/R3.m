function R = R3(tf)
    global w_E;
    theta = w_E*tf;
    R = [ cos(theta), sin(theta), 0;
         -sin(theta), cos(theta), 0;
                   0,          0, 1];
end