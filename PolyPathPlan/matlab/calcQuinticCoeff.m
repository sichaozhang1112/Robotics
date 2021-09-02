function [ Q ] = calcQuinticCoeff(P_s,P_e)
        Q = zeros(6,6);
        point_s = [P_s(1),P_s(2)]; heading_s = tan(P_s(3)); curv_s = P_s(4);
        point_e = [P_e(1),P_e(2)]; heading_e = tan(P_e(3)); curv_e = P_e(4);

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
end