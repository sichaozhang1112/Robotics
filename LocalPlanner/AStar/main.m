clear all;
close all;
%% 设置
%环境设置
env_start = [0,0];
env_end = [10,10];
env = [env_start;env_end];
%输入起始点和终点
input_start = [0,0];
input_end = [10,10];
input= [input_start;input_end];
%障碍物
obs_num=30;
obs = zeros(obs_num,4);
for i=1:obs_num
    obs_tmp(1,1) = round(rand(1)*1+1*i-1);
    obs_tmp(1,2) = round(rand(1)*10);
    if (obs_tmp(1,1)<=env_start(1)) 
        obs_tmp(1,1)=env_start(1)+1;
    elseif (obs_tmp(1,1)>=env_end(1))
        obs_tmp(1,1)=env_end(1)-1;
    end
    if (obs_tmp(1,2)<=env_start(2)) 
        obs_tmp(1,2)=env_start(2)+1;
    elseif (obs_tmp(1,2)>=env_end(2))
        obs_tmp(1,2)=env_end(2)-1;
    end
    obs_tmp(1,3) = obs_tmp(1,1) + round(rand(1))*1+0.5;
    obs_tmp(1,4) = obs_tmp(1,2) + round(rand(1))*1+0.5;
    if (obs_tmp(1,3)<=env_start(1)) 
        obs_tmp(1,3)=env_start(1)+1;
    elseif (obs_tmp(1,3)>=env_end(1))
        obs_tmp(1,3)=env_end(1)-1;
    end
    if (obs_tmp(1,4)<=env_start(2)) 
        obs_tmp(1,4)=env_start(2)+1;
    elseif (obs_tmp(1,4)>=env_end(2))
        obs_tmp(1,4)=env_end(2)-1;
    end
    obs(i,:)=obs_tmp;
end

%% 规划
g=1;h=1;
% g=0,h=1 BFS
% g=1,h=0 Dijkstra
path=PlannerAStar(input,env,obs,g,h);

%% 绘制
figure();
%起点终点
scatter(input_start(1),input_start(2),'b','lineWidth',2);hold on;
scatter(input_end(1),input_end(2),'b','lineWidth',2);hold on;
%障碍物
for i=1:size(obs,1)
    obs_tmp=obs(i,:);
    obs_point(1,:) = [obs_tmp(1),obs_tmp(2)];
    obs_point(2,:) = [obs_tmp(3),obs_tmp(2)];
    obs_point(3,:) = [obs_tmp(3),obs_tmp(4)];
    obs_point(4,:) = [obs_tmp(1),obs_tmp(4)];
    for j=1:4
        x_tmp = [obs_point(j,1),obs_point(mod(j,4)+1,1)];
        y_tmp = [obs_point(j,2),obs_point(mod(j,4)+1,2)];
        plot(x_tmp,y_tmp,'r','lineWidth',1);hold on;
    end
end
% 路径
for i=2:size(path,1)
    x_tmp = [path(i-1,1),path(i,1)];
    y_tmp = [path(i-1,2),path(i,2)];
    plot(x_tmp,y_tmp,'k');hold on;
end
xlim([env_start(1),env_end(1)]);
ylim([env_start(2),env_end(2)]);
axis equal;
