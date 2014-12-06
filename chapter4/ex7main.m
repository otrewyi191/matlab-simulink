clear all
snr=-3:3;               %SNR�ķ�Χ
SimulationTime=10;  %�������ʱ��
for ii=1:length(snr)
    SNR=snr(ii);        %��ֵ��AWGN�ŵ�ģ���е�SNR
    sim('ex7');         %���з���ģ��
    ber(ii)=BER(1);     %���汾�η���õ���BER
    ser(ii)=SER(1);     %���汾�η���õ���SER
end
figure
semilogy(snr,ber,'-ro',snr,ser,'-r*')
legend('BER','SER')
title('QPSK��AWGN�ŵ��µ�����')
xlabel('����ȣ�dB��')
ylabel('������ʺ��������')