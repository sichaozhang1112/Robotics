clear all;
close all;

x_s = 9.525839;
y_s = 13.388060;
point_s = [x_s,y_s]; 
heading_s = 1.719366;
curv_s = -0.613566;

theta_heading = [];

x_e = 9;
y_e = 13.9;
point_e = [x_e,y_e]; 
heading_e = 90*pi/180;
curv_e = 0;

P_sz = [point_s(1),point_s(2),heading_s,curv_s];
P_zs = CoordTransf(P_sz,[0,0,0,0]);
P_ez = [point_e(1),point_e(2),heading_e,curv_e];
P_es = CoordTransf(P_sz,P_ez);
Q = calcQuinticCoeff([0,0,0,curv_s] ,P_es);

k = [-0.4713,0,1.6835,0];
dirAngle = atan(P_es(2)/P_es(1));
idealTargetHeading = k(1)*dirAngle^3+k(3)*dirAngle^1;
P_is = [P_es(1),P_es(2),idealTargetHeading,P_es(4)];
P_iz = CoordTransf(P_zs,P_is);
P_iz(3)*180/pi

figure(3)
scatter(0,0); hold on;
scatter(P_es(1),P_es(2)); hold on;
t = -0.05*cos(0) : 0.01 : 0.05*cos(0);plot(t,tan(0)*(t),'r','linewidth',2); hold on;
t = P_es(1)-0.05*cos(P_es(3)) : 0.01 : P_es(1)+0.05*cos(P_es(3));plot(t,tan(P_es(3))*(t-P_es(1))+P_es(2),'r','linewidth',2); hold on;

x = 0:0.01:P_es(1);
y = Q(1,1)+Q(2,1)*x+Q(3,1)*x.^2+Q(4,1)*x.^3+Q(5,1)*x.^4+Q(6,1)*x.^5;
heading = atan(Q(2,1)+2*Q(3,1)*x+3*Q(4,1)*x.^2+4*Q(5,1)*x.^3+5*Q(6,1)*x.^4);
curv = 2*Q(3,1)+6*Q(4,1)*x+12*Q(5,1)*x.^2+20*Q(6,1)*x.^3;

figure(3);
plot(x,y,'linewidth',1); 
axis equal;

%%
x_s = point_s(1);x_e=point_e(1);
y_s = point_s(2);y_e = point_e(2);
% figure(1)
% scatter(x_s,y_s); hold on;
% scatter(x_e,y_e); hold on;
% t = x_s-0.05*cos(heading_s) : 0.01 : x_s+0.05*cos(heading_s);plot(t,tan(heading_s)*(t-x_s)+y_s,'r','linewidth',2); hold on;
% t = x_e-0.05*cos(heading_e) : 0.01 : x_e+0.05*cos(heading_e);plot(t,tan(heading_e)*(t-x_e)+y_e,'r','linewidth',2); hold on;
%t_e = x_e-0.05:0.05:x_e+0.05;plot(t_e,heading_e*(t_e-x_e)+y_e,'r','linewidth',2); hold on;
% xp = [];yp=[];cp=[];hp=[];
x = 0:0.01:P_es(1);
y = Q(1,1)+Q(2,1)*x+Q(3,1)*x.^2+Q(4,1)*x.^3+Q(5,1)*x.^4+Q(6,1)*x.^5;
heading = atan(Q(2,1)+2*Q(3,1)*x+3*Q(4,1)*x.^2+4*Q(5,1)*x.^3+5*Q(6,1)*x.^4);
curv = 2*Q(3,1)+6*Q(4,1)*x+12*Q(5,1)*x.^2+20*Q(6,1)*x.^3;
for i = 1 : size(x,2)
    curvlen(i) = CalCurveLength(x(i),Q);
end
% P_ps = [x,y,heading,curv];
% P_pz = CoordTransf(P_zs,P_ps);
% xp = [xp,P_pz(1)];yp = [yp,P_pz(2)];
% cp = [cp,P_pz(4)];hp=[hp,P_pz(3)];
% end
% figure(1);
% plot(xp,yp,'linewidth',1); 
% axis equal;
figure(2);
plot(curvlen,curv,'linewidth',1);hold on;