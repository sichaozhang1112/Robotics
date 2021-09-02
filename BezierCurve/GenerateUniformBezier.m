function [points] = GenerateUniformBezier(start,target,n)
points = zeros(2,n+1);
thetas = zeros(1,2);
thetas(1) = start(3,1);
thetas(2) = target(3,1);
points(:,1) = start(1:2,1);
points(:,n+1) = target(1:2,1);
dis = PointDistance(points(:,1),points(:,end));
for i=2:floor((n+1)/2)
    points(:,i)=points(:,1)+[cos(thetas(1));sin(thetas(1))]*(i-1)*dis/n;
end
for i=floor((n+1)/2)+1:n
    points(:,i)=points(:,n+1)-[cos(thetas(2));sin(thetas(2))]*(n+1-i)*dis/n;
end
end