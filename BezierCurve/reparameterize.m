function [uPrime] = reparameterize(bezCurve,points,u)
for i = 1:size(points,2)
    uPrime(:,i) = newtonRaphsonRootFind(bezCurve,points(:,i),u(:,i));
end
end