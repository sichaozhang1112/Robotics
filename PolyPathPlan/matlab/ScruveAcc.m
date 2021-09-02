clear all;
close all;
vel_max = 1;
jerk = 2;
vel_init = 0.99;
acc_max = vel_max/2;
acc_init = 0.05;

vel_acc = (vel_max - vel_init);
vel_acc_min = (2*acc_max^2-acc_init^2)/(2*jerk);
if (vel_acc >= vel_acc_min)
    acc_acc = acc_max;
    time1 = (acc_acc-acc_init)/jerk;
    time2 = (vel_acc - vel_acc_min)/acc_acc;
    time3 = acc_acc/jerk;
else
    acc_acc = sqrt((2*vel_acc*jerk+acc_init^2)/2)
    time1 = (acc_acc-acc_init)/jerk
    time2 = 0
    time3 = acc_acc/jerk
end
vel_acc_1 = (acc_acc^2-acc_init^2)/(2*jerk)+vel_init;
vel_acc_2 = acc_acc*time2+vel_acc_1;
dis_1 = 1/6*jerk*time1^3+1/2*acc_init*time1^2+vel_init*time1;
dis_2 = 1/2*acc_acc*time2^2+vel_acc_1*time2;
dis_3 = -1/6*jerk*time3^3+1/2*acc_acc*time3^2+vel_acc_2*time3;
dis = dis_1+dis_2+dis_3

figure(1);
t1 = 0 : 0.0001 : time1;
v1 = 1/2*jerk*t1.^2+acc_init*t1+vel_init;

t2 = time1+0.0001 : 0.0001 : (time1+time2);
v2 = vel_acc_1+acc_acc*(t2-time1);

t3 = (time1+time2)+0.0001 : 0.0001 : (time1+time2+time3);
v3 = acc_acc*(t3-(time1+time2))-1/2*jerk*(t3-(time1+time2)).^2+vel_acc_2;

t = [t1,t2,t3];
v = [v1,v2,v3];
plot(t,v);hold on;plot(t2,v2,'r');hold on;

real_dis = 0;
for i = 1 : size(t,2)-1
    real_dis = real_dis+0.0001*(v(i+1)+v(i))/2;
end
real_dis
    
    
    
    
    







