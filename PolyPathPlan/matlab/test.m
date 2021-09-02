clear all;
close all;

for ii = 1 : 1
    if ii == 1
        point_s = [14,17]; heading_s = 0; curv_s = 0;
%         point_e = [1,tan(theta)]*0.5; heading_e = theta-pi/12; curv_e = 0;
    else
        num = size(xp,2)-round(size(xp,2)/(2+2*rand(1)));
        x_s = xp(num);
        y_s = yp(num);
        point_s = [x_s,y_s]; 
        heading_s = hp(num); 
        curv_s =cp(num); 
    end
    
    P_sz = [point_s(1),point_s(2),heading_s,curv_s];
    P_zs = CoordTransf(P_sz,[0,0,0,0]);
    P_es(1) = 0.5+0.5*rand(1);
    thetatemp = pi/6*(rand(1)-0.5)*2;
    P_es(2) = P_es(1)*tan(thetatemp);
    P_es(3) = thetatemp+pi/12*(rand(1)-0.5)*2;
    P_es(4) = 0;
    P_e = CoordTransf(P_zs,P_es);
    point_e = [P_e(1),P_e(2)]; heading_e = P_e(3); curv_e = 0;
    
    Q = calcQuinticCoeff([0,0,0,curv_s] ,P_es);

    figure(1);
    x_s = point_s(1);x_e=point_e(1);
    y_s = point_s(2);y_e = point_e(2);
    scatter(x_s,y_s); hold on;
    scatter(x_e,y_e); hold on;
    t = x_s-0.01*cos(heading_s) : 0.01 : x_s+0.01*cos(heading_s);plot(t,tan(heading_s)*(t-x_s)+y_s,'r','linewidth',2); hold on;
    t = x_e-0.01*cos(heading_e) : 0.01 : x_e+0.01*cos(heading_e);plot(t,tan(heading_e)*(t-x_e)+y_e,'r','linewidth',2); hold on;
    %t_e = x_e-0.05:0.05:x_e+0.05;plot(t_e,heading_e*(t_e-x_e)+y_e,'r','linewidth',2); hold on;
    xp = [];yp=[];cp=[];hp=[];
    for x = linspace(0,P_es(1),100)
        y = Q(1,1)+Q(2,1)*x+Q(3,1)*x^2+Q(4,1)*x^3+Q(5,1)*x^4+Q(6,1)*x^5;
        heading = atan(Q(2,1)+2*Q(3,1)*x+3*Q(4,1)*x^2+4*Q(5,1)*x^3+5*Q(6,1)*x^4);
        curv = 2*Q(3,1)+6*Q(4,1)*x+12*Q(5,1)*x^2+20*Q(6,1)*x^3;
        P_ps = [x,y,heading,curv];
        P_pz = CoordTransf(P_zs,P_ps);
        xp = [xp,P_pz(1)];yp = [yp,P_pz(2)];
        cp = [cp,P_pz(4)];hp=[hp,P_pz(3)];
    end
    plot(xp,yp,'linewidth',1); 
    axis equal;
    figure(2);
    plot(linspace(0,P_es(1),100),cp,'linewidth',1);hold on;
    plot(linspace(0,P_es(1),100),1,'r');hold on;
    plot(linspace(0,P_es(1),100),-1,'r');hold on;
end