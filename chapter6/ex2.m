clear all

nsymbol=100000;                         %���ͷ�����
EbN0=0:12;                               %�����
msg=randint(1,nsymbol);                 %��Ϣ����
E=1;
r0=zeros(1,nsymbol);
r1=zeros(1,nsymbol);
indx=find(msg==0);
r0(indx)=E;
indx1=find(msg==1);
r1(indx1)=E;

for indx=1:length(EbN0)
    dec=zeros(1,length(msg));
    snr=10.^(EbN0(indx)/10);                    %dBת��Ϊ����ֵ
    sigma=1/(2*snr);                            %��������
    r00=r0+sqrt(sigma)*randn(1,length(msg));    %����������
    r11=r1+sqrt(sigma)*randn(1,length(msg));
    indx1=find(r11>=r00);                       %�о�
    dec(indx1)=1;
    [err,ber(indx)]=biterr(msg,dec);
end
figure
semilogy(EbN0,ber,'-ko',EbN0,qfunc(sqrt(10.^(EbN0/10))));
title('�����������ź���AWGN�ŵ��µ������������')
xlabel('Eb/N0');ylabel('�������Pe')
legend('������','���۽��')


        
        