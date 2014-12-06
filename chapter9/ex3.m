clear all
N=64;                       % ϵͳ���ز���
x=randint(N,2,[0 15]);      % 2���������ڵ�����
x1=qammod(x,16);            % 16-QAM����
x2=ifft(x1);                % IFFT
x3=[zeros(16,2); x2];       % �հ�ǰ׺
x4=[x2(49:end,:); x2];      % ѭ��ǰ׺

x3=reshape(x3,1,160);       % �����任
x4=reshape(x4,1,160);

h=sqrt(1/3)*(randn(1,3));   % 3���ŵ�

y1=x3*h(1)+[zeros(1,8) x3(1:end-8)*h(2)]; %ֻ����ǰ2��
y2=x4*h(1)+[zeros(1,8) x4(1:end-8)*h(2)];

y3=reshape(y1,80,2);        % �����任
y4=reshape(y2,80,2);

y3=y3(17:end,2);            % ���ǵ�2�����ŵ�Ӱ��
y4=y4(17:end,2);

y3=fft(y3);                 % FFT
y4=fft(y4);

h1=[h(1) zeros(1,7) h(2)];  % �ŵ�FFT�任
H=fft(h1,N).';
y3=y3./H;                   % �ŵ�����
y4=y4./H;

stem(abs(x1(:,2)),'fill');hold on;stem(abs(y3),'r<');stem(abs(y4),'-gs')
legend('ԭʼ�ź�','�հ�ǰ׺','ѭ��ǰ׺')
axis([0 70 0 max(abs(y3))+2])
title('2���ŵ����')

y1=y1+[zeros(1,20) x3(1:end-20)*h(3)];      % 3���ŵ����
y2=y2+[zeros(1,20) x4(1:end-20)*h(3)];

y3=reshape(y1,80,2);        % �����任        
y4=reshape(y2,80,2);

y3=y3(17:end,2);            % ���ǵ�2�����ŵ�Ӱ��
y4=y4(17:end,2);

y3=fft(y3);                 % FFT
y4=fft(y4);

h1=[h1 zeros(1,11) h(3)];   % �ŵ�FFT�任
H=fft(h1,N).';
y3=y3./H;                   % �ŵ�����
y4=y4./H;
figure
stem(abs(x1(:,2)),'fill');hold on;stem(abs(y3),'r<');stem(abs(y4),'-gs')
legend('ԭʼ�ź�','�հ�ǰ׺','ѭ��ǰ׺')
axis([0 70 0 max(max(abs(y3),abs(y4)))+2])
title('3���ŵ����')