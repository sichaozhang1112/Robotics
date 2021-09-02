%% ���ٶι滮
% ֻ�ɴ���������
% �����ʼ�ٶȣ����ٶȣ����������ٶȣ��������ٶ�Ϊ0���Լ����ٶȵ������ޣ�jerkĬ��Ϊ2
function [ t,e,type ] = ChangeVelPlan( v_init,v_end,a_init,a_max,a_min,j)
t = zeros(3,1);
if v_end>v_init
    if a_init >= a_max
        if v_end - v_init >= a_init^2/(2*j)
            fprintf('״��1��������+���ȼ��٣�+������\n');
            type = 1;
            %������+���ȼ��٣�+������
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
                %������ + �Ӽ���+���ȼ��٣�+ ������
                fprintf('״��2�������� + �Ӽ���+���ȼ��٣�+ ������\n');
                type = 2;
                a_acc = -a_min;
                t(1) = (a_init+a_acc)/j;
                t(2) = (v_acc-v_acc_min)/-a_acc;
                t(3) = a_acc/j;
                e(4,1) = -j/6;e(3,1) = 1/2*a_init;
                e(4,2) = 0;e(3,2) = -1/2*a_acc;
                e(4,3) = j/6;e(3,3) = -1/2*a_acc;
            else
                %������ + �Ӽ��� + ������
                fprintf('״��3�������� + �Ӽ��� + ������\n');
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
            %�Ӽ��� + ���ȼ��٣�+ ������
            fprintf('״��4���Ӽ��� + ���ȼ��٣�+ ������\n');
            type = 4;
            a_acc = a_max;
            t(1) = (a_acc-a_init)/j;
            t(2) = (v_acc-v_acc_min)/a_acc;
            t(3) = a_acc/j;
            e(4,1) = j/6;e(3,1) = 1/2*a_init;
            e(4,2) = 0;e(3,2) = 1/2*a_acc;
            e(4,3) = -j/6;e(3,3) = 1/2*a_acc;
        else
            %�Ӽ��� + ������
            fprintf('״��5���Ӽ��� + ������\n');
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
            %������ + ���ȼ��٣� + ������
            fprintf('״��6�������� + ���ȼ��٣� + ������\n');
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
                %������ + �Ӽ��� + ���ȼ��٣�+ ������
                fprintf('״��7�������� + �Ӽ��� + ���ȼ��٣�+ ������\n');
                type = 7;
                a_acc = a_max;
                t(1) = (a_acc-a_init)/j;
                t(2) = (v_acc-v_acc_min)/-a_acc;
                t(3) = a_acc/j;
                e(4,1) = j/6;e(3,1) = 1/2*a_init;
                e(4,2) = 0;e(3,2) = 1/2*a_acc;
                e(4,3) = -j/6;e(3,3) = 1/2*a_acc;
            else
                %������ + �Ӽ��� + ������
                fprintf('״��8�������� + �Ӽ��� + ������\n');
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
            %�Ӽ��� + ���ȼ��٣�+ ������
            fprintf('״��9���Ӽ��� + ���ȼ��٣�+ ������\n');
            type = 9;
            a_acc = -a_min;
            t(1) = (a_acc+a_init)/j;
            t(2) = (v_acc-v_acc_min)/a_acc;
            t(3) = a_acc/j;
            e(4,1) = -j/6;e(3,1) = 1/2*a_init;
            e(4,2) = 0;e(3,2) = -1/2*a_acc;
            e(4,3) = j/6;e(3,3) = -1/2*a_acc;
        else
            %�Ӽ��� + ������
            fprintf('״��10���Ӽ��� + ������\n');
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
            %������ + �Ӽ���+���ȼ��٣�+ ������
            fprintf('״��11�������� + �Ӽ���+���ȼ��٣�+ ������\n');
            type = 11;
            a_acc = -a_min;
            t(1) = (a_init+a_acc)/j;
            t(2) = (v_acc-v_acc_min)/-a_acc;
            t(3) = a_acc/j;
            e(4,1) = -j/6;e(3,1) = 1/2*a_init;
            e(4,2) = 0;e(3,2) = -1/2*a_acc;
            e(4,3) = j/6;e(3,3) = -1/2*a_acc;
        else
            %������ + �Ӽ��� + ������
            fprintf('״��12�������� + �Ӽ��� + ������\n');
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
            %������ + �Ӽ��� + ���ȼ��٣�+ ������
            fprintf('״��13�������� + �Ӽ��� + ���ȼ��٣�+ ������\n');
            type = 13;
            a_acc = a_max;
            t(1) = (a_acc-a_init)/j;
            t(2) = (v_acc-v_acc_min)/-a_acc;
            t(3) = a_acc/j;
            e(4,1) = j/6;e(3,1) = 1/2*a_init;
            e(4,2) = 0;e(3,2) = 1/2*a_acc;
            e(4,3) = -j/6;e(3,3) = 1/2*a_acc;
        else
            %������ + �Ӽ��� + ������
            fprintf('״��14�������� + �Ӽ��� + ������\n');
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
        fprintf('״��15������ǰ���ٶ�����ҳ�ʼ���ٶ�Ϊ0������\n');
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

