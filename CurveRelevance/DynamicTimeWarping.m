%% �Ƚ��������ߵ����ƶ�
function dist = DynamicTimeWarping(t,r)
n = size(t,1);
m = size(r,1);
% ֡ƥ��������
d = zeros(n,m);
for i = 1:n
    for j = 1:m
        d(i,j) = sum((t(i,:)-r(j,:)).^2);
    end
end
% �ۻ��������
D = ones(n,m) * realmax;
D(1,1) = d(1,1);
% ��̬�滮
for i = 1:n
    for j = 1:m
        if (i-1<=0)
            tmp_i=1;
        else
            tmp_i=i-1;
        end
        
        if (j-1<=0)
            tmp_j=1;
        else
            tmp_j=j-1;
        end
        
        D1 = D(tmp_i,j);
        D2 = D(i,tmp_j);
        D3 = D(tmp_i,tmp_j);
        D(i,j) = d(i,j) + min([D1,D2,D3]);
    end
end
dist = D(n,m);
end