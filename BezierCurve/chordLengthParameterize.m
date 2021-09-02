function [u] = chordLengthParameterize(points)
u=[0];
for i = 2:size(points,2)
    u(:,i) = u(:,i-1)+norm(points(:,i)-points(:,i-1));
end

for i = 1:size(u,2)
    u(:,i)=u(:,i)/u(:,end);
end
end
