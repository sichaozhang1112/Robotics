clear all;
close all;
thetatemp = pi/3*(rand(1)-0.5)*2;
P_es(1) = 0.5+0.5*rand(1);
P_es(2) = P_es(1)*tan(thetatemp);
P_es(3) = thetatemp+0*(rand(1)-0.5)*2;
P_es(4) = 0;

Q = calcQuinticCoeff([0,0,0,0] ,P_es); 

x =0: 0.01 :1;
y =Q(1,1)+Q(2,1)*x+Q(3,1)*x.^2+Q(4,1)*x.^3+Q(5,1)*x.^4+Q(6,1)*x.^5;
figure(1);
plot(x,y);hold on;
%%
x0 = 0.1; y0 = 0.3;
scatter(x0,y0,'r','*');
xt = x0;
for i = 1 : 10
    f = Q(1,1)+Q(2,1)*xt+Q(3,1)*xt^2+Q(4,1)*xt^3+Q(5,1)*xt^4+Q(6,1)*xt^5;
    f1 = Q(2,1)+2*Q(3,1)*xt+3*Q(4,1)*xt^2+4*Q(5,1)*xt^3+5*Q(6,1)*xt^4;
    f2 = 2*Q(3,1)+6*Q(4,1)*xt+12*Q(5,1)*xt^2+20*Q(6,1)*xt^3;
    g1 = 2*xt - 2*x0 + 2*f*f1-2*y0*f1;
    g2 = 2 + 2*f1*f1 + 2*f*f2 - 2*y0*f2;
    xt = xt - g1/g2
    figure(1)
    scatter(xt,Q(1,1)+Q(2,1)*xt+Q(3,1)*xt^2+Q(4,1)*xt^3+Q(5,1)*xt^4+Q(6,1)*xt^5);hold on;
end
figure(1);
axis equal;

