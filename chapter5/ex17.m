clear all
ts=0.001;                           %�źų���ʱ����
t=0:ts:5-ts;                       %ʱ������
fs=1/ts;                            %����Ƶ��
df=fs/length(t);                    %fft��Ƶ�ʷֱ���
msg=randint(10,1,[-3,3],123);      %������Ϣ����,���������Ϊ123
msg1=msg*ones(1,fs/2);             %��չ��ȡ���ź���ʽ
msg2=reshape(msg1.',1,length(t));
Pm=fft(msg2)/fs;                    %����Ϣ�źŵ�Ƶ��
f=-fs/2:df:fs/2-df; 
subplot(3,1,1)
plot(t,msg2)                        %������Ϣ�ź�
title('��Ϣ�ź�')

int_msg(1)=0;                       %��Ϣ�źŻ���
for ii=1:length(t)-1
    int_msg(ii+1)=int_msg(ii)+msg2(ii)*ts;
end

kf=50;

fc=300;                             %�ز�Ƶ��
Sfm=cos(2*pi*fc*t+2*pi*kf*int_msg); %��Ƶ�ź�


phase=angle(hilbert(Sfm).*exp(-j*2*pi*fc*t));   %FM�����ź���λ
phi=unwrap(phase);                              
dem=(1/(2*pi*kf)*diff(phi)/ts);                 %����λ΢�֣��õ���Ϣ�ź�
dem(length(t))=0;
subplot(3,1,2)
plot(t,dem);
title('�������Ľ���ź�')

y1=awgn(Sfm,20,'measured');             %�����ź�ͨ��AWGN�ŵ�
y1(find(y1>1))=1;                       %�����ź��޷�
y1(find(y1<-1))=-1;
phase1=angle(hilbert(y1).*exp(-j*2*pi*fc*t));   %�źŽ��
phi1=unwrap(phase1);
dem1=(1/(2*pi*kf)*diff(phi1)/ts);
dem1(length(t))=0;
subplot(3,1,3)
plot(t,dem1);
title('�����Ϊ20dBʱ�Ľ���ź�')

