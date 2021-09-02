a = 1;
b = 1;
c = 2;
d = 1;
xi = 0.9625;
x0 = xi;
x1 = xi;

for i = 1:20
    x0 = x1;
    f = ((a*x0+b)*x0+c)*x0+d;
    f1 = (3*a*x0+2*b)*x0+c;
    x1 = x0-f/f1;
    if (abs(x0-x1))<0.001
        break;
    end
end
x = x0
x1 = roots([a b c d])

