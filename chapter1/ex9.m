%1-9
x=[0:0.1:2*pi];
y=abs(500*(sin(2*x)+cos(x)))+1;
semilogx(x,y);                    %������X���ͼ����
title('X�����');
figure
semilogy(x,y);
title('Y�����')
