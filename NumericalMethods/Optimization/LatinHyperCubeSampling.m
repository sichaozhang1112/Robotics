% 基于拉丁超立方抽样的采样程序，对象是服从威布尔分布的变量
clear;clc;close all;
lambda = 1;
k = 4;

% 概率密度函数PDF
y1 = @(x) k / lambda * (x/lambda)^(k-1) * exp(-(x/lambda)^k);
fplot(y1, [0.1 10]);

% 累积分布函数CDF
CDF = @(x) 1 - exp(-(x/lambda).^k);
figure
fplot(CDF, [0.1 10]);
x = 0 : 0.1 : 8;
y2 = CDF(x);

% 累积分布函数的反函数，用于计算最终样本值Value
ICDF = @(x) lambda * (-log(1 - x)).^ (1/k);
figure
fplot(ICDF, [0.1 2]);

%% 1.拉丁超立方抽取原始样本
iterations = 20;                        % 抽样次数
segmentSize = 1 / iterations;           % 每层大小
for i = 0 : iterations-1                % 逐层随机抽样
    segmentMin = i * segmentSize;
    segmentMax = (i+1) * segmentSize;
    samplePoint(i+1) = segmentMin + rand() * segmentSize;
end
samplePoint = samplePoint(randperm(iterations));        % 乱序得到原始样本

%% 2.映射得到最终样本
Value = ICDF(samplePoint);
figure
axisY = zeros(size(Value));
scatter(Value, axisY);