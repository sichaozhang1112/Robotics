function [t] = FindNearestPointOnBezier(ctrlPoint,point,n)
% t=0.5;
% for i=1:10
% bezier = Bezierq(ctrlPoint,t,n);
% bezierPrime = Bezierqprime(ctrlPoint,t,n);
% bezierPrime2 = Bezierqprime2(ctrlPoint,t,n);
% f_1 = 2*(bezier(1)-point(1))*bezierPrime(1)+2*(bezier(2)-point(2))*bezierPrime(2);
% f_2 = 2*bezierPrime(1)*bezierPrime(1)+2*bezier(1)*bezierPrime2(1)-2*point(1)*bezierPrime2(1)+2*bezierPrime(2)*bezierPrime(2)+2*bezier(2)*bezierPrime2(2)-2*point(2)*bezierPrime2(2);
% t=t-f_1/f_2;
% end
% dis_min = 1000;
% for t=0:0.01:1
%     bezier = Bezierq(ctrlPoint,t,n);
%     dis = PointDistance(bezier,point);
%     if (dis<dis_min)
%         dis_min = dis;
%         t_min = t;
%     end
% end
t=0.5;
for i=1:10
bezier = Bezierq(ctrlPoint,t,n);
bezierPrime = Bezierqprime(ctrlPoint,t,n);
bezierPrime2 = Bezierqprime2(ctrlPoint,t,n);
f_1 = 2*(bezier(1)-point(1))*bezierPrime(1)+2*(bezier(2)-point(2))*bezierPrime(2);
f_2 = 2*bezierPrime(1)*bezierPrime(1)+2*bezier(1)*bezierPrime2(1)-2*point(1)*bezierPrime2(1)+2*bezierPrime(2)*bezierPrime(2)+2*bezier(2)*bezierPrime2(2)-2*point(2)*bezierPrime2(2);
t=t-f_1/f_2;
end
end