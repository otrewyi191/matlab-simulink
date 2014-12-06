clear all
EbNo=0:2:10;                  %SNR�ķ�Χ
ber=berawgn(EbNo,'qam',16);
for ii=1:length(EbNo)
    ii
    BER=ber(ii);            %��ֵ��BSC�ŵ�ģ���е�BER
    sim('ex9');             %���з���ģ��
    pmissed(ii)=MissedFrame(end)/length(MissedFrame);       %���η���õ���©�����
end
semilogy(EbNo,pmissed,'-ko');
title('CRC-16�������')
xlabel('Eb/No');ylabel('©�����')
axis([0 8 10.^(-6) 10.^(-3)])