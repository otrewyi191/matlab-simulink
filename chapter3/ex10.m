clear all
w=-1:0.001:1;
n=0:20;
h(n+1)=1;
x=h.*exp(j*pi*n/4);
Hjw=h*(exp(-j*pi).^(n'*w));
Xjw=x*(exp(-j*pi).^(n'*w));
subplot(2,2,1);plot(w,abs(Hjw))
title('H');xlabel('pi����(w)');ylabel('���')
subplot(2,2,2);plot(w,angle(Hjw)/pi);
title('H');xlabel('pi����(w)');ylabel('��λ')
subplot(2,2,3);plot(w,abs(Xjw));
title('X');xlabel('pi����(w)');ylabel('���')
subplot(2,2,4);plot(w,angle(Xjw)/pi);
title('X');xlabel('pi����(w)');ylabel('��λ')
