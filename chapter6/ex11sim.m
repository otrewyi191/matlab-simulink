clear all
EsN0=0:15;              %SNR�ķ�Χ

for ii=1:length(EsN0)
    SNR=EsN0(ii);       %��ֵ��AWGN�ŵ�ģ���е�SNR
    sim('ex11');         %���з���ģ��
    ber(ii)=BER(1);     %���汾�η���õ���BER
    ser(ii)=SER(1);     %���汾�η���õ���SER
end
semilogy(EsN0,ber,'-ko',EsN0,ser,'-k*',EsN0,1.5*qfunc(sqrt(0.4*10.^(EsN0/10))));
title('4-PAM�ź���AWGN��������ŵ��µ�����')
xlabel('Es/N0');ylabel('������ʺ��������')
legend('�������','�������','�����������')