%% S�����߹滮����

close all;
clear all;

%% ��������
% s  = 0.5;
% v_max =1 ;
% a_max_acc = 0.5;
% a_max_dec =0.5;
% v_init =0.5853;
% a_init =0.2238;
% v_end = 0;
% j = 2;

s  = 0.5; %����
v_max = 0.4; %����ٶ�
a_max_acc = 0.2; %�����ٶ�
a_max_dec = 0.2; %��С���ٶ�
v_init = 0.3738; % ��ʼ�ٶ�
a_init = -0.19; % ��ʼ���ٶ�
v_end = 0.01; %�����ٶ�
j = 10; 

%% ����S�����߹滮 
[t1,e1,CanPlan,type] = ScurveVelocityPlan(s,v_max,a_max_acc,a_max_dec,v_init,a_init,v_end,j);
[tPlan,aPlan,vPlan,dPlan] = ScurvePlanGetbyTime(t1,e1);

%% �ж�ɲ���滮����
% [CanStop,e0,d_dec,t0,StopType] = JudgeCanStop(s,v_max,a_max_acc,a_max_dec,v_init,a_init,v_end,j);
% [tPlan,aPlan,vPlan,dPlan] = ScurvePlanGetbyTime0(t0,e0);
% if StopType ==2 
%     break;
% end
%% ɲ��+�������� ����Ҫ�޸ģ�
% [CanStop,e0,d_dec,t0] = JudgeCanStop(s,v_max,a_max_acc,a_max_dec,v_init,a_init,v_end,j);
% if CanStop == 1
%      [t1,e1,CanPlan,type] = ScurveVelocityPlan(s,v_max,a_max_acc,a_max_dec,v_init,a_init,v_end,j);
%     if CanPlan == 1
%         [tPlan,aPlan,vPlan,dPlan] = ScurvePlanGetbyTime(t1,e1);
%         fprintf('�ƻ�1��S�͹滮!\n');
%     else
%         fprintf('�ƻ�2��ɲ���滮!\n');
%         [tPlan,aPlan,vPlan,dPlan] = ScurvePlanGetbyTime0(t0,e0);
%     end
% else
%     [t1,e1,CanPlan,type] = ScurveVelocityPlan(s,v_max,a_max_acc,a_max_dec,v_init,a_init,v_end,j);
%     if CanPlan == 1
%         [tPlan,aPlan,vPlan,dPlan] = ScurvePlanGetbyTime(t1,e1);
%         fprintf('�ƻ�3��S�͹滮!\n');
%     else
%         [tPlan0,aPlan0,vPlan0,dPlan0] = ScurvePlanGetbyTime0(t0,e0);
%         if d_dec-s<=0.06
%             fprintf('�ƻ�4������!\n');
%             tPlan = tPlan0;aPlan = aPlan0;vPlan = vPlan0;dPlan = dPlan0;
%         else
%             [t2,e2,CanPlan,type] = ScurveVelocityPlan(d_dec-s,v_max,a_max_acc,a_max_dec,0,0,v_end,j);
%             if CanPlan == 1
%                 fprintf('�ƻ�5��ɲ��+����!\n');
%                 [tPlan2,aPlan2,vPlan2,dPlan2] = ScurvePlanGetbyTime(t2,e2);
%                 tPlan = [tPlan0,tPlan0(1,end)+tPlan2];
%                 aPlan = [aPlan0,-aPlan2];
%                 vPlan = [vPlan0,-vPlan2];
%                 dPlan = [dPlan0,d_dec-dPlan2];
% %                 break;
%             else
%                 fprintf('�ƻ�6������!\n');
%                 tPlan = tPlan0;aPlan = aPlan0;vPlan = vPlan0;dPlan = dPlan0;
%             end
%         end
%     end
% end

%% ��ͼ
figure()
plot(tPlan,aPlan,'LineWidth',1.5,'color','r'); hold on;
% figure(2)
plot(tPlan,vPlan,'LineWidth',1.5,'color','b'); hold on;
% figure(3)
plot(tPlan,dPlan,'LineWidth',1.5,'color','g'); hold on;
legend('���ٶ�','�ٶ�','·��');
xlabel('ʱ��');