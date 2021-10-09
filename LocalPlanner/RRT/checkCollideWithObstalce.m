function [isCollide]=checkCollideWithObstalce(point,obs)
obs_num=size(obs,1);
isCollide=0;
for i=1:obs_num
    obs_start=[obs(i,1),obs(i,2)];
    obs_end=[obs(i,3),obs(i,4)];
    if ((point(1)>=min(obs_start(1),obs_end(1)) && point(1)<=max(obs_start(1),obs_end(1))) && (point(2)>=min(obs_start(2),obs_end(2)) && point(2)<=max(obs_start(2),obs_end(2))))
        isCollide=1;
        return;
    end
end
end