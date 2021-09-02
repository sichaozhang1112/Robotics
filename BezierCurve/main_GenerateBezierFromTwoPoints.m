p1 = [1;0;pi];
p2 = [1.5;0;0];
points = [p1(1,1),p2(1,1);p1(2,1),p2(2,1)];
leftTangent = [cos(p1(3,1));sin(p1(3,1))];
rightTangent = [-cos(p2(3,1));-sin(p2(3,1))];

u = chordLengthParameterize(points);
bezCurve = generateBezier(points,u,leftTangent,rightTangent);

% for i = 1 : 20
%         uPrime = reparameterize(bezCurve,points,u);
%         bezCurve = generateBezier(points,uPrime,leftTangent,rightTangent);
% end

figure();
for i=1:4
    scatter(bezCurve(1,i),bezCurve(2,i),'r'); hold on;
end
for t=0:0.01:1
    point = (1-t)^3*bezCurve(:,1)+3*(1-t)^2*t*bezCurve(:,2)+3*t^2*(1-t)*bezCurve(:,3)+t^3*bezCurve(:,4);
    scatter(point(1,1),point(2,1),'b','*'); hold on;
end
axis equal;



