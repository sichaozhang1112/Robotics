%% 标准的S型速度规划
% 包含变速段+匀速段+减速段

function [t,e,CanPlan,type] = ScurveVelocityPlan(s,v_max,a_max_acc,a_max_dec,v_init,a_init,v_end,j)
fprintf('S Curve Velocity Plan:\n');
CanPlan = 1;
t = zeros(7,1);
v = zeros(7,1);
d = zeros(7,1);
index = 1;
count = 0;
% 
while (index==1)    
%acc
if v_max>v_init
    if a_init > a_max_acc
        if v_max - v_init >= a_init^2/(2*j)
            fprintf('状况1：减加速+（匀加速）+减加速\n');
            type = 1;
            %减加速+（匀加速）+减加速
            v_acc = v_max - v_init;
            v_acc_min = a_init^2/(2*j);
            a_acc = a_max_acc;
            t(1) = (a_init-a_acc)/j;
            t(2) = (v_acc-v_acc_min)/a_acc;
            t(3) = a_acc/j;
            t_acc = t(1)+t(2)+t(3);
            v(1) = -1/2*j*t(1)^2+a_init*t(1)+v_init;
            v(2) = a_acc*t(2)+v(1);
            v(3) = v_max;
            d(1) =- j*t(1)^3/6+a_init*t(1)^2/2+v_init*t(1);
            d(2) = a_acc*t(2)^2/2+v(1)*t(2);
            d(3) =- j*t(3)^3/6+a_acc*t(3)^2/2+v(2)*t(3);
            s_acc = d(1)+d(2)+d(3);
            e(4,1) = -j/6;e(3,1) = 1/2*a_init;e(2,1) = v_init;
            e(4,2) = 0;e(3,2) = 1/2*a_acc;e(2,2) = v(1);
            e(4,3) = -j/6;e(3,3) = 1/2*a_acc;e(2,3) = v(2);
        else
            v_acc = v_max - v_init;
            v_acc_min = (a_init^2-2*a_max_dec^2)/(2*j);
            if v_acc < v_acc_min 
                %减加速 + 加减速+（匀减速）+ 减减速
                fprintf('状况2：减加速 + 加减速+（匀减速）+ 减减速\n');
                type = 2;
                a_acc = a_max_dec;
                t(1) = (a_init+a_acc)/j;
                t(2) = (v_acc-v_acc_min)/-a_acc;
                t(3) = a_acc/j;
                t_acc = t(1)+t(2)+t(3);
                v(1) = -1/2*j*t(1)^2+a_init*t(1)+v_init;
                v(2) = -a_acc*t(2)+v(1);
                v(3) = v_max;
                d(1) = -j*t(1)^3/6+a_init*t(1)^2/2+v_init*t(1);
                d(2) = -a_acc*t(2)^2/2+v(1)*t(2);
                d(3) = j*t(3)^3/6-a_acc*t(3)^2/2+v(2)*t(3);
                s_acc = d(1)+d(2)+d(3);
                e(4,1) = -j/6;e(3,1) = 1/2*a_init;e(2,1) = v_init;
                e(4,2) = 0;e(3,2) = -1/2*a_acc;e(2,2) = v(1);
                e(4,3) = j/6;e(3,3) = -1/2*a_acc;e(2,3) = v(2);
            else
                %减加速 + 加减速 + 减减速
                fprintf('状况3：减加速 + 加减速 + 减减速\n');
                type = 3;
                a_acc = sqrt((a_init^2-2*j*v_acc)/2);
                t(1) = (a_init+a_acc)/j;
                t(2) = 0;
                t(3) = a_acc/j;
                t_acc = t(1)+t(2)+t(3);
                v(1) = -1/2*j*t(1)^2+a_init*t(1)+v_init;
                v(2) = -a_acc*t(2)+v(1);
                v(3) = v_max;
                d(1) =-j*t(1)^3/6+a_init*t(1)^2/2+v_init*t(1);
                d(2) = -a_acc*t(2)^2/2+v(1)*t(2);
                d(3) = j*t(3)^3/6-a_acc*t(3)^2/2+v(2)*t(3);
                s_acc = d(1)+d(2)+d(3);
                e(4,1) = -j/6;e(3,1) = 1/2*a_init;e(2,1) = v_init;
                e(4,2) = 0;e(3,2) = -1/2*a_acc;e(2,2) = v(1);
                e(4,3) = j/6;e(3,3) = -1/2*a_acc;e(2,3) = v(2);
            end
        end
    else
        v_acc = v_max - v_init;
        v_acc_min = (2*a_max_acc^2 - a_init^2)/(2*j);
        if v_acc >= v_acc_min
            %加加速 + （匀加速）+ 减加速
            fprintf('状况4：加加速 + （匀加速）+ 减加速\n');
            type = 4;
            a_acc = a_max_acc;
            t(1) = (a_acc-a_init)/j;
            t(2) = (v_acc-v_acc_min)/a_acc;
            t(3) = a_acc/j;
            t_acc = t(1)+t(2)+t(3);
            v(1) = 1/2*j*t(1)^2+a_init*t(1)+v_init;
            v(2) = a_acc*t(2)+v(1);
            v(3) = v_max;
            d(1) = j*t(1)^3/6+a_init*t(1)^2/2+v_init*t(1);
            d(2) = a_acc*t(2)^2/2+v(1)*t(2);
            d(3) = -j*t(3)^3/6+a_acc*t(3)^2/2+v(2)*t(3);
            s_acc = d(1)+d(2)+d(3);
            e(4,1) = j/6;e(3,1) = 1/2*a_init;e(2,1) = v_init;
            e(4,2) = 0;e(3,2) = 1/2*a_acc;e(2,2) = v(1);
            e(4,3) = -j/6;e(3,3) = 1/2*a_acc;e(2,3) = v(2);
        else
            %加加速 + 减加速
            fprintf('状况5：加加速 + 减加速\n');
            type = 5;
            a_acc = sqrt((2*v_acc*j+a_init^2)/2);
            t(1) = (a_acc-a_init)/j;
            t(2) = 0;
            t(3) = a_acc/j;
            v(1) = 1/2*j*t(1)^2+a_init*t(1)+v_init;
            v(2) = a_acc*t(2)+v(1);
            v(3) = v_max;
            d(1) = j*t(1)^3/6+a_init*t(1)^2/2+v_init*t(1);
            d(2) = a_acc*t(2)^2/2+v(1)*t(2);
            d(3) =-j*t(3)^3/6+a_acc*t(3)^2/2+v(2)*t(3);
            s_acc = d(1)+d(2)+d(3);
            e(4,1) = j/6;e(3,1) = 1/2*a_init;e(2,1) = v_init;
            e(4,2) = 0;e(3,2) = 1/2*a_acc;e(2,2) = v(1);
            e(4,3) = -j/6;e(3,3) = 1/2*a_acc;e(2,3) = v(2);
        end
    end
elseif v_max<v_init
    if a_init < -a_max_dec
        v_acc = v_init - v_max;
        v_acc_min = (a_init^2)/(2*j);
        if (v_acc>=v_acc_min)
            %减减速 + （匀减速） + 减减速
            fprintf('状况6：减减速 + （匀减速） + 减减速\n');
            type = 6;
            a_acc = a_max_dec;
            t(1) = (-a_acc-a_init)/j;
            t(2) = (v_acc-v_acc_min)/a_acc;
            t(3) = a_acc/j;
            t_acc = t(1)+t(2)+t(3);
            v(1) = 1/2*j*t(1)^2+a_init*t(1)+v_init;
            v(2) = -a_acc*t(2)+v(1);
            v(3) = v_max;
            d(1) = j*t(1)^3/6+a_init*t(1)^2/2+v_init*t(1);
            d(2) = -a_acc*t(2)^2/2+v(1)*t(2);
            d(3) = j*t(3)^3/6-a_acc*t(3)^2/2+v(2)*t(3);
            s_acc = d(1)+d(2)+d(3);
            e(4,1) = j/6;e(3,1) = 1/2*a_init;e(2,1) = v_init;
            e(4,2) = 0;e(3,2) = -1/2*a_acc;e(2,2) = v(1);
            e(4,3) = j/6;e(3,3) = -1/2*a_acc;e(2,3) = v(2);
        else
            v_acc = v_init - v_max;
            v_acc_min = (a_init^2-2*a_max_acc^2)/(2*j);
            if v_acc < v_acc_min
                %减减速 + 加加速 + （匀加速）+ 减加速
                fprintf('状况7：减减速 + 加加速 + （匀加速）+ 减加速\n');
                type = 7;
                a_acc = a_max_acc;
                t(1) = (a_acc-a_init)/j;
                t(2) = (v_acc-v_acc_min)/-a_acc;
                t(3) = a_acc/j;
                t_acc = t(1)+t(2)+t(3);
                v(1) = 1/2*j*t(1)^2+a_init*t(1)+v_init;
                v(2) = a_acc*t(2)+v(1);
                v(3) = v_max;
                d(1) = j*t(1)^3/6+a_init*t(1)^2/2+v_init*t(1);
                d(2) = a_acc*t(2)^2/2+v(1)*t(2);
                d(3) = -j*t(3)^3/6+a_acc*t(3)^2/2+v(2)*t(3);
                s_acc = d(1)+d(2)+d(3);
                e(4,1) = j/6;e(3,1) = 1/2*a_init;e(2,1) = v_init;
                e(4,2) = 0;e(3,2) = 1/2*a_acc;e(2,2) = v(1);
                e(4,3) = -j/6;e(3,3) = 1/2*a_acc;e(2,3) = v(2);
            else
                %减减速 + 加加速 + 减加速
                fprintf('状况8：减减速 + 加加速 + 减加速\n');
                type = 8;
                a_acc = sqrt((a_init^2-2*j*v_acc)/2);
                t(1) = (a_acc-a_init)/j;
                t(2) = 0;
                t(3) = a_acc/j;
                t_acc = t(1)+t(2)+t(3);
                v(1) =1/2*j*t(1)^2+a_init*t(1)+v_init;
                v(2) = a_acc*t(2)+v(1);
                v(3) = v_max;
                d(1) = j*t(1)^3/6+a_init*t(1)^2/2+v_init*t(1);
                d(2) = a_acc*t(2)^2/2+v(1)*t(2);
                d(3) = -j*t(3)^3/6+a_acc*t(3)^2/2+v(2)*t(3);
                s_acc = d(1)+d(2)+d(3);
                e(4,1) = j/6;e(3,1) = 1/2*a_init;e(2,1) = v_init;
                e(4,2) = 0;e(3,2) = 1/2*a_acc;e(2,2) = v(1);
                e(4,3) = -j/6;e(3,3) = 1/2*a_acc;e(2,3) = v(2);
            end
        end
    else
        v_acc = v_init - v_max;
        v_acc_min = (2*a_max_dec^2-a_init^2)/(2*j);
        if v_acc >= v_acc_min
            %加减速 + （匀减速）+ 减减速
            fprintf('状况9：加减速 + （匀减速）+ 减减速\n');
            type = 9;
            a_acc = a_max_dec;
            t(1) = (a_acc+a_init)/j;
            t(2) = (v_acc-v_acc_min)/a_acc;
            t(3) = a_acc/j;
            t_acc = t(1)+t(2)+t(3);
            v(1) = -1/2*j*t(1)^2+a_init*t(1)+v_init;
            v(2) = -a_acc*t(2)+v(1);
            v(3) = v_max;
            d(1) = -j*t(1)^3/6+a_init*t(1)^2/2+v_init*t(1);
            d(2) = -a_acc*t(2)^2/2+v(1)*t(2);
            d(3) = j*t(3)^3/6-a_acc*t(3)^2/2+v(2)*t(3);
            s_acc = d(1)+d(2)+d(3);
            e(4,1) = -j/6;e(3,1) = 1/2*a_init;e(2,1) = v_init;
            e(4,2) = 0;e(3,2) = -1/2*a_acc;e(2,2) = v(1);
            e(4,3) = j/6;e(3,3) = -1/2*a_acc;e(2,3) = v(2);
        else
            %加减速 + 减减速
            fprintf('状况10：加减速 + 减减速\n');
            type = 10;
            a_acc = sqrt((2*v_acc*j+a_init^2)/2);
            t(1) = (a_acc+a_init)/j;
            t(2) = 0;
            t(3) = a_acc/j;
            t_acc = t(1)+t(2)+t(3);
            v(1) = -1/2*j*t(1)^2+a_init*t(1)+v_init;
            v(2) = -a_acc*t(2)+v(1);
            v(3) = v_max;
            d(1) = -j*t(1)^3/6+a_init*t(1)^2/2+v_init*t(1);
            d(2) = -a_acc*t(2)^2/2+v(1)*t(2);
            d(3) = j*t(3)^3/6-a_acc*t(3)^2/2+v(2)*t(3);
            s_acc = d(1)+d(2)+d(3);
            e(4,1) = -j/6;e(3,1) = 1/2*a_init;e(2,1) = v_init;
            e(4,2) = 0;e(3,2) = -1/2*a_acc;e(2,2) = v(1);
            e(4,3) = j/6;e(3,3) = -1/2*a_acc;e(2,3) = v(2);
        end
    end
elseif v_max == v_init
    if a_init > 0
         v_acc = v_max - v_init;
        v_acc_min = (a_init^2-2*a_max_dec^2)/(2*j);
        if v_acc < v_acc_min 
            %减加速 + 加减速+（匀减速）+ 减减速
            fprintf('状况11：减加速 + 加减速+（匀减速）+ 减减速\n');
            type = 2;
            a_acc = a_max_dec;
            t(1) = (a_init+a_acc)/j;
            t(2) = (v_acc-v_acc_min)/-a_acc;
            t(3) = a_acc/j;
            t_acc = t(1)+t(2)+t(3);
            v(1) = -1/2*j*t(1)^2+a_init*t(1)+v_init;
            v(2) = -a_acc*t(2)+v(1);
            v(3) = v_max;
            d(1) = -j*t(1)^3/6+a_init*t(1)^2/2+v_init*t(1);
            d(2) = -a_acc*t(2)^2/2+v(1)*t(2);
            d(3) = j*t(3)^3/6-a_acc*t(3)^2/2+v(2)*t(3);
            s_acc = d(1)+d(2)+d(3);
            e(4,1) = -j/6;e(3,1) = 1/2*a_init;e(2,1) = v_init;
            e(4,2) = 0;e(3,2) = -1/2*a_acc;e(2,2) = v(1);
            e(4,3) = j/6;e(3,3) = -1/2*a_acc;e(2,3) = v(2);
        else
            %减加速 + 加减速 + 减减速
            fprintf('状况12：减加速 + 加减速 + 减减速\n');
            type = 3;
            a_acc = sqrt((a_init^2-2*j*v_acc)/2);
            t(1) = (a_init+a_acc)/j;
            t(2) = 0;
            t(3) = a_acc/j;
            t_acc = t(1)+t(2)+t(3);
            v(1) = -1/2*j*t(1)^2+a_init*t(1)+v_init;
            v(2) = -a_acc*t(2)+v(1);
            v(3) = v_max;
            d(1) =-j*t(1)^3/6+a_init*t(1)^2/2+v_init*t(1);
            d(2) = -a_acc*t(2)^2/2+v(1)*t(2);
            d(3) = j*t(3)^3/6-a_acc*t(3)^2/2+v(2)*t(3);
            s_acc = d(1)+d(2)+d(3);
            e(4,1) = -j/6;e(3,1) = 1/2*a_init;e(2,1) = v_init;
            e(4,2) = 0;e(3,2) = -1/2*a_acc;e(2,2) = v(1);
            e(4,3) = j/6;e(3,3) = -1/2*a_acc;e(2,3) = v(2);
        end
    elseif a_init < 0
        v_acc = v_init - v_max;
        v_acc_min = (a_init^2-2*a_max_acc^2)/(2*j);
        if v_acc < v_acc_min
            %减减速 + 加加速 + （匀加速）+ 减加速
            fprintf('状况13：减减速 + 加加速 + （匀加速）+ 减加速\n');
            type = 7;
            a_acc = a_max_acc;
            t(1) = (a_acc-a_init)/j;
            t(2) = (v_acc-v_acc_min)/-a_acc;
            t(3) = a_acc/j;
            t_acc = t(1)+t(2)+t(3);
            v(1) = 1/2*j*t(1)^2+a_init*t(1)+v_init;
            v(2) = a_acc*t(2)+v(1);
            v(3) = v_max;
            d(1) = j*t(1)^3/6+a_init*t(1)^2/2+v_init*t(1);
            d(2) = a_acc*t(2)^2/2+v(1)*t(2);
            d(3) = -j*t(3)^3/6+a_acc*t(3)^2/2+v(2)*t(3);
            s_acc = d(1)+d(2)+d(3);
            e(4,1) = j/6;e(3,1) = 1/2*a_init;e(2,1) = v_init;
            e(4,2) = 0;e(3,2) = 1/2*a_acc;e(2,2) = v(1);
            e(4,3) = -j/6;e(3,3) = 1/2*a_acc;e(2,3) = v(2);
        else
            %减减速 + 加加速 + 减加速
            fprintf('状况14：减减速 + 加加速 + 减加速\n');
            type = 8;
            a_acc = sqrt((a_init^2-2*j*v_acc)/2);
            t(1) = (a_acc-a_init)/j;
            t(2) = 0;
            t(3) = a_acc/j;
            t_acc = t(1)+t(2)+t(3);
            v(1) =1/2*j*t(1)^2+a_init*t(1)+v_init;
            v(2) = a_acc*t(2)+v(1);
            v(3) = v_max;
            d(1) = j*t(1)^3/6+a_init*t(1)^2/2+v_init*t(1);
            d(2) = a_acc*t(2)^2/2+v(1)*t(2);
            d(3) = -j*t(3)^3/6+a_acc*t(3)^2/2+v(2)*t(3);
            s_acc = d(1)+d(2)+d(3);
            e(4,1) = j/6;e(3,1) = 1/2*a_init;e(2,1) = v_init;
            e(4,2) = 0;e(3,2) = 1/2*a_acc;e(2,2) = v(1);
            e(4,3) = -j/6;e(3,3) = 1/2*a_acc;e(2,3) = v(2);
        end    
    end
end
% dec
v_dec = v_max - v_end;
v_dec_min = a_max_dec^2/j;
if v_dec >= v_dec_min
    a_dec = a_max_dec;
    t(5) = a_dec/j;
    t(6) = (v_dec-v_dec_min)/a_dec;
    t(7) = a_dec/j;
else
    a_dec = sqrt(v_dec*j);
    t(5) = a_dec/j;
    t(6) = 0;
    t(7) = a_dec/j;
end
t_dec = t(5)+t(6)+t(7);
s_dec = ((v_max-v_end)/2+v_end)*t_dec;
v(5) = v_max-a_dec*t(5)/2;
v(6) = v(5)-a_dec*t(6);
v(7) = v_end;
d(7) = (v(6)*1/3+v_end*2/3)*t(7);
d(6) = (v(5)+v(6))*t(6)/2;
d(5) = s_dec-d(6)-d(7);
e(4,5) = -j/6;e(3,5) = 0;e(2,5) = v_max;e(1,5) =s-s_acc-s_dec;
e(4,6) = 0;e(3,6) = -1/2*a_dec;e(2,6) = v(5);
e(4,7) = j/6;e(3,7) = -1/2*a_dec;e(2,7) = v(6);
% vel
t(4) = (s-s_acc-s_dec)/v_max;
v(4) = v_max;
d(4) = s-s_acc-s_dec;
e(4,4) = 0;e(3,4)=0;e(2,4)=v(3);
if (t(4)<0)
    v_max = v_max*0.9;
    count = count + 1;
    if (count>20)
        CanPlan = 0;
        fprintf('Error: No Velocity Plan!!!\n');
        index=0;
    end
else if (t(1)<0 || t(2)<0 || t(3)<0 || t(5)<0 || t(6)<0 || t(7)<0)
        CanPlan = -1;
    fprintf('Error: No Velocity Plan!!!\n');
    index = 0;
else
    index = 0;
end
end

%
e(1,1) = 0;
for i = 1:6
    d(i+1) = d(i)+d(i+1);
    e(1,i+1) = d(i);
end
end