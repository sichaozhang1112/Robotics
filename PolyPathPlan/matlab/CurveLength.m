clear all;

point_s = [0,0]; heading_s = tan(0); curv_s = 0;
point_e = 0.3*[1,tan(pi/12)]; heading_e = tan(pi/12); curv_e = 0;

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

h = 0.001;
x=x_s:h:x_e;
y = Q(1,1)+Q(2,1)*x+Q(3,1)*x.^2+Q(4,1)*x.^3+Q(5,1)*x.^4+Q(6,1)*x.^5;
dy = diff(y)/h;
S = h*trapz((1+dy.^2).^0.5)

u = [0.56888889,0.47862876,0.47862876,0.23692689,0.23692689];
v = [0,-0.53846931,0.53846931,-0.90617984,0.90617984];

length = 0;
for i = 1 : 5
    xtemp = v(i)*(x(end)-x(1))/2+(x(end)+x(1))/2;
    ytemp = Q(2,1)+Q(3,1)*2*xtemp+Q(4,1)*3*xtemp^2+Q(5,1)*4*xtemp^3+Q(6,1)*5*xtemp^4;
    dis = sqrt(1^2+ytemp^2);
    length = length + u(i)*dis;
end
length = length*(x(end)-x(1))/2

