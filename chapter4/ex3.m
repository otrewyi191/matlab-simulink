clear all
t=0:0.001:10;
x=sin(2*pi*t);
snr=20;
y=awgn(x, snr,'measured');
subplot(2,1,1);plot(t,x);title('�����ź�x')
subplot(2,1,2);plot(t,y);title('�����˸�˹��������������ź�')

z=y-x;
var(z)
