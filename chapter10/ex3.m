%����Gold����DS-CDMA��AWGN�ŵ��µ����ܷ���
clear all
user=[1 4 7];
seq=3;
for indx=1:length(user)
    ber(indx,:)=dscdma(user(indx),seq);
end

EbNo=0:2:10;
semilogy(EbNo,ber(1,:),'-kx',EbNo,ber(2,:),'-ko',EbNo,ber(3,:),'-k*');
legend('user=1','user=4','user=7')
title('����Gold����DS-CDMA��AWGN�ŵ��µ�����')
xlabel('�����EbNo(dB)')
ylabel('�������(BER)')