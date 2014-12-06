clear all
w=-1:0.001:1;
n=0:30;
h=sinc(0.2*n);
x=2*sin(0.2*pi*n)+3*cos(0.4*pi*n);
Hjw=h*(exp(-j*pi).^(n'*w));
Xjw=x*(exp(-j*pi).^(n'*w));
Yjw=Xjw.*Hjw;
n1=0:2*length(n)-2;
dw=0.001*pi;
y=(dw*Yjw*(exp(j*pi).^(w'*n1)))/(2*pi);
y1=conv(x,h);
subplot(3,1,1);plot(w,abs(Hjw))
title('H');xlabel('pi����(w)');ylabel('���')
subplot(3,1,2);plot(w,abs(Xjw));
title('X');xlabel('pi����(w)');ylabel('���')
subplot(3,1,3);plot(w,abs(Yjw));
title('Y');xlabel('pi����(w)');ylabel('���')

figure
subplot(2,1,1);stem(abs(y));title('ͨ��IDTFT��������������Y');
subplot(2,1,2);stem(abs(y1));title('ͨ��ʱ������������������Y1')