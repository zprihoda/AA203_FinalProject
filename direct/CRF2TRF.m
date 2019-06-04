function [xEC,yEC,zEC] = CRF2TRF(GMST,xE,yE,zE)
    Rot = rotz(-GMST);
    xEC = zeros(length(xE),1);
    yEC = zeros(length(yE),1);
    zEC = zeros(length(zE),1);
    for i = 1:length(xE)
        R = [xE(i) yE(i) zE(i)];
        R = Rot*transpose(R);
        xEC(i) = R(1);
        yEC(i) = R(2);
        zEC(i) = R(3);
    end
end