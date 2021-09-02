function [points] = GenerateBezier5(start,target)
n=5;
points = zeros(2,n+1);
thetas = zeros(1,2);
thetas(1) = start(3,1);
thetas(2) = target(3,1);
points(:,1) = start(1:2,1);
points(:,n+1) = target(1:2,1);
dis = norm(points(:,1)-points(:,end));
t = dis/5*[1,2,2,1];
points(:,2) = points(:,1) + [cos(thetas(1));sin(thetas(1))]*t(1);
points(:,3) = points(:,1) + [cos(thetas(1));sin(thetas(1))]*t(2);
points(:,4) = points(:,6) - [cos(thetas(2));sin(thetas(2))]*t(3);
points(:,5) = points(:,6) - [cos(thetas(2));sin(thetas(2))]*t(4);
end