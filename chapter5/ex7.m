clear all
ts=0.0025;                      %�źų���ʱ����
t=0:ts:5-ts;                   %ʱ������
fs=1/ts;                        %����Ƶ��
df=fs/length(t);                %fft��Ƶ�ʷֱ���
f=-fs/2:df:fs/2-df; 
msg=randint(10,1,[-3,3],123);  %������Ϣ����,���������Ϊ123
msg1=msg*ones(1,fs/2);         %��չ��ȡ���ź���ʽ
msg2=reshape(msg1.',1,length(t));

subplot(3,1,1)
plot(t,msg2)                    %������Ϣ�ź�
title('��Ϣ�ź�')

fc=100;                         %�ز�Ƶ��
Sdsb=msg2.*cos(2*pi*fc*t);      %�ѵ��ź�
y=Sdsb.*cos(2*pi*fc*t);         %��ɽ��
Y=fft(y)./fs;                   %������Ƶ��
f_stop=100;                     %��ͨ�˲����Ľ�ֹƵ��
n_stop=floor(f_stop/df);
Hlow=zeros(size(f));            %��Ƶ�ͨ�˲���
Hlow(1:n_stop)=2;
Hlow(length(f)-n_stop+1:end)=2;
DEM=Y.*Hlow;                    %����ź�ͨ����ͨ�˲���
dem=real(ifft(DEM))*fs;         %���յõ��Ľ���ź�
subplot(3,1,2)
plot(t,dem);
title('�������Ľ���ź�')

y1=awgn(Sdsb,20,'measured');    %�����ź�ͨ��AWGN�ŵ�
y2=y1.*cos(2*pi*fc*t);          %��ɽ��
Y2=fft(y2)./fs;                 %����źŵ�Ƶ��
DEM1=Y2.*Hlow;                  %����ź�ͨ����ͨ�˲���
dem1=real(ifft(DEM1))*fs;       %���յõ��Ľ���ź�
subplot(3,1,3)
plot(t,dem1)
title('�����Ϊ20dBʱ�Ľ���ź�')

