clear all
ts=0.0025;                      %�źų���ʱ����
t=0:ts:5-ts;                   %ʱ������
fs=1/ts;                        %����Ƶ��
msg=randint(10,1,[-3,3],123);  %������Ϣ����,���������Ϊ123
msg1=msg*ones(1,fs/2);         %��չ��ȡ���ź���ʽ
msg2=reshape(msg1.',1,length(t));
subplot(3,1,1)
plot(t,msg2)                    %������Ϣ�ź�
title('��Ϣ�ź�')

A=4;
fc=100;                         %�ز�Ƶ��
Sam=(A+msg2).*cos(2*pi*fc*t);   %�ѵ��ź�

dems=abs(hilbert(Sam))-A;       %����첨������ȥ��ֱ��������
subplot(3,1,2)
plot(t,dems)                    %�����������ź�
title('�������Ľ���ź�')

y=awgn(Sam,20,'measured');      %�����ź�ͨ��AWGN�ŵ�
dems2=abs(hilbert(y))-A;        %����첨������ȥ��ֱ��������
subplot(3,1,3)                  %��������ź�
plot(t,dems2)
title('�����Ϊ20dBʱ�Ľ���ź�')
