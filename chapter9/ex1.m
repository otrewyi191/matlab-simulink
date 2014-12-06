clear all
N=8;                    % ���ز���
f=1:N;                  % �������ز�Ƶ��
x=randint(1,N,[0 3]);   % ���ز��ϵ�����
x1=qammod(x,4)          % 4-QAM����

t=0:0.001:1-0.001;      % ���ų���ʱ��
w=2*pi*f.'*t;
w1=2*pi*(f+0.2).'*t;    % ƵƫΪ0.2Hzʱ�����ز�Ƶ��
y=x1*exp(j*w);          % ���ز�����
plot(t,abs(y))          % �������ƺ�Ĳ��ΰ���
for ii=1:N
    y1(ii)=sum(y.*exp(-j*w(ii,:)))/length(t); %��Ƶƫ�����ii�����ز��ϵ�����
end
stem(abs(x1))                      % ��ʾ��Ƶƫʱ���ز������Ľ��
hold on
stem(abs(y1),'r<')
title('ƵƫΪ0ʱ�����ز�������')
axis([0 9 0 3])
legend('ԭʼ����','���ز�����������')

% ����Ƶ��ƫ��ʱ�����ز�������                       
for ii=1:N
    y3(ii)=sum(y.*exp(-j*(w1(ii,:))))/length(t);
end
figure
stem(abs(x1))
hold on
stem(abs(y3),'r<')
axis([0 9 0 3])
title('ƵƫΪ0.2Hzʱ�����ز�������')
legend('ԭʼ����','���ز�����������')