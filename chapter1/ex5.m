x=linspace(0,2*pi,60);
y1=sin(x);
subplot(2,2,1);			%������ͼ����Ϊ2*2�����ҵ�ǰ��ͼ��λ1�Ż�ͼ��
plot(x,y1);
title('sin(x)')
axis([0 2*pi -1 1]);
y2=cos(x);
subplot(2,2,2);			%ָ����ǰ��ͼ��Ϊ2�Ż�ͼ��
plot(x,y2);
title('cos(x)')
axis([0 2*pi -1 1]);
y3=sin(2*x);
subplot(2,2,3);			%ָ����ǰ��ͼ��Ϊ3�Ż�ͼ��
plot(x,y3);
title('sin(2x)')
axis([0 2*pi -1 1]);
y4=cos(2*x);
subplot(2,2,4);			%ָ����ǰ��ͼ��Ϊ4�Ż�ͼ��
plot(x,y4);
title('cos(2x)')
axis([0 2*pi -1 1]);
