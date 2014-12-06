clear all
ts=0.01;
fs=1/ts;
t=0:ts:10;
df=fs/length(t);
f=-50:df:50-df;
x=exp(-10*abs(t-5)).*cos(2*pi*20*t);
X=fft(x)/fs;

xa=hilbert(x);
Xa=fft(xa)/fs;
subplot(2,1,1);plot(t,x);title('�ź�x');xlabel('ʱ��t')
subplot(2,1,2);plot(f,fftshift(abs(X)));title('�ź�x������');xlabel('Ƶ��f')

figure
subplot(2,1,1);plot(t,abs(xa));title('�ź�xa����');xlabel('ʱ��t')
subplot(2,1,2);plot(f,fftshift(abs(Xa)));title('�ź�xa������');xlabel('Ƶ��f')