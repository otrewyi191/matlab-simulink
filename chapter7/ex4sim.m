clear all
M=16;                   %16-PSK
EsN0=0:2:20;              %SNR�ķ�Χ
EsN01=10.^(EsN0/10);
SymbolRate=2;           %��������
for ii=1:length(EsN0)
    SNR=EsN0(ii);       %��ֵ��AWGN�ŵ�ģ���е�SNR
    sim('ex4');         %���з���ģ��
    ber(ii)=BER(1);     %���汾�η���õ���BER
    ser(ii)=SER(1);     %���汾�η���õ���SER
end
ser1=2*qfunc(sqrt(2*EsN01)*sin(pi/M));               %�����������
ber1=1/log2(M)*ser1;                                %�����������
semilogy(EsN0,ber,'-ko',EsN0,ser,'-k*',EsN0,ser1,EsN0,ber1,'-k.');
title('16-PSK�ز������ź���AWGN�ŵ��µ�����')
xlabel('Es/N0');ylabel('������ʺ��������')
legend('�������','�������','�����������','�����������')