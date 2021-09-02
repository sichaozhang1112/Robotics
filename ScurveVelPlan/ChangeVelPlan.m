%% 变速段规划
% 只可处理变速情况
% 输入初始速度，加速度，给定结束速度，结束加速度为0，以及加速度的上下限，jerk默认为2
function [ t,e,type ] = ChangeVelPlan( v_init,v_end,a_init,a_max,a_min,j)
t = zeros(3,1);
if v_end>v_init
    if a_init >= a_max
        if v_end - v_init >= a_init^2/(2*j)
            fprintf('状况1：减加速+（匀加速）+减加速\n');
            type = 1;
            %减加速+（匀加速）+减加速
            v_acc = v_end - v_init;
            v_acc_min = a_init^2/(2*j);
            a_acc = a_max;
            t(1) = (a_init-a_acc)/j;
            t(2) = (v_acc-v_acc_min)/a_acc;
            t(3) = a_acc/j;
            e(4,1) = -j/6;e(3,1) = 1/2*a_init;
            e(4,2) = 0;e(3,2) = 1/2*a_acc;
            e(4,3) = -j/6;e(3,3) = 1/2*a_acc;
        else
            v_acc = v_end - v_init;
            v_acc_min = (a_init^2-2*a_min^2)/(2*j);
            if v_acc < v_acc_min 
                %减加速 + 加减速+（匀减速）+ 减减速
                fprintf('状况2：减加速 + 加减速+（匀减速）+ 减减速\n');
                type = 2;
                a_acc = -a_min;
                t(1) = (a_init+a_acc)/j;
                t(2) = (v_acc-v_acc_min)/-a_acc;
                t(3) = a_acc/j;
                e(4,1) = -j/6;e(3,1) = 1/2*a_init;
                e(4,2) = 0;e(3,2) = -1/2*a_acc;
                e(4,3) = j/6;e(3,3) = -1/2*a_acc;
            else
                %减加速 + 加减速 + 减减速
                fprintf('状况3：减加速 + 加减速 + 减减速\n');
                type = 3;
                a_acc = sqrt((a_init^2-2*j*v_acc)/2);
                t(1) = (a_init+a_acc)/j;
                t(2) = 0;
                t(3) = a_acc/j;
                e(4,1) = -j/6;e(3,1) = 1/2*a_init;
                e(4,2) = 0;e(3,2) = -1/2*a_acc;
                e(4,3) = j/6;e(3,3) = -1/2*a_acc;
            end
        end
    else
        v_acc = v_end - v_init;
        v_acc_min = (2*a_max^2 - a_init^2)/(2*j);
        if v_acc >= v_acc_min
            %加加速 + （匀加速）+ 减加速
            fprintf('状况4：加加速 + （匀加速）+ 减加速\n');
            type = 4;
            a_acc = a_max;
            t(1) = (a_acc-a_init)/j;
            t(2) = (v_acc-v_acc_min)/a_acc;
            t(3) = a_acc/j;
            e(4,1) = j/6;e(3,1) = 1/2*a_init;
            e(4,2) = 0;e(3,2) = 1/2*a_acc;
            e(4,3) = -j/6;e(3,3) = 1/2*a_acc;
        else
            %加加速 + 减加速
            fprintf('状况5：加加速 + 减加速\n');
            type = 5;
            a_acc = sqrt((2*v_acc*j+a_init^2)/2);
            t(1) = (a_acc-a_init)/j;
            t(2) = 0;
            t(3) = a_acc/j;
            e(4,1) = j/6;e(3,1) = 1/2*a_init;
            e(4,2) = 0;e(3,2) = 1/2*a_acc;
            e(4,3) = -j/6;e(3,3) = 1/2*a_acc;
        end
    end
elseif v_end<=v_init
    if a_init < a_min
        v_acc = v_init - v_end;
        v_acc_min = (a_init^2)/(2*j);
        if (v_acc>=v_acc_min)
            %减减速 + （匀减速） + 减减速
            fprintf('状况6：减减速 + （匀减速） + 减减速\n');
            type = 6;
            a_acc = -a_min;
            t(1) = (-a_acc-a_init)/j;
            t(2) = (v_acc-v_acc_min)/a_acc;
            t(3) = a_acc/j;
            e(4,1) = j/6;e(3,1) = 1/2*a_init;
            e(4,2) = 0;e(3,2) = -1/2*a_acc;
            e(4,3) = j/6;e(3,3) = -1/2*a_acc;
        else
            v_acc = v_init - v_end;
            v_acc_min = (a_init^2-2*a_max^2)/(2*j);
            if v_acc < v_acc_min
                %减减速 + 加加速 + （匀加速）+ 减加速
                fprintf('状况7：减减速 + 加加速 + （匀加速）+ 减加速\n');
                type = 7;
                a_acc = a_max;
                t(1) = (a_acc-a_init)/j;
                t(2) = (v_acc-v_acc_min)/-a_acc;
                t(3) = a_acc/j;
                e(4,1) = j/6;e(3,1) = 1/2*a_init;
                e(4,2) = 0;e(3,2) = 1/2*a_acc;
                e(4,3) = -j/6;e(3,3) = 1/2*a_acc;
            else
                %减减速 + 加加速 + 减加速
                fprintf('状况8：减减速 + 加加速 + 减加速\n');
                type = 8;
                a_acc = sqrt((a_init^2-2*j*v_acc)/2);
                t(1) = (a_acc-a_init)/j;
                t(2) = 0;
                t(3) = a_acc/j;
                e(4,1) = j/6;e(3,1) = 1/2*a_init;
                e(4,2) = 0;e(3,2) = 1/2*a_acc;
                e(4,3) = -j/6;e(3,3) = 1/2*a_acc;
            end
        end
    else
        v_acc = v_init - v_end;
        v_acc_min = (2*a_min^2-a_init^2)/(2*j);
        if v_acc >= v_acc_min
            %加减速 + （匀减速）+ 减减速
            fprintf('状况9：加减速 + （匀减速）+ 减减速\n');
            type = 9;
            a_acc = -a_min;
            t(1) = (a_acc+a_init)/j;
            t(2) = (v_acc-v_acc_min)/a_acc;
            t(3) = a_acc/j;
            e(4,1) = -j/6;e(3,1) = 1/2*a_init;
            e(4,2) = 0;e(3,2) = -1/2*a_acc;
            e(4,3) = j/6;e(3,3) = -1/2*a_acc;
        else
            %加减速 + 减减速
            fprintf('状况10：加减速 + 减减速\n');
            type = 10;
            a_acc = sqrt((2*v_acc*j+a_init^2)/2);
            t(1) = (a_acc+a_init)/j;
            t(2) = 0;
            t(3) = a_acc/j;
            e(4,1) = -j/6;e(3,1) = 1/2*a_init;
            e(4,2) = 0;e(3,2) = -1/2*a_acc;
            e(4,3) = j/6;e(3,3) = -1/2*a_acc;
        end
    end
elseif v_end == v_init
    if a_init > 0
         v_acc = v_end - v_init;
        v_acc_min = (a_init^2-2*a_max_dec^2)/(2*j);
        if v_acc < v_acc_min 
            %减加速 + 加减速+（匀减速）+ 减减速
            fprintf('状况11：减加速 + 加减速+（匀减速）+ 减减速\n');
            type = 11;
            a_acc = -a_min;
            t(1) = (a_init+a_acc)/j;
            t(2) = (v_acc-v_acc_min)/-a_acc;
            t(3) = a_acc/j;
            e(4,1) = -j/6;e(3,1) = 1/2*a_init;
            e(4,2) = 0;e(3,2) = -1/2*a_acc;
            e(4,3) = j/6;e(3,3) = -1/2*a_acc;
        else
            %减加速 + 加减速 + 减减速
            fprintf('状况12：减加速 + 加减速 + 减减速\n');
            type = 12;
            a_acc = sqrt((a_init^2-2*j*v_acc)/2);
            t(1) = (a_init+a_acc)/j;
            t(2) = 0;
            t(3) = a_acc/j;
            e(4,1) = -j/6;e(3,1) = 1/2*a_init;
            e(4,2) = 0;e(3,2) = -1/2*a_acc;
            e(4,3) = j/6;e(3,3) = -1/2*a_acc;
        end
    elseif a_init < 0
        v_acc = v_init - v_end;
        v_acc_min = (a_init^2-2*a_max^2)/(2*j);
        if v_acc < v_acc_min
            %减减速 + 加加速 + （匀加速）+ 减加速
            fprintf('状况13：减减速 + 加加速 + （匀加速）+ 减加速\n');
            type = 13;
            a_acc = a_max;
            t(1) = (a_acc-a_init)/j;
            t(2) = (v_acc-v_acc_min)/-a_acc;
            t(3) = a_acc/j;
            e(4,1) = j/6;e(3,1) = 1/2*a_init;
            e(4,2) = 0;e(3,2) = 1/2*a_acc;
            e(4,3) = -j/6;e(3,3) = 1/2*a_acc;
        else
            %减减速 + 加加速 + 减加速
            fprintf('状况14：减减速 + 加加速 + 减加速\n');
            type = 14;
            a_acc = sqrt((a_init^2-2*j*v_acc)/2);
            t(1) = (a_acc-a_init)/j;
            t(2) = 0;
            t(3) = a_acc/j;
            e(4,1) = j/6;e(3,1) = 1/2*a_init;
            e(4,2) = 0;e(3,2) = 1/2*a_acc;
            e(4,3) = -j/6;e(3,3) = 1/2*a_acc;
        end
    elseif a_init == 0
        fprintf('状况15：错误：前后速度相等且初始加速度为0！！！\n');
        t = 0;
        e = 0;
        type = 0;
    end
end

e(2,1) = v_init;
e(2,2) = e(4,1)*3*t(1)^2+e(3,1)*2*t(1)+v_init;
e(2,3) = e(3,2)*2*t(2)+e(2,2);
e(1,1) = 0;
e(1,2) = e(4,1)*t(1)^3+e(3,1)*t(1)^2+v_init*t(1);
e(1,3) = e(3,2)*t(2)^2+e(2,2)*t(2) + e(1,2);
end

