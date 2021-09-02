function [K] = PolyScurve3(p1,p2)

s1 = p1(1); v1 = p1(2); a1= p1(3);
s2 = p2(1); v2 = p2(2); a2= p2(3);
if v1 == 0
    v1 = 0.00001;
end
if v2 == 0
    v2 = 0.00001;
end
B = [v1;a1;v2;a2];
A = [s1^3,s1^2,s1^1,1;
       3*s1^2*v1,2*s1*v1,1*v1,0;
       s2^3,s2^2,s2^1,1;
       3*s2^2*v2,2*s2*v2,1*v2,0];
K = inv(A)*B;

end