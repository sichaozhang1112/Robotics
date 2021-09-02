clear all;

point_s = [0,0]; heading_s = tan(0); curv_s = 0;
point_e = 5*[1,1]; heading_e = tan(0); curv_e = 0;

x_s = point_s(1,1); y_s = point_s(1,2);
x_e = point_e(1,1); y_e = point_e(1,2);
X = [1,x_s,x_s^2,x_s^3,x_s^4,x_s^5; ...
     0,1,2*x_s,3*x_s^2,4*x_s^3,5*x_s^4; ...
     0,0,2,6*x_s,12*x_s^2,20*x_s^3; ...
     1,x_e,x_e^2,x_e^3,x_e^4,x_e^5; ...
     0,1,2*x_e,3*x_e^2,4*x_e^3,5*x_e^4; ...
     0,0,2,6*x_e,12*x_e^2,20*x_e^3];
Y = [y_s;heading_s;curv_s;y_e;heading_e;curv_e];

Q = inv(X)*Y;

p = 0.4;
xend = 1;
h = 0.001;
x=0:h:xend*p;
y = Q(1,1)+Q(2,1)*x+Q(3,1)*x.^2+Q(4,1)*x.^3+Q(5,1)*x.^4+Q(6,1)*x.^5;
dy = diff(y)/h;
S1 = h*trapz((1+dy.^2).^0.5)
x=0:h:xend;
y = Q(1,1)+Q(2,1)*x+Q(3,1)*x.^2+Q(4,1)*x.^3+Q(5,1)*x.^4+Q(6,1)*x.^5;
dy = diff(y)/h;
S2 = h*trapz((1+dy.^2).^0.5)

t1(1) = S1/S2;
for i = 1 : 10
    xtemp = t1(i)*(x(end)-x(1))+x(1);
    ytemp =  Q(2,1)+Q(3,1)*2*xtemp+Q(4,1)*3*xtemp^2+Q(5,1)*4*xtemp^3+Q(6,1)*5*xtemp^4;
%     L = GLintegration( x(1),xtemp,Q );
    L = TRAPintegration( x(1),xtemp,Q );
    t2(i) = t1(i) - (L-S1)/sqrt(1+ytemp^2);
    t1(i+1) = t2(i);
end

plot(t1,'r');hold on;plot(t2);
