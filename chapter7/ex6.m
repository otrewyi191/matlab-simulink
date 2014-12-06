clear all
nsymbol=100000;         %ÿ��������µķ��ͷ�����
M=8;                                    %8-DPSK
graycode=[0 1 2 3 6 7 4 5];             %Gray�������                      
EsN0=5:20;                              %����ȣ�Es/N0
snr1=10.^(EsN0/10);                     %�����ת��Ϊ����ֵ
msg=randint(1,nsymbol,M);               %��Ϣ����
msg1=graycode(msg+1);                   %Grayӳ��
msgmod=dpskmod(msg1,M);                 %����8-DPSK����
spow=norm(msgmod).^2/nsymbol;           %��ÿ�����ŵ�ƽ������
for indx=1:length(EsN0)
    sigma=sqrt(spow/(2*snr1(indx)));                %���ݷ��Ź�������������
    rx=msgmod+sigma*(randn(1,length(msgmod))+j*randn(1,length(msgmod)));
    y=dpskdemod(rx,M);
    decmsg=graycode(y+1);
    [err,ber(indx)]=biterr(msg(2:end),decmsg(2:end),log2(M));     %�������
    [err,ser(indx)]=symerr(msg(2:end),decmsg(2:end));             %�������
end
ser1=2*qfunc(sqrt(snr1)*sin(pi/M));                         %�����������
ber1=1/log2(M)*ser1;                                        %�����������
semilogy(EsN0,ber,'-ko',EsN0,ser,'-k*',EsN0,ser1,EsN0,ber1,'-k.');
title('8-DPSK�ز������ź���AWGN�ŵ��µ�����')
xlabel('Es/N0');ylabel('������ʺ��������')
legend('�������','�������','�����������','�����������')