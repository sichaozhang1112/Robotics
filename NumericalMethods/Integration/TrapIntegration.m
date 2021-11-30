%% Trap 积分
% 针对于多项式曲线的积分
% 输入：起始点x0，终点x1，多项式系数Q
% 输出：区域内曲线长度 S

function [ S ] = TrapIntegration( x0,x1,Q )

h = 0.00001;
x=x0:h:x1;
y = Q(1,1)+Q(2,1)*x+Q(3,1)*x.^2+Q(4,1)*x.^3+Q(5,1)*x.^4+Q(6,1)*x.^5;
dy = diff(y)/h;
S = h*trapz((1+dy.^2).^0.5);

end