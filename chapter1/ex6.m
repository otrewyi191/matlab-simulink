%1-6
x=linspace(0,2*pi,60);
y1=sin(x);
H1=figure;              %�����´��ڲ����ؾ��������H1
plot(x,y1);
title('sin(x)')
axis([0 2*pi -1 1]);
y2=cos(x);
H2=figure;              %������2�����ڲ����ؾ��������H2
plot(x,y2);
title('cos(x)')
axis([0 2*pi -1 1]);
y3=sin(2*x);
H3=figure;              %������3�����ڲ����ؾ��������H3
plot(x,y3);
title('sin(2x)')
axis([0 2*pi -1 1]);
y4=cos(2*x);
H4=figure;              %������4�����ڲ����ؾ��������H4
plot(x,y4);
title('cos(2x)')
axis([0 2*pi -1 1]);
