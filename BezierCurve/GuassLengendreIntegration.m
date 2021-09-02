function [integration] = GuassLengendreIntegration(ctrlPoint,n)
w = [0.56888889,0.47862876,0.47862876,0.23692689,0.23692689];
x = [0,-0.53846931,0.53846931,-0.90617984,0.90617984];
integration = 0;
for i=1:5
    ct = 0.5*(x(i)+1);
    point = Bezierqprime(ctrlPoint,ct,n);
    integration = integration + w(i)*0.5*norm(point);
end
end