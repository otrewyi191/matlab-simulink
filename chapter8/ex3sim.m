clear all
EbNo=0:2:10;                  %SNR�ķ�Χ
SymbolRate=50000;           %��������
for ii=1:length(EbNo)
    ii
    SNR=EbNo(ii);           %��ֵ��AWGN�ŵ�ģ���е�SNR
    sim('ex3');             %���з���ģ��
    ber1(ii)=BER1(1);       %���汾�η���δ����õ���BER
    ber2(ii)=BER2(1);       %���汾�η���Hamming����õ���BER
end
semilogy(EbNo,ber1,'-ko',EbNo,ber2,'-k*');
legend('δ����','Hamming(7,4)����')
title('δ�����Hamming(7,4)�����QPSK��AWGN�µ�����')
xlabel('Eb/No');ylabel('�������')