clear all;
close all;
clc;
warning off;

%%???????????????????????????????
%min x1^2+x2^2-2*x1+2*x2+2
%s.t. -x1+x2>=-1
%     x2>=-2
% H = [2 0;
%      0 2];
% c = [-2;2];
% A=[-1 1;
%     0 1];
% b=[-1;-2];
% m=2;
% delta = 0.1;
% p = 0.9;
% x = [-1;1];
% y = [1;1];
% w = [1;1];

% {
%min 9*x1^2+9*x2^2-30*x1-72*x2
%s.t. -2*x1-x2>=-4;
%      x1>=0
%      x2>=0
% H=[18 0;
%    0  18];
% c=[-30;-72];
% A=[-2 -1;
%     1  0;
%     0  1];
% b=[-4;0;0];
% m=2;
% delta = 0.1;
% p = 0.9;
% x = [-1;1];
% y = [1;1;1];
% w = [1;1;1];
% }

%min x1^2-x1*x2+x2^2-3*x1
%s.t. -x1-x2>=-2
%     x1>=0
%     x2>=0

H=[2 -1;
   -1 2];
c=[-3;0];
A=[-1 -1;
    1 0;
    0 1];
b=[-2;0;0];
m=2;
delta = 0.1;
p = 0.9;
x = [-1;1];
y = [1;1;1];
w = [1;1;1];

%{
%min 2*x1^2+x2^2-2*x1*x2-6*x1-2*x2
%s.t. -x1-x2>=-2
%     -2x1+x2>=-2
%     x1>=0
%     x2>=0
H=[4 -2;
   -2 2];
c=[-6;-2];
A=[-1 -1;
    -2 1;
    1 0;
    0 1];
b=[-2;-2;0;0];
m=2;
delta = 0.1;
p = 0.9;
x = [-1;1];
y = [1;1;1;1];
w = [1;1;1;1];
%}

%{
%min 2*x1^2+2*x2^2+x3^2+2*x1*x2+2*x1*x3-8*x1-6*x2-4*x2+9
%s.t.  -x1-x2-3>=-3
%      x1>=0
%      x2>=0
%      x3>=0

H=[4 2 2;
   2 4 0;
   2 0 2];
c=[-8;-6;-4];
A=[-1 -1 -1;
    1  0  0;
    0  1  0;
    0  0  1];
b=[-3;0;0;0];
m=9;
delta = 0.1;
p = 0.9;
x = [-1;-1;-1];
y = [1;1;1;1];
w = [1;1;1;1];
%}

%{
%min -2*x1+3*x2-x3
%s.t. x1+x2+x3<=10
%     2*x1-x2-2*x3<=8
%     0<=x1<=4
%     0<=x2<=4
%     -1<=x3<=2
H=zeros(3,3);
c=[-2;3;-1];
A=[-1 -1 -1;
   -2 1 2;
   1 0 0 ;
   -1 0 0;
   0 1 0;
   0 -1 0;
   0 0 1;
   0 0 -1];

b=[-10;-8;0;-4;0;-4;-1;-2];
m=2;
x= rand(3,1);
y = rand(8,1);
w = rand(8,1);
delta = 0.1;
p = 0.9;
%}

%%?????????????
while 1
  
    rou = b - A*x + w;
    sigma = c + H*x - A'*y;
    gama = y'*w;
    mu = delta*gama/m;
    
    dxy = inv([-H A';A diag((1./y).*w)])*[sigma;[b-A*x+mu*(1./y)]];
    
    dx = dxy(1:length(x));
    dy = dxy(end-length(y)+1:end);  
    dw = 1./y.*(mu-y.*w-w.*dy);
    
    lambda = min([p*(1/max([-(dy./y);-(dw./w)])) 1]);
    
    x = x + lambda * dx;
    y = y + lambda * dy;
    w = w + lambda * dw;
    
    if norm(dx)<1e-10
        x
        break;
    end
    
end

%%???????
[x1,x2]=meshgrid(-1:0.02:1.5,-2.5:0.02:0);
z1 = x1.^2+x2.^2-2*x1+2*x2+2;
mesh(x1,x2,z1);
hold on;

z = -x1+x2;
ind = z>=-1;
X1 = x1.*ind;
X2 = x2.*ind;
scatter1 = scatter(X1(:),X2(:),'r.','MarkerFaceColor','r','MarkerEdgeColor','r');       %??????
scatter1.MarkerFaceAlpha = .1;
scatter1.MarkerEdgeAlpha = .1;

z = x2;
ind = z>=-2;
X1 = x1.*ind;
X2 = x2.*ind;
scatter2 = scatter(X1(:),X2(:),'b.','MarkerFaceColor','b','MarkerEdgeColor','b');
scatter2.MarkerFaceAlpha = .1;
scatter2.MarkerEdgeAlpha = .1;

plot3(x(1),x(2),x(1)^2+x(2)^2-2*x(1)+2*x(2)+2,'r*')