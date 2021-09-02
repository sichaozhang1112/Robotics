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