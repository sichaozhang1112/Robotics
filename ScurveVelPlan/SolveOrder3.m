%% 求解三次方程式 
% a*x^3+b*x^2+c*x+d=0,x_init为解的第一次猜想值
function [x] = SolveOrder3(a,b,c,d,x_init)
x = 0;
x0 = x_init;
x1 = x_init;

for i = 1:20
    x0 = x1;
    f = ((a*x0+b)*x0+c)*x0+d;
    f1 = (3*a*x0+2*b)*x0+c;
    x1 = x0-f/f1;
    if (abs(x0-x1))<0.001
        break;
    end
end

x = x0;
if (x<0)
    x = 0;
end
end

