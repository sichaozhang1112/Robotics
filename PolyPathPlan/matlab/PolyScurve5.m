function [K] = PolyScurve5(p1,p2)

s1 = p1(1); v1 = p1(2); a1= p1(3); j1 = p1(4);
s2 = p2(1); v2 = p2(2); a2= p2(3); j2 = p2(4);
if v1 == 0
    v1 = 0.00001;
end
if v2 == 0
    v2 = 0.00001;
end
B = [v1;a1;j1;v2;a2;j2];
A = [s1^5,s1^4,s1^3,s1^2,s1^1,1;
       5*s1^4*v1,4*s1^3*v1,3*s1^2*v1,2*s1*v1,1*v1,0;
       20*s1^3*v1^2+ 5*s1^4*a1,12*s1^2*v1^2+4*s1^3*a1,6*s1*v1^2+3*s1^2*a1,2*v1^2+2*s1*a1,a1,0;
       s2^5,s2^4,s2^3,s2^2,s2^1,1;
       5*s2^4*v2,4*s2^3*v2,3*s2^2*v2,2*s2*v2,1*v2,0;
       20*s2^3*v2^2+ 5*s2^4*a2,12*s2^2*v2^2+4*s2^3*a2,6*s2*v2^2+3*s2^2*a2,2*v2^2+2*s2*a2,a2,0 ];
K = inv(A)*B;

end