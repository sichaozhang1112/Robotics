function [point] = Bezierq(ctrlPoint,t,n)
% point = (1-t)^3*ctrlPoly(:,1)+3*(1-t)^2*t*ctrlPoly(:,2)+3*t^2*(1-t)*ctrlPoly(:,3)+t^3*ctrlPoly(:,4);
% point = (1-t)^5*ctrlPoly(:,1)+5*(1-t)^4*t*ctrlPoly(:,2)+10*(1-t)^3*t^2*ctrlPoly(:,3)+10*(1-t)^2*t^3*ctrlPoly(:,3)+5*(1-t)^1*t^4*ctrlPoly(:,4)+(1-t)^5*ctrlPoly(:,5);
point = zeros(2,1);
for i=1:n+1
    point = point + (factorial(n)/(factorial(i-1)*factorial(n-i+1)))*(1-t)^(n+1-i)*t^(i-1)*ctrlPoint(:,i);
end
end