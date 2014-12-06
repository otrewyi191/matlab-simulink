clear all
M=4;                        %4-FSK
T=1;                        %���ų���ʱ��
deltaf=1/T;                 %FSK��Ƶ�ʼ��
fs=60;                      %����Ƶ��
ts=1/fs;                    %����ʱ����
t=0:ts:T;                   %һ���������ڵ�ʱ������
fc=4;                       %�ز�Ƶ��
msg=[0 1 3 2 randint(1,10000-M,M)];     %��Ϣ����
msg_mod=fskmod(msg,M,deltaf,fs,fs);     %4-FSK����
t1=0:ts:length(msg)-ts;                 %��Ϣ����ʱ������
y=real(msg_mod.*exp(j*2*pi*fc*t1));     %�ز�����
subplot(2,1,1)
plot(t1(1:4*fs),y(1:4*fs))              %ʱ���źŲ���
axis([0 4 -1.5 1.5])
title('4FSK���Ƶ��źŲ���')
xlabel('ʱ��');ylabel('���')
ly = length(y);                             %�����źų���
freq = [-fs/2 : fs/ly : fs/2 - fs/ly];  
Syy = 10*log10(fftshift(abs(fft(y)/fs)));   %�����ź�Ƶ��
subplot(2,1,2)
plot(freq,Syy)
title('�����źŷ�����')
xlabel('Ƶ��'),ylabel('����')

