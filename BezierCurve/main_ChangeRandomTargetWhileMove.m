clear all;
close all;
start = [0;0;0]; %current position and heading

for i = 1:10

    target = start + [3*rand(1);2*(rand(1)-0.5);(rand(1)-0.5)*pi/2];
    bezPoints = [start(1,1),target(1,1);start(2,1),target(2,1)];
    target(3,1) = atan2(target(2,1)-start(2,1),target(1,1)-start(1,1));
    leftTangent = [cos(start(3,1));sin(start(3,1))];
    rightTangent = [-cos(target(3,1));-sin(target(3,1))];
    u = chordLengthParameterize(bezPoints);
    bezCurve = generateBezier(bezPoints,u,leftTangent,rightTangent);
    for i=1:3:4
        figure(1);
        scatter(bezCurve(1,i),bezCurve(2,i),'r'); hold on;
    end
    points = [];
    pointsPrime = [];
    for t=0:0.01:1
        point = (1-t)^3*bezCurve(:,1)+3*(1-t)^2*t*bezCurve(:,2)+3*t^2*(1-t)*bezCurve(:,3)+t^3*bezCurve(:,4);
        pointPrime = 3*(1-t)^2*(bezCurve(:,2)-bezCurve(:,1))+6*(1-t)*t*(bezCurve(:,3)-bezCurve(:,2))+3*t^2*(bezCurve(:,4)-bezCurve(:,3));
        points=[points,point];
        pointsPrime=[pointsPrime,pointPrime];
    end
    figure(1);
    plot(points(1,:),points(2,:));hold on;
    axis equal;
%     figure(2);
%     plot(points(1,:),atan(pointsPrime(2,:)./pointsPrime(1,:))); hold on;
%     axis equal
    start = target;
%     start(3,1) = atan2(rightTangent(2,1),rightTangent(1,1));

end
