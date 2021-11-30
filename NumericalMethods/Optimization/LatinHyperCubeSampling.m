% �������������������Ĳ������򣬶����Ƿ����������ֲ��ı���
clear;clc;close all;
lambda = 1;
k = 4;

% �����ܶȺ���PDF
y1 = @(x) k / lambda * (x/lambda)^(k-1) * exp(-(x/lambda)^k);
fplot(y1, [0.1 10]);

% �ۻ��ֲ�����CDF
CDF = @(x) 1 - exp(-(x/lambda).^k);
figure
fplot(CDF, [0.1 10]);
x = 0 : 0.1 : 8;
y2 = CDF(x);

% �ۻ��ֲ������ķ����������ڼ�����������ֵValue
ICDF = @(x) lambda * (-log(1 - x)).^ (1/k);
figure
fplot(ICDF, [0.1 2]);

%% 1.������������ȡԭʼ����
iterations = 20;                        % ��������
segmentSize = 1 / iterations;           % ÿ���С
for i = 0 : iterations-1                % ����������
    segmentMin = i * segmentSize;
    segmentMax = (i+1) * segmentSize;
    samplePoint(i+1) = segmentMin + rand() * segmentSize;
end
samplePoint = samplePoint(randperm(iterations));        % ����õ�ԭʼ����

%% 2.ӳ��õ���������
Value = ICDF(samplePoint);
figure
axisY = zeros(size(Value));
scatter(Value, axisY);