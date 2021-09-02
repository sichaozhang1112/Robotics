close all;
clear all;
for i=1:1
% Instruction input via_points x,y and heading
via_points = [0,0,0;1,1,pi/4];
bezierCurveNum = size(via_points,1)-1;
% if bezier CurveNum <=0 return;
for i=1:bezierCurveNum
    GenerateBezierCurve(via_points(i,:)',via_points(i+1,:)');
end
end

function [] = GenerateBezierCurve(start,target)
    bezPoints = [start(1,1),target(1,1);start(2,1),target(2,1)];
    leftTangent = [cos(start(3,1));sin(start(3,1))];
    rightTangent = [-cos(target(3,1));-sin(target(3,1))];
    u = chordLengthParameterize(bezPoints);
    bezCurve = generateBezier(bezPoints,u,leftTangent,rightTangent);
    DrawBezier(bezCurve);
    DrawCurvature(bezCurve);
end