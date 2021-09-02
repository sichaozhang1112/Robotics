function [bezCurve] = generateBezier2(points,parameters,leftTangent,rightTangent)
bezCurve(:,1) = points(:,1);
bezCurve(:,4) = points(:,end);

t = inv(leftTangent*[1,0]-rightTangent*[0,1])*(bezCurve(:,4)-bezCurve(:,1));

bezCurve(:,2) = bezCurve(:,1)+leftTangent*t(1);
bezCurve(:,3) = bezCurve(:,4)+rightTangent*t(2);

end