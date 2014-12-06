clear all
nsymbol=100000;                             %ÿ��������µķ��ͷ�����
M=16;                                       %16-QAM
graycode=[0 1 3 2 4 5 7 6 12 13 15 14 8 9 11 10];             %Gray�������                      
EsN0=5:20;                              %����ȣ�Es/N0
snr1=10.^(EsN0/10);                     %�����ת��Ϊ����ֵ
msg=randint(1,nsymbol,M);               %��Ϣ����
msg1=graycode(msg+1);                   %Grayӳ��
msgmod=qammod(msg1,M);                  %����16-QAM����
spow=norm(msgmod).^2/nsymbol;           %��ÿ�����ŵ�ƽ������
for indx=1:length(EsN0)
    sigma=sqrt(spow/(2*snr1(indx)));                %���ݷ��Ź�������������
    rx=msgmod+sigma*(randn(1,length(msgmod))+j*randn(1,length(msgmod)));
    y=qamdemod(rx,M);
    decmsg=graycode(y+1);
    [err,ber(indx)]=biterr(msg,decmsg,log2(M));     %�������
    [err,ser(indx)]=symerr(msg,decmsg);             %�������
end
P4=2*(1-1/sqrt(M))*qfunc(sqrt(3*snr1/(M-1)));
ser1=1-(1-P4).^2;                                           %�����������
ber1=1/log2(M)*ser1;                                        %�����������
semilogy(EsN0,ber,'-ko',EsN0,ser,'-k*',EsN0,ser1,EsN0,ber1,'-k.');
title('16-QAM�ز������ź���AWGN�ŵ��µ�����')
xlabel('Es/N0');ylabel('������ʺ��������')
legend('�������','�������','�����������','�����������')