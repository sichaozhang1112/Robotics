clear all;
close all;

x_s = 7;
y_s = 15.9;
point_s = [x_s,y_s]; 
heading_s = 0*pi/180; 
curv_s =0; 

theta_heading = [];
for theta_min = 45 : 1 : 45
theta = theta_min*pi/180;
dx = 1;dy = dx*tan(theta);
x_e = x_s+dx;
y_e = y_s+dy;
point_e = [x_e,y_e]; 
curv_min = 1000; heading_min = 0;
heading_min = -0.0119*theta_min^2+1.9075*theta_min+0.0681
for iii = heading_min-70 : 1 : heading_min-70
heading_e = iii*pi/180;
curv_e = 0;

P_sz = [point_s(1),point_s(2),heading_s,curv_s];
P_zs = CoordTransf(P_sz,[0,0,0,0]);
P_ez = [point_e(1),point_e(2),heading_e,curv_e];
P_es = CoordTransf(P_sz,P_ez);
Q = calcQuinticCoeff([0,0,0,0] ,P_es);

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

xp = [];yp=[];cp=[];hp=[];
for x = 0:0.01:P_es(1)
    y = Q(1,1)+Q(2,1)*x+Q(3,1)*x^2+Q(4,1)*x^3+Q(5,1)*x^4+Q(6,1)*x^5;
    heading = atan(Q(2,1)+2*Q(3,1)*x+3*Q(4,1)*x^2+4*Q(5,1)*x^3+5*Q(6,1)*x^4);
    curv = 2*Q(3,1)+6*Q(4,1)*x+12*Q(5,1)*x^2+20*Q(6,1)*x^3;
    P_ps = [x,y,heading,curv];
    P_pz = CoordTransf(P_zs,P_ps);
    xp = [xp,P_pz(1)];yp = [yp,P_pz(2)];
    cp = [cp,P_pz(4)];hp=[hp,P_pz(3)];
end
% figure(1);
% plot(xp,yp,'linewidth',1); 
% axis equal;
figure(2);
plot(cp,'linewidth',1);hold on;

% if (curv_min>max(abs(cp)))
%     curv_min = max(abs(cp));
%     heading_min = heading_e*180/pi;
% end

end
% figure(1);
% scatter(theta_min,heading_min);hold on;
% theta_heading = [theta_heading,[theta_min;heading_min]];
end
% figure(1);
% axis equal;
% k=polyfit(theta_heading(1,:),theta_heading(2,:),1);
% x = 0:0.1:60;
% y = k(1)*x+k(2);
% plot(x,y)