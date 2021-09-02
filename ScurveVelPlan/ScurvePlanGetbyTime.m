%% 根据当前运动过时间判断规划中的速度，加速度，距离

function [tPlan,aPlan,vPlan,dPlan] = ScurvePlanGetbyTime(t,e)
stage = size(t,1);
num = 1000;
tPlan = linspace(0,sum(t(1:stage)),num);
dPlan = [];
aPlan = [];
vPlan = [];
t = [0;t];
for i = 1:num
    tNow = tPlan(i);
%%
    for k = stage : -1 : 1
        if (tNow>=sum(t(1:k)))
            dt = tNow-sum(t(1:k));
            j = k;
            break;
        end
    end
%%
%     if (tNow>sum(t(1:6)))
%         dt = tNow-sum(t(1:6));
%         j = 7;
%     elseif (tNow>sum(t(1:5)))
%         dt = tNow-sum(t(1:5));
%         j = 6;
%     elseif (tNow>sum(t(1:4)))
%         dt = tNow-sum(t(1:4));
%         j = 5;
%     elseif (tNow>sum(t(1:3)))
%         dt = tNow-sum(t(1:3));
%         j = 4;
%     elseif (tNow>sum(t(1:2)))
%         dt = tNow-sum(t(1:2));
%         j = 3;
%     elseif (tNow>sum(t(1)))
%         dt = tNow-sum(t(1));
%         j = 2;
%     else
%         dt = tNow;
%         j = 1;
%     end
%%
    dPlan = [dPlan,e(4,j)*dt^3+e(3,j)*dt^2+e(2,j)*dt+e(1,j)];
    vPlan = [vPlan,e(4,j)*3*dt^2+e(3,j)*2*dt+e(2,j)];
    aPlan = [aPlan,6*e(4,j)*dt+2*e(3,j)];
end
end