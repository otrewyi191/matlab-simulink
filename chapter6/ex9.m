clear all
Fd=1;           %���Ų���Ƶ��
Fs=10;          %�˲�������Ƶ��
r=0.2;          %�˲�������ϵ��
delay=4;        %�˲���ʱ��
[num,den]=rcosine(Fd,Fs,'default',r,delay); %����˲���
figure; impz(num,1);    %�˲����ĳ弤��Ӧ
title('�˲����ĳ弤��Ӧ')
x=randint(1,30);        %����������
[y,ty]=rcosflt(x,Fd,Fs,'filter',num,den);   %�Զ��������ݽ����������
figure
t=delay:length(x)+delay-1;
stem(t,x,'-r');hold on  %��������������
plot(ty,y)              %����������κ������
legend('����������','������κ������')
axis([-1 40 -0.5 2])