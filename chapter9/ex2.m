clear all
N=8;                    % ���ز���
x=randint(1,N,[0 3])    % ���ز��ϵ�����
x1=qammod(x,4)          % 4-QAM����
f=1:N;                  % ���ز�Ƶ��
t=0:0.001:1-0.001;      % ���ų���ʱ��
w=2*pi*f.'*t;
y1=x1*exp(j*w);         % ���ز�����

x2=ifft(x1,N);          % IFFT

plot(t,abs(y1));    
hold on;
stem(0:1/8:1-1/8,abs(x2)*N,'-r');
legend('ģ�����ʵ��','IDFTʵ��')
title('OFDM��ģ�����ʵ����IDFTʵ��')

x3=fft(x2)              % FFT
