function reorientCamera(var)
global N

x0 = var(1);
xf = var(N);

y0 = var(N+1);
yf = var(2*N);

z0 = var(2*N+1);
zf = var(3*N);

V = [x0, y0, z0; xf, yf, zf];

meanV = mean(V);

view(meanV)
end