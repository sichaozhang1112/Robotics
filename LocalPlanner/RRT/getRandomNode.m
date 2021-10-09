function [node_rand] = getRandomNode(target,env,obs,goal_sample_rate)
node_rand=target;
if (rand(1)>goal_sample_rate)
    for i=1:10
        next_x=rand(1)*(env(2,1)-env(1,1))+env(1,1);
        next_y=rand(1)*(env(2,2)-env(1,2))+env(1,2);
        node_rand=[next_x,next_y];
        isCollide=checkCollideWithObstalce(node_rand,obs);
        isOutOfBorder=checkOutOfBorder(node_rand,env);
        if (isCollide || isOutOfBorder)
            continue;
        else
            return;
        end
    end
end

end