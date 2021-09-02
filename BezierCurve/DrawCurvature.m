function [] = DrawCurvature(bezCurve,n)
curvatures=[];
for t=0:0.01:1
        curvature = BezierCurvature(bezCurve,t,n);
        curvatures = [curvatures,curvature];
end
figure(2);
plot(curvatures(1,:),'b');hold on;
title('curvature')
axis equal;
end