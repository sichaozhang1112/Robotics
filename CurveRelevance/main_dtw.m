clear all;
close all;
f_sin_1 = @(x) sin(x)+sin(2*x+pi)*0.5+sin(0.5*x-pi)*0.5;
f_sin_2 = @(x) sin(x)+sin(2*x+pi)*rand(1)+sin(0.5*x-pi)*rand(1);
poly_coeff = 2*(rand(1,6)-0.5);
f_poly = @(x) poly_coeff(6)*x.^5+poly_coeff(5)*x.^4+poly_coeff(4)*x.^3+poly_coeff(3)*x.^2+poly_coeff(2)*x.^1+poly_coeff(1);
f_rand = @(x) rand(1,size(x,2));

time_1_x = 0:0.01:2*pi;
time_1_y = f_sin_1(time_1_x);
time_series_1 = [time_1_x;time_1_y];

time_2_x = 0:0.01:2*pi;
time_2_y = f_sin_2(time_2_x);
time_series_2 = [time_2_x;time_2_y];

sampling_num_1 = 40; % 采样个数
noise_amplituede_1 = 0.1; % 噪点幅度
pick = sort(floor(rand(1,sampling_num_1)*size(time_series_1,2)+1));
time_series_pick_1(1,:) = time_series_1(1,pick);
time_series_pick_1(2,:) = time_series_1(2,pick);
noise = noise_amplituede_1 * 2*(rand(1,size(pick,2))-0.5); % 躁点
time_series_pick_1(2,:) = noise+time_series_pick_1(2,:);

sampling_num_2 = 40; % 采样个数
noise_amplituede_2 = 0.1; % 噪点幅度
pick = sort(floor(rand(1,sampling_num_2)*size(time_series_2,2)+1));
time_series_pick_2(1,:) = time_series_2(1,pick);
time_series_pick_2(2,:) = time_series_2(2,pick);
noise = noise_amplituede_2 * 2*(rand(1,size(pick,2))-0.5); % 躁点
time_series_pick_2(2,:) = noise+time_series_pick_2(2,:);

dis = max(sampling_num_1,sampling_num_2);
error = sqrt(DynamicTimeWarping(time_series_pick_2',time_series_pick_1')/dis);

plot(time_series_1(1,:),time_series_1(2,:),'r'); hold on;
plot(time_series_2(1,:),time_series_2(2,:),'b'); hold on;
scatter(time_series_pick_1(1,:),time_series_pick_1(2,:),'r'); hold on;
scatter(time_series_pick_2(1,:),time_series_pick_2(2,:),'b'); hold on;
axis equal;