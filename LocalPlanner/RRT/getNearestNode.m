function [node_near] = getNearestNode(tree_node,node_rand)
dis_min=inf;
for i=1:size(tree_node)
    node=tree_node(i,:);
    dis=getPointsDistance(node,node_rand);
    if (dis<dis_min)
        node_near=node;
        dis_min=dis;
    end
end

end