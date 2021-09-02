function [point] = Bezierqprime(ctrlPoint,t,n)
% point = 3*(1-t)^2*(ctrlPoly(:,2)-ctrlPoly(:,1))+6*(1-t)*t*(ctrlPoly(:,3)-ctrlPoly(:,2))+3*t^2*(ctrlPoly(:,4)-ctrlPoly(:,3));
% n=3;
point = zeros(2,1);
for i=1:n
    point = point + n*(factorial(n-1)/(factorial(i-1)*factorial(n-i)))*(1-t)^(n-i)*t^(i-1)*(ctrlPoint(:,i+1)-ctrlPoint(:,i));
end 
end