function [path]=PlannerAStar(input,env,obs,g,h)
start=input(1,:);
target=input(2,:);
path=[];
cost=[];
env_start=env(1,:);
env_end=env(2,:);
map=zeros(env_end(1)-env_start(1)+1,env_end(2)-env_start(2)+1);
% ȷ���յ�����ڱ߽��ڲ�����ײ
if (checkCollideWithObstalce(start,obs) || checkCollideWithObstalce(target,obs) || checkOutOfBorder(start,env) || checkOutOfBorder(target,env))
    return;
end
path(1,:)=start;
cost(1,:)=0;
point_cur=start;

for i=1:10000
    if (point_cur==target)
        break;
    end
    map(point_cur(1)+1,point_cur(2)+1)=1;
    % ��ȡ��Χ��
    point_next=getNeighborPoint(point_cur,env,obs);
    if (size(point_next,1)==0)
        break;
    end
    % �Ų���Χ��
    cost(i+1,:)=Inf;
    for j=1:size(point_next,1)
        if (map(point_next(j,1)-env_start(1)+1,point_next(j,2)-env_start(2)+1)==1)
            continue;
        end
        % f = g + h
        % g Ϊ��ǰ�ڵ㵽ĸ�ڵ�ľ���
        % h Ϊ��ǰ�ڵ㵽�յ�ľ���
        new_cost=cost(i,:)+h*getPointsDistance(target,point_next(j,:))+g*getPointsDistance(point_cur,point_next(j,:));
        if (new_cost<cost(i+1,:))
            cost(i+1,:)=new_cost;
            path(i+1,:)=point_next(j,:);
        end
    end
    point_cur=path(end,:);
end  

end