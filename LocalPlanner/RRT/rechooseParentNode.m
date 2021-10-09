function [node_parent] = rechooseParentNode(tree_node,node_new,node_near,obs,search_radius)
dis_min=inf;
start=tree_node(1,:);
node_parent=node_near;
for i=1:size(tree_node,1)
    node=tree_node(i,:);
    if (getPointsDistance(node,node_new)>search_radius)
        continue;
    end
    dis=getPointsDistance(node,node_new)+getPointsDistance(start,node);
    isCollide=checkLineCollideWithObstacle(node_new,node,obs);
    if (dis<dis_min && isCollide==0)
        node_parent=node;
        dis_min=dis;
    end
end

end