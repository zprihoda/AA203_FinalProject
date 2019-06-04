function [R] = gc2ECEF(phi,lam) 

global r_E;

R = zeros(3,1); 
R(1) = cos(phi)*cos(lam); 
R(2) = cos(phi)*sin(lam); 
R(3) = sin(phi); 

end