clear all
Lc=7;                       %�����Լ������
BitRate=100000;             %��������
EbNo=0:2:10;                      %SNR�ķ�Χ
for ii=1:length(EbNo)
    ii
    SNR=EbNo(ii);               %��ֵ��AWGN�ŵ�ģ���е�SNR
    sim('ex11');                %���з���ģ��
    ber1(ii)=BER1(1);           %���汾�η���õ���BER
    ber2(ii)=BER2(1);
end
ber=berawgn(EbNo,'psk',2,'nodiff');   
semilogy(EbNo,ber,'-ko',EbNo,ber1,'-k*',EbNo,ber2,'-k.');
legend('BPSK�����������','Ӳ�о��������','���о��������')
title('���������')
xlabel('Eb/No');ylabel('�������')
