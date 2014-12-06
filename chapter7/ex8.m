clear all
M=8;                        
msg=[1 4 3 0 7 5 2 6];          %��Ϣ�ź�
ts=0.01;                        %����ʱ����
T=1;                            %��������
t=0:ts:T;                       %���ų���ʱ������
x=0:ts:length(msg);             %���з��ŵĴ���ʱ��    
fc=1;                           %�ز�Ƶ��
c=sqrt(2)*exp(j*2*pi*fc*t);     %1�����������ڵ��ز�����
msg_qam=qammod(msg,M).';        %����8QAM����
tx_qam=real(msg_qam*c);         %8QAM�ز�����
tx_qam=reshape(tx_qam.',1,length(msg)*length(t));
plot(x,tx_qam(1:length(x)))
title('8QAM�źŲ���')
xlabel('ʱ��t'),ylabel('�ز����')
scatterplot(msg_qam)
title('8QAM�ź�����ͼ')
xlabel('ͬ�����'),ylabel('��������')