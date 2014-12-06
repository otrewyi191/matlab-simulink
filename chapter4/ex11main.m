clear all
snr=-3:3;               %SNR�ķ�Χ
SimulationTime=0;       %�������ʱ��
ex7main;                %����ʾ��4.7
ser1=ser;ber1=ber;      %����ʾ��4.7�Ľ��
for ii=1:length(snr)
    SNR=snr(ii);        %��ֵ��AWGN�ŵ�ģ���е�SNR
    sim('ex11');        %���з���ģ��
    ber(ii)=BER(1);     %���汾�η���õ���BER
    ser(ii)=SER(1);     %���汾�η���õ���SER
end
semilogy(snr,ber,'-rs',snr,ser,'-r^',snr,ber1,'-ro',snr,ser1,'-r*')
legend('Rayleigh˥��+AWGN�ŵ�BER','Rayleigh˥��+AWGN�ŵ�SER','AWGN�ŵ�BER','AWGN�ŵ�SER')
title('QPSK��AWGN�ͶྶRayleigh˥���ŵ��µ�����')
xlabel('����ȣ�dB��')
ylabel('������ʺ��������')