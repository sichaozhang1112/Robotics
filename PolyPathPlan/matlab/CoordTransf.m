function [P_es] = CoordTransf(P_s,P_e)
%     P_ss = [0,0,0,0];
    P_es(1) = (P_e(1)-P_s(1))*cos(P_s(3))+(P_e(2)-P_s(2))*sin(P_s(3));
    P_es(2) = -(P_e(1)-P_s(1))*sin(P_s(3))+(P_e(2)-P_s(2))*cos(P_s(3)); 
    P_es(3) = P_e(3)-P_s(3);
    P_es(4) = P_e(4);
end