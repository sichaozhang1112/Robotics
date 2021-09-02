%% 判断是否可以在指定距离内以最大能力刹车

function [CanStop,e,d_dec,t,StopType] = JudgeCanStop(s,v_max,a_max_acc,a_max_dec,v_init,a_init,v_end,j)
CanStop = 1;
d_dec = 0;
t = zeros(3,1);
v = zeros(3,1);
d = zeros(3,1);
e = zeros(4,3);
if v_init>0
    if a_init>0
        v_dec = v_init-v_end;
        v_dec_min = a_max_dec^2/j - 1/2*a_init^2/j;
        if v_dec>=v_dec_min
            %减加速 + 加减速 + （匀减速）+ 减减速
            StopType = 1;
            a_dec = a_max_dec;
            t(1) = (a_init+a_dec)/j;
            t(2) = (v_dec - v_dec_min)/a_dec;
            t(3) = a_dec/j;
            v(1) = -1/2*j*t(1)^2+a_init*t(1)+v_init;
            v(2) = -a_dec*t(2)+v(1);
            v(3) = 1/2*j*t(3)^2-a_dec*t(3)+v(2);
            d(1) = -1/6*j*t(1)^3+1/2*a_init*t(1)^2+v_init*t(1);
            d(2) = -1/2*a_dec*t(2)^2+v(1)*t(2);
            d(3) = 1/6*j*t(3)^3-1/2*a_dec*t(3)^2+v(2)*t(3);
            d_dec = d(1)+d(2)+d(3);
            e(4,1) = -j/6;e(3,1) = 1/2*a_init;e(2,1) = v_init;e(1,1) = 0;
            e(4,2) = 0;e(3,2) = -1/2*a_dec;e(2,2) = v(1);e(1,2) = d(1);
            e(4,3) = j/6;e(3,3) = -1/2*a_dec;e(2,3) = v(2);e(1,3) = d(1)+d(2);
            if d_dec>s
                CanStop = 0;
            end   
        else
            %减加速 + 加减速 + 减减速
            StopType = 2;
            a_dec = sqrt(v_dec_min*j+1/2*a_init^2);
            t(1) = (a_init+a_dec)/j;
            t(2) = 0;
            t(3) = a_dec/j;
            v(1) = -1/2*j*t(1)^2+a_init*t(1)+v_init;
            v(2) = -a_dec*t(2)+v(1);
            v(3) = 1/2*j*t(3)^2-a_dec*t(3)+v(2);
            d(1) = -1/6*j*t(1)^3+1/2*a_init*t(1)^2+v_init*t(1);
            d(2) = -1/2*a_dec*t(2)^2+v(1)*t(2);
            d(3) = 1/6*j*t(3)^3-1/2*a_dec*t(3)^2+v(2)*t(3);
            d_dec = d(1)+d(2)+d(3);
            e(4,1) = -j/6;e(3,1) = 1/2*a_init;e(2,1) = v_init;e(1,1) = 0;
            e(4,2) = 0;e(3,2) = -1/2*a_dec;e(2,2) = v(1);e(1,2) = d(1);
            e(4,3) = j/6;e(3,3) = -1/2*a_dec;e(2,3) = v(2);e(1,3) = d(1)+d(2);
            if d_dec>s
                CanStop = 0;
            end   
        end
    else
        v_dec = v_init-v_end;
        v_dec_min = a_init^2/(2*j);
        if v_dec>v_dec_min
            if a_init<-a_max_dec
            	fprintf('Error: Wrong Init Dec!');
                CanStop = -1;
            else
                v_dec_min = (2*a_max_dec^2-a_init^2)/(2*j);
                if v_dec>= v_dec_min
                    a_dec = a_max_dec;
                    t(1) = (a_init+a_dec)/j;
                    t(2) = (v_dec - v_dec_min)/a_dec;
                    t(3) = a_dec/j;
                else
                    a_dec = sqrt((v_dec*2*j+a_init^2)/2);
                    t(1) = (a_init+a_dec)/j;
                    t(2) = 0;
                    t(3) = a_dec/j;
                end
                v(1) = -1/2*j*t(1)^2+a_init*t(1)+v_init;
                v(2) = -a_dec*t(2)+v(1);
                v(3) = 1/2*j*t(3)^2-a_dec*t(3)+v(2);
                d(1) = -1/6*j*t(1)^3+1/2*a_init*t(1)^2+v_init*t(1);
                d(2) = -1/2*a_dec*t(2)^2+v(1)*t(2);
                d(3) = 1/6*j*t(3)^3-1/2*a_dec*t(3)^2+v(2)*t(3);
                d_dec = d(1)+d(2)+d(3);
                e(4,1) = -j/6;e(3,1) = 1/2*a_init;e(2,1) = v_init;e(1,1) = 0;
                e(4,2) = 0;e(3,2) = -1/2*a_dec;e(2,2) = v(1);e(1,2) = d(1);
                e(4,3) = j/6;e(3,3) = -1/2*a_dec;e(2,3) = v(2);e(1,3) = d(1)+d(2);
                if d_dec>s
                    CanStop = 0;
                end  
            end
        else
            fprintf('Error: Cannot Dec!\n');
            CanStop = -1;
        end
    end
end
if CanStop == 1
    fprintf('Yes! I can Stop On Target Point!\n');
else
    fprintf('No! I cannot Stop On Target Point!\n');
end
end