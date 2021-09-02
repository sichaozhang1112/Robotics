%% 变速段规划测试
% 调用 ChangeVelPlan

close all;
clear all;

%% 给定参数
s  = 0.01; %距离
v_max = 0.4; %最大速度
a_max = 0.2; %最大加速度
a_min = -0.2; %最小加速度
v_init = 0.3738; % 初始速度
a_init = -0.19; % 初始加速度
v_end = 0.01; %结束速度
j = 10; 

%% 生成规划
[ t,e,type ] = ChangeVelPlan( v_init,v_end,a_init,a_max,a_min,j); %变速段规划

[tPlan,aPlan,vPlan,dPlan] = ScurvePlanGetbyTime(t,e); % 生成速度，加速度，距离的规划结果

%% 绘图
figure()
plot(tPlan,aPlan,'LineWidth',1.5,'color','r'); hold on;
% figure(2)
plot(tPlan,vPlan,'LineWidth',1.5,'color','b'); hold on;
% figure(3)
plot(tPlan,dPlan,'LineWidth',1.5,'color','g'); hold on;
legend('加速度','速度','路程');
xlabel('时间');
