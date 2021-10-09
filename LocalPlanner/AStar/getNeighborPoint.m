function [neighbors] = getNeighborPoint(point,env,obs)
neighbors=[];
dir=[[1,0];[-1,0];[0,1];[0,-1];
    [1,1];[1,-1];[-1,1];[-1,-1]];
% dir=[[1,0];[-1,0];[0,1];[0,-1]];
for i=1:size(dir,1)
    next=point+dir(i,:);
    isCollide=checkCollideWithObstalce(next,obs);
    isOutOfBorder=checkOutOfBorder(next,env);
    if (isCollide || isOutOfBorder)
        continue;
    end
    neighbors=[neighbors;next];
end
end