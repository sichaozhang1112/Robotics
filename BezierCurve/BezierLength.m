function [length] = BezierLength(ctrlPoint,n,dt)
length = 0;
for t=dt:dt:1
    length = length + norm(Bezierq(ctrlPoint,t,n)-Bezierq(ctrlPoint,t-dt,n));
end
end