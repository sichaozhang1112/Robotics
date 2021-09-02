%% ���ٶι滮����
% ���� ChangeVelPlan

close all;
clear all;

%% ��������
s  = 0.01; %����
v_max = 0.4; %����ٶ�
a_max = 0.2; %�����ٶ�
a_min = -0.2; %��С���ٶ�
v_init = 0.3738; % ��ʼ�ٶ�
a_init = -0.19; % ��ʼ���ٶ�
v_end = 0.01; %�����ٶ�
j = 10; 

%% ���ɹ滮
[ t,e,type ] = ChangeVelPlan( v_init,v_end,a_init,a_max,a_min,j); %���ٶι滮

[tPlan,aPlan,vPlan,dPlan] = ScurvePlanGetbyTime(t,e); % �����ٶȣ����ٶȣ�����Ĺ滮���

%% ��ͼ
figure()
plot(tPlan,aPlan,'LineWidth',1.5,'color','r'); hold on;
% figure(2)
plot(tPlan,vPlan,'LineWidth',1.5,'color','b'); hold on;
% figure(3)
plot(tPlan,dPlan,'LineWidth',1.5,'color','g'); hold on;
legend('���ٶ�','�ٶ�','·��');
xlabel('ʱ��');
