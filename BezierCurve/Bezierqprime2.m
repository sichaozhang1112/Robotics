function [point] = Bezierqprime2(ctrlPoint,t,n)
% point = 6*(1-t)*(ctrlPoly(:,3)-2*ctrlPoly(:,2)+ctrlPoly(:,1))+6*t*(ctrlPoly(:,4)-2*ctrlPoly(:,3)+ctrlPoly(:,2));
% n=3;
point = zeros(2,1);
for i=1:n-1
    point = point + n*(n-1)*(factorial(n-2)/(factorial(i-1)*factorial(n-i-1)))*(1-t)^(n-i-1)*t^(i-1)*(ctrlPoint(:,i+2)-2*ctrlPoint(:,i+1)+ctrlPoint(:,i));
end 
end