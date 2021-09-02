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
