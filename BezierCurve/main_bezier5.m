clear all;
close all;
start = [0;0;0];
for i=1
    target = [1;1;0];
    n=i;
    points =GenerateUniformBezier(start,target,n);
    DrawBezier(points,n)
%     DrawCurvature(points,n)
%     for j=0.01:0.01:1
%         point = Bezierq(points,j,n)+[0.01;0.01];
%         figure(1)
%         scatter(point(1),point(2),'r');
%         t = FindNearestPointOnBezier(points,point,n);
%         NearestPoint = Bezierq(points,t,n);
%         scatter(NearestPoint(1),NearestPoint(2),'b');
%     end
%     start = target;
end

% Simpson38Integration(points,n)
% GuassLengendreIntegration(points,n)
% BezierLength(points,n,0.01)
% BezierLength(points,n,0.001)
