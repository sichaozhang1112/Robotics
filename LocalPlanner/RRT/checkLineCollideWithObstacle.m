function [isCollide]=checkLineCollideWithObstacle(node_new,node_near,obs)

isCollide=0;
isCollide=isCollide|checkCollideWithObstalce(node_new,obs);
isCollide=isCollide|checkCollideWithObstalce(node_near,obs);
if (isCollide)
    return;
end

for i=1:size(obs,1)
    obs_start=[obs(i,1),obs(i,2)];
    obs_end=[obs(i,3),obs(i,4)];
    obs_point(1,:)=[obs_start(1),obs_start(2)];
    obs_point(2,:)=[obs_start(1),obs_end(2)];
    obs_point(3,:)=[obs_end(1),obs_start(2)];
    obs_point(4,:)=[obs_end(1),obs_end(2)];
    isCollide=isCollide|checkLineInteractWithLine(node_new,node_near,obs_point(1,:),obs_point(2,:));
    isCollide=isCollide|checkLineInteractWithLine(node_new,node_near,obs_point(2,:),obs_point(3,:));
    isCollide=isCollide|checkLineInteractWithLine(node_new,node_near,obs_point(3,:),obs_point(4,:));
    isCollide=isCollide|checkLineInteractWithLine(node_new,node_near,obs_point(4,:),obs_point(1,:));
    if (isCollide)
        return;
    end
end

end