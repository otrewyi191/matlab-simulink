%ex1.m
%����Alamouti 2��1�տ�ʱ�������ܣ����Ʒ�ʽΪQPSK
clear all
datasize=100000;                    % ����ķ�����
EbNo=0:2:20;                         % �����
M=4;                                % QPSK modulation
x=randsrc(2,datasize/2,[0:3]);      % ����Դ����
x1=pskmod(x,M,pi/4);       
h=randn(2,datasize/2)+j*randn(2,datasize/2);   %Rayleigh˥���ŵ�
h=h./sqrt(2);                             
for indx=1:length(EbNo)
    sigma1=sqrt(1/(4*10.^(EbNo(indx)/10)));              % SISO�ŵ���˹��������׼��
    n=sigma1*(randn(2,datasize/2)+j*randn(2,datasize/2));
    y=x1+n;                                             % ͨ��AWGN�ŵ�
    y1=x1+n./h;                                         % ͨ��SISO����˥���ŵ�����о�����
    x2=pskdemod(y,M,pi/4);
    x3=pskdemod(y1,M,pi/4);
    sigma2=sqrt(1/(2*10.^(EbNo(indx)/10)));                      % Alamouti����ÿ�����ŵ���˹��������׼��
    n=sigma2*(randn(2,datasize/2)+j*randn(2,datasize/2));
    n1(1,:)=(conj(h(1,:)).*n(1,:)+h(2,:).*conj(n(2,:)))./(sum(abs(h).^2));    % Alamouti�������о�����
    n1(2,:)=(conj(h(2,:)).*n(1,:)-h(1,:).*conj(n(2,:)))./(sum(abs(h).^2));
    y3=x1+n1;
    x4=pskdemod(y3,M,pi/4);
    [temp,ber1(indx)]=biterr(x,x2,log2(M));
    [temp,ber2(indx)]=biterr(x,x3,log2(M));
    [temp,ber3(indx)]=biterr(x,x4,log2(M));
    
end
semilogy(EbNo,ber1,'-k*',EbNo,ber2,'-ko',EbNo,ber3,'-kd')
grid on
legend('AWGN�ŵ�','SISO����˥���ŵ�','2��1��Alamouti����')
xlabel('�����EbNo(dB)')
ylabel('�������(BER)')
title('2��1��Alamouti����������˥���ŵ��µ�����')