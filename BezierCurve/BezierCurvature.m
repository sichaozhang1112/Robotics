function [curvature] = BezierCurvature(ctrlPoly,t,n)
bezierq = Bezierq(ctrlPoly,t,n);
bezierqprime = Bezierqprime(ctrlPoly,t,n);
bezierqprime2 = Bezierqprime2(ctrlPoly,t,n);
curvature = (bezierqprime(1)*bezierqprime2(2)-bezierqprime(2)*bezierqprime2(1))/sqrt((bezierqprime(1)^2+bezierqprime(2)^2)^3);
end