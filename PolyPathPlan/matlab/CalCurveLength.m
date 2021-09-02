function [length] = CalCurveLength(endpoint,Q)
    u = [0.56888889,0.47862876,0.47862876,0.23692689,0.23692689];
    v = [0,-0.53846931,0.53846931,-0.90617984,0.90617984];
    length = 0;
    x = [0,endpoint];
    for i = 1 : 5
    xtemp = v(i)*(x(end)-x(1))/2+(x(end)+x(1))/2;
    ytemp = Q(2,1)+Q(3,1)*2*xtemp+Q(4,1)*3*xtemp^2+Q(5,1)*4*xtemp^3+Q(6,1)*5*xtemp^4;
    dis = sqrt(1^2+ytemp^2);
    length = length + u(i)*dis;
    end
    length = length*(x(end)-x(1))/2;
end