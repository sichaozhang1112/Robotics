clear all;
close all;
s1 = 0; v1 = 0.0001; a1= 0; j1 = 0;
s2 =2.5; v2 = 1; a2= 0; j2 = 0;

%%
p1 = [s1,v1,a1,j1];
p2 = [s2,v2,a2,j2];
[K] = PolyScurve5(p1,p2)

s = s1:0.001:s2;
n = size(s,2);
v = K(1)*s.^5+K(2)*s.^4+K(3)*s.^3+K(4)*s.^2+K(5)*s+K(6);
a = 5*K(1)*s.^4.*v + 4*K(2)*s.^3.*v + 3*K(3)*s.^2.*v + 2*K(4)*s.^1.*v + K(5)*v; 
j = 20*K(1)*s.^3.*v.^2+5*K(1)*s.^4.*a+12*K(2)*s.^2.*v.^2+4*K(2)*s.^3.*a+6*K(3)*s.^1.*v.^2+3*K(3)*s.^2.*a+2*K(4)*v.^1.*v+2*K(4)*s.^1.*a+K(5)*a;
figure(1);
plot(s,v); hold on; %axis equal;
figure(2);
plot(s,a); hold on;
figure(3);
plot(s,j); hold on;

%%
p1 = [s1,v1,a1];
p2 = [s2,v2,a2];
[K] = PolyScurve3(p1,p2)

s = s1:0.001:s2;
n = size(s,2);
v = K(1)*s.^3+K(2)*s.^2+K(3)*s+K(4);
a = 3*K(1)*s.^2.*v + 2*K(2)*s.^1.*v + K(3)*v; 
j = 6*K(1)*s.^1.*v.^2+3*K(1)*s.^2.*a+2*K(2)*v.^1.*v+2*K(2)*s.^1.*a+K(3)*a;
figure(1);
plot(s,v,'r'); hold on; %axis equal;
figure(2);
plot(s,a,'r'); hold on;
figure(3);
plot(s,j,'r'); hold on;
