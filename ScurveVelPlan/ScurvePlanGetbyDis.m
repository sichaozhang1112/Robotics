%% 根据当前运动过距离判断规划中的速度，加速度，距离

function [tPlan,vPlan,dPlan] = ScurvePlanGetbyDis(s,v_init,a_init,j,t,v,d,a_acc,a_dec)
num = 1000;
dPlan = linspace(0,s,num);
tPlan = [];
vPlan = [];
for i = 1:num
    dNow = dPlan(i);
    if (dNow>d(6))
        e3 = j/6;
        e2 = -0.5*a_dec;
        e1 = v(6);
        e0 = -(dNow-d(6));
        x0 = t(7)/2;
        tNow = SolveOrder3(e3,e2,e1,e0,x0);
        tPlan = [tPlan,tNow+sum(t(1:6))];
        vPlan = [vPlan,e3*3*tNow^2+e2*2*tNow+e1];
    elseif (dNow>d(5))
        e3 = 0;
        e2 = -0.5*a_dec;
        e1 = v(5);
        e0 = -(dNow-d(5));
        x0 = t(6)/2;
        tNow = SolveOrder3(e3,e2,e1,e0,x0);
        tPlan = [tPlan,tNow+sum(t(1:5))];
        vPlan = [vPlan,e3*3*tNow^2+e2*2*tNow+e1];
    elseif (dNow>d(4))
        e3 = -j/6;
        e2 = 0;
        e1 = v(4);
        e0 = -(dNow-d(4));
        x0 = t(5)/2;
        tNow = SolveOrder3(e3,e2,e1,e0,x0);
        tPlan = [tPlan,tNow+sum(t(1:4))];
        vPlan = [vPlan,e3*3*tNow^2+e2*2*tNow+e1];
    elseif (dNow>d(3))
        e3 = 0;
        e2 = 0;
        e1 = v(3);
        e0 = -(dNow-d(3));
        x0 = t(4)/2;
        tNow = SolveOrder3(e3,e2,e1,e0,x0);
        tPlan = [tPlan,tNow+sum(t(1:3))];
        vPlan = [vPlan,e3*3*tNow^2+e2*2*tNow+e1];
    elseif (dNow>d(2))
        e3 = -j/6;
        e2 = 1/2*a_acc;
        e1 = v(2);
        e0 = -(dNow-d(2));
        x0 = t(3)/2;
        tNow = SolveOrder3(e3,e2,e1,e0,x0);
        tPlan = [tPlan,tNow+sum(t(1:2))];
        vPlan = [vPlan,e3*3*tNow^2+e2*2*tNow+e1];
    elseif (dNow>d(1))
        e3 = 0;
        e2 = 1/2*a_acc;
        e1 = v(1);
        e0 = -(dNow-d(1));
        x0 = t(2)/2;
        tNow = SolveOrder3(e3,e2,e1,e0,x0);
        tPlan = [tPlan,tNow+sum(t(1))];
        vPlan = [vPlan,e3*3*tNow^2+e2*2*tNow+e1];
    else
        e3 = j/6;
        e2 = 1/2*a_init;
        e1 = v_init;
        e0 = -dNow;
        x0 = t(1)/2;
        tNow = SolveOrder3(e3,e2,e1,e0,x0);
        tPlan = [tPlan,tNow];
        vPlan = [vPlan,e3*3*tNow^2+e2*2*tNow+e1];
    end
end
end