%1-7
x=linspace(0,2*pi,60);
y=sin(x);
z=cos(x);
plot(x,y,'-go');           %������������
hold on;                 %����ͼ�α���״̬
plot(x,z,'-.b');           %������������ͬʱ������������
axis ([0 2*pi -1 1]);    % 
legend('sin(x)','cos(x)');
hold off                 %�ر�ͼ�α���
