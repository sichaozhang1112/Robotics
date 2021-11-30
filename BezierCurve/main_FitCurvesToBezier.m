% function main
clear all;
close all;
% load plan;
i = 1; % the ith Curve
x = sort(10*rand(1,100));
y = sin(x*rand(1)*pi)+0.5*cos(x*3*rand(1)*pi)+2*sin(x*rand(1)*pi);
% x = plan(2,breakpoint(i)+1:breakpoint(i+1));
% y = plan(3,breakpoint(i)+1:breakpoint(i+1));
% x = plan_x;
% y = plan_y;
% x = rand(1,3);
% y = rand(1,3);
points = [x;y];
figure(1);
% p = fit(x',y','smoothingspline');
% plot(p,x,y);hold on;
% plot(x,y);hold on;
scatter(points(1,:),points(2,:),'k');hold on;
maxError =0.1;
bezCurve = fitCurve(points,maxError);
% end

function [bezCurve] = fitCurve(points,maxError)
leftTangent = (points(:,2)-points(:,1))/norm(points(:,2)-points(:,1));
rightTangent = (points(:,end-1)-points(:,end))/norm(points(:,end-1)-points(:,end));
bezCurve = fitCubic(points,leftTangent,rightTangent,maxError, 1);
end

function [bezCurve] = fitCubic(points,leftTangent,rightTangent,error, start)
load plan;
if size(points,2) == 2
    dist = norm(points(:,1)-points(:,2))/3;
    bezCurve = [points(:,1),points(:,1)+leftTangent*dist,points(:,2)+rightTangent*dist,points(:,2)];
    return;
end

u = chordLengthParameterize(points);
bezCurve = generateBezier(points,u,leftTangent,rightTangent);
[maxError,splitPoint] = computerMaxError(points,bezCurve,u);
if maxError<error
%     bezCurve
    DrawBezier(bezCurve);
    scatter(bezCurve(1,4),bezCurve(2,4),'linewidth', 2);
%      [plan_x(start+splitPoint),plan_y(start+splitPoint)]
%     scatter(plan_x(start+splitPoint),plan_y(start+splitPoint),'linewidth', 2);
    return;
end
if maxError<error*2
    for i = 1 : 20
        uPrime = reparameterize(bezCurve,points,u);
        bezCurve = generateBezier(points,uPrime,leftTangent,rightTangent);
        [maxError,splitPoint] = computerMaxError(points,bezCurve,uPrime);
        if maxError<error
%             bezCurve
            DrawBezier(bezCurve)
%             scatter(bez(1,1),bez(2,1));
            scatter(bezCurve(1,4),bezCurve(2,4),'linewidth', 2);
%             [plan_x(start+splitPoint),plan_y(start+splitPoint)]
            return;
        end
        u = uPrime;
    end
end
if (splitPoint==1)||(splitPoint==size(points,2)) 
    return;
end
centerTangent = (points(:,splitPoint-1)-points(:,splitPoint+1))/norm(points(:,splitPoint-1)-points(:,splitPoint+1));
fitCubic(points(:,1:splitPoint),leftTangent,centerTangent,error,start);
fitCubic(points(:,splitPoint:end),-centerTangent,rightTangent,error,start+splitPoint-1);
end

function [bezCurve] = generateBezier(points,parameters,leftTangent,rightTangent)
bezCurve(:,1) = points(:,1);
bezCurve(:,4) = points(:,end);
A = zeros(2,2,4);
for i = 1:size(parameters,2)
    A(:,1,i) = leftTangent*3*(1-parameters(:,i))^2*parameters(:,i);
    A(:,2,i) = rightTangent*3*(1-parameters(:,i))*parameters(:,i)^2;
end
C = zeros(2,2);
X = zeros(1,2);
for i = 1:size(parameters,2)
    C(1,1) = C(1,1)+sum(A(:,1,i).*A(:,1,i));
    C(1,2) = C(1,2)+sum(A(:,1,i).*A(:,2,i));
    C(2,1) = C(2,1)+sum(A(:,1,i).*A(:,2,i));
    C(2,2) = C(2,2)+sum(A(:,2,i).*A(:,2,i));
    tmp = points(:,i) - Bezierq([points(:,1),points(:,1),points(:,end),points(:,end)],parameters(:,i)); 
    X(1) = X(1)+A(:,1,i)'*tmp;
    X(2) = X(2)+A(:,2,i)'*tmp;
end
det_C0_C1 = C(1,1)*C(2,2)-C(1,2)*C(2,1);
det_C0_X = C(1,1)*X(2)-C(2,1)*X(1);
det_X_C1 = C(2,2)*X(1)-C(1,2)*X(2);
if det_C0_C1==0
    alpha_l = 0;
    alpha_r = 0;
else
    alpha_l = det_X_C1/det_C0_C1;
    alpha_r = det_C0_X/det_C0_C1;
end
segLength = norm(points(:,1)-points(:,end));
epsilon = 1e-6*segLength;
if alpha_l<epsilon || alpha_r<epsilon
    bezCurve(:,2) = bezCurve(:,1)+leftTangent*(segLength/3);
    bezCurve(:,3) = bezCurve(:,4)+rightTangent*(segLength/3);
else
    bezCurve(:,2) = bezCurve(:,1)+leftTangent*alpha_l;
    bezCurve(:,3) = bezCurve(:,4)+rightTangent*alpha_r;
end
end

function [u] = chordLengthParameterize(points)
u=[0];
for i = 2:size(points,2)
    u(:,i) = u(:,i-1)+norm(points(:,i)-points(:,i-1));
end

for i = 1:size(u,2)
    u(:,i)=u(:,i)/u(:,end);
end
end

function [uPrime] = reparameterize(bezCurve,points,u)
for i = 1:size(points,2)
    uPrime(:,i) = newtonRaphsonRootFind(bezCurve,points(:,i),u(:,i));
end
end

function [param] =  newtonRaphsonRootFind(bez,point,u)
d = Bezierq(bez,u)-point;
numerator = sum(d.*Bezierqprime(bez,u));
denominator = sum(Bezierqprime(bez,u).^2)+sum(d.*Bezierqprime2(bez,u));
if denominator == 0
    param = u;
else
    param = u-numerator/denominator;
end
    
end

function [maxDist,splitPoint] = computerMaxError(points,bez,parameters)
maxDist = 0;
splitPoint = size(points,2)/2;
for i = 1:size(points,2)
    dist = norm(Bezierq(bez,parameters(:,i))-points(:,i))^2;
    if dist>maxDist
        maxDist = dist;
        splitPoint = i;
    end
end
end

function [point] = Bezierq(ctrlPoly,t)
point = (1-t)^3*ctrlPoly(:,1)+3*(1-t)^2*t*ctrlPoly(:,2)+3*t^2*(1-t)*ctrlPoly(:,3)+t^3*ctrlPoly(:,4);
end

function [point] = Bezierqprime(ctrlPoly,t)
point = 3*(1-t)^2*(ctrlPoly(:,2)-ctrlPoly(:,1))+6*(1-t)*t*(ctrlPoly(:,3)-ctrlPoly(:,2))+3*t^2*(ctrlPoly(:,4)-ctrlPoly(:,3));
end

function [point] = Bezierqprime2(ctrlPoly,t)
point = 6*(1-t)*(ctrlPoly(:,3)-2*ctrlPoly(:,2)+ctrlPoly(:,1))+6*t*(ctrlPoly(:,4)-2*ctrlPoly(:,3)+ctrlPoly(:,2));
end

function [] = DrawBezier( points )
% global eM;
t = 0:0.001:1;
B = [];
for i = 1:size(t,2)
    B = [B, points(:,1)*(1-t(i))^3+3*points(:,2)*t(i)*(1-t(i))^2+3*points(:,3)*t(i)^2*(1-t(i))+points(:,4)*t(i)^3];
end
figure(1)
scatter(points(1,1),points(2,1),'*','r'); hold on;
scatter(points(1,end),points(2,end),'*','r'); hold on;
% if eM == 0.02
%     plot(B(1,:),B(2,:),'linewidth',1,'color','r'); hold on;
% if eM == 0.05
    plot(B(1,:),B(2,:),'linewidth',1.5,'color','b'); hold on;
    axis equal;
% elseif eM == 0.1
%     plot(B(1,:),B(2,:),'linewidth',1,'color','g'); hold on;
% end
end

