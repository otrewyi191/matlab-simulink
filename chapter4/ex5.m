clear all;
t=0:0.001:10;
x=sin(2*pi*t);
px=norm(x).^2/length(x);        %�����ź�x�Ĺ���
snr=20;                         %����ȣ�dB��ʽ
pn=px./(10.^(snr./10));         %����snr������������
n=sqrt(pn)*randn(1,length(x));  %�����������ʲ�����Ӧ�ĸ�˹����������
y=x+n;                          %���ź��ϵ��Ӹ�˹������
subplot(2,1,1);plot(t,x);title('�����ź�x')
subplot(2,1,2);plot(t,y);title('�����˸�˹��������������ź�')

var(n)