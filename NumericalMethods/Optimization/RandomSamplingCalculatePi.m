% 通过采样求圆周率
clear all;
close all;
radius=1;
in_radius_cnt=0;
hyper_cube_cnt=100;
sample_num_cube=10;
sample_num=hyper_cube_cnt*hyper_cube_cnt*sample_num_cube;
% 单纯的随机采样得出的结果 误差或大或小
% for i=1:sample_num
%     rand_x = rand(radius);
%     rand_y = rand(radius);
%     if (sqrt(rand_x*rand_x+rand_y*rand_y)<=radius)
%         in_radius_cnt=in_radius_cnt+1;
%     end
% end
% 采用LHS方法比单纯随机采样效果好
for i=1:hyper_cube_cnt
    for j=1:hyper_cube_cnt
        for k=1:sample_num_cube
            rand_x=rand(1)*1/hyper_cube_cnt+(i-1)*1/hyper_cube_cnt;
            rand_y=rand(1)*1/hyper_cube_cnt+(j-1)*1/hyper_cube_cnt;
            if (sqrt(rand_x*rand_x+rand_y*rand_y)<=1)
                in_radius_cnt=in_radius_cnt+1;
            end
        end
    end
end
pi_est=in_radius_cnt*4/sample_num;