function [node_new]=updateNewState(node_near,node_rand,step_len)

dis=getPointsDistance(node_near,node_rand);
if (dis<=step_len)
    node_new=node_rand;
else
    dir=atan2(node_rand(2)-node_near(2),node_rand(1)-node_near(1));
    node_new=node_near+[cos(dir),sin(dir)]*step_len;
end

end