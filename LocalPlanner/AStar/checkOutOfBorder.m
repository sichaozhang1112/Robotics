function [isOutOfBorder]=checkOutOfBorder(point,env)
env_start=env(1,:);
env_end=env(2,:);
isOutOfBorder=1;
if ((point(1)>=min(env_start(1),env_end(1)) && point(1)<=max(env_start(1),env_end(1))) && (point(2)>=min(env_start(2),env_end(2)) && point(2)<=max(env_start(2),env_end(2))))
        isOutOfBorder=0;
end
end