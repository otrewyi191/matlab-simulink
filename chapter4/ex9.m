%ex4.9
clear all
fd=10;              %������Ƶ��Ϊ10
ts=1/1000;          %�ŵ�����ʱ����
t=0:ts:1;           %����ʱ������
h1=rayleigh(fd,t);  %�����ŵ�����

fd=20;              %������Ƶ��Ϊ20
h2=rayleigh(fd,t);  %�����ŵ�����
subplot(2,1,1),plot(20*log10(abs(h1(1:1000))))
title('fd =10Hzʱ���ŵ���������')
xlabel('ʱ��');ylabel('����')
subplot(2,1,2),plot(20*log10(abs(h2(1:1000))))
title('fd=20Hzʱ���ŵ���������')
xlabel('ʱ��');ylabel('����')