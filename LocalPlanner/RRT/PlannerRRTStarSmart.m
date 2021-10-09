
function [path]=PlannerRRTStarSmart(input,env,obs,iter_max,step_len,goal_sample_rate,search_radius)
start=input(1,:);
target=input(2,:);
path=[];
cost=[];
env_start=env(1,:);
env_end=env(2,:);
% 确认终点起点在边界内并无碰撞
if (checkCollideWithObstalce(start,obs) || checkCollideWithObstalce(target,obs) || checkOutOfBorder(start,env) || checkOutOfBorder(target,env))
    return;
end
tree_node(1,:)=start;
tree_node_parent(1,:)=start;
% 
% for i=1:size(obs,1)
%     obs_start=[obs(i,1),obs(i,2)];
%     obs_end=[obs(i,3),obs(i,4)];
%     obs_point(1,:)=[obs_start(1),obs_end(1)];
%     obs_point(2,:)=[obs_start(1),obs_end(2)];
%     obs_point(3,:)=[obs_start(2),obs_end(2)];
%     obs_point(4,:)=[obs_start(2),obs_end(1)];
%     for j=1:4
%         for k=1:1000
%             dir=rand(1)*pi;
%             anchor=obs_point(j,:)+[cos(dir),sin(dir)]*step_len;
%             isCollide=checkCollideWithObstalce(anchor,obs);
%             isOutOfBorder=checkOutOfBorder(anchor,env);
%             if (isCollide==0&&isOutOfBorder==0)
%                 tree_node=[tree_node;anchor];
%                 break;
%             end
%         end
%     end
% end

for i=1:iter_max
    tree_node_num = size(tree_node,1);
    node_rand=getRandomNode(target,env,obs,goal_sample_rate);
    node_near=getNearestNode(tree_node,node_rand);
    node_new=updateNewState(node_near,node_rand,step_len);
    isCollide=checkLineCollideWithObstacle(node_new,node_near,obs);
    if (isCollide==0)
        node_parent=rechooseParentNode(tree_node,node_new,node_near,obs,search_radius);
        tree_node_parent=[tree_node_parent;node_parent];
        tree_node=[tree_node;node_new];
        figure(1)
        x_tmp = [node_new(1,1),node_parent(1,1)];
        y_tmp = [node_new(1,2),node_parent(1,2)];
        plot(x_tmp,y_tmp,'k');hold on;
        if(node_new==target)
            return;
        end
    end
end  

end