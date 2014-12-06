clear all
EbN0=0:10;              %SNR�ķ�Χ

for ii=1:length(EbN0)
    SNR=EbN0(ii);       %��ֵ��AWGN�ŵ�ģ���е�SNR
    sim('ex5');         %���з���ģ��
    ber(ii)=BER(1);     %���汾�η���õ���BER
end
semilogy(EbN0,ber,'-ko',EbN0,qfunc(sqrt(10.^(EbN0/10))),'-k*',EbN0,qfunc(sqrt(2*10.^(EbN0/10))));
title('˫�����ź���AWGN�ŵ��µ������������')
xlabel('Eb/N0');ylabel('�������Pe')
legend('˫�����źŷ�����','�����ź������������','˫�����ź������������')
