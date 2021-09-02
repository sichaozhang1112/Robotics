function [] = DrawBezier(bezCurve,n)
points=[];
for t=0:0.01:1
        point = Bezierq(bezCurve,t,n);
        points=[points,point];
end
figure(1);
plot(points(1,:),points(2,:),'b');hold on;
scatter(bezCurve(1,1),bezCurve(2,1),'r');hold on;
scatter(bezCurve(1,n+1),bezCurve(2,n+1),'r');hold on;
for i=2:n
    scatter(bezCurve(1,i),bezCurve(2,i),'r','*');hold on;
end
title('Bezier')
axis equal;
end