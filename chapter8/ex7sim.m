clear all
EbNo=0:2:10;                  %SNR�ķ�Χ
ber=berawgn(EbNo,'qam',16);
for ii=1:length(EbNo)
    ii
    BER=ber(ii);            %��ֵ��BSC�ŵ�ģ���е�BER
    sim('ex7');             %���з���ģ��
    ber1(ii)=BER1(1);       %���汾�η���õ���BER
end
semilogy(EbNo,ber,'-ko',EbNo,ber1,'-k*');
legend('δ����','RS(15,11)����')
title('δ�����RS(15,11)�����16-QAM��AWGN�µ�����')
xlabel('Eb/No');ylabel('�������')