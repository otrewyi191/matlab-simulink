clear all
nsymbol=10000;                      %ÿ��������µķ��ͷ�����
SymbolRate=1000;                    %��������
nsamp=50;                           %ÿ�����ŵ�ȡ������
fs=nsamp*SymbolRate;                %ȡ��Ƶ��
fd=100;                             %Rayleigh˥���ŵ�����������Ƶ��
chan=rayleighchan(1/fs,fd);         %����Rayleigh˥���ŵ�
M=4;                                %4-QAM��4-FSK
graycode=[0 1 3 2 ];                %Gray�������                      
EsN0=0:2:20;                        %����ȣ�Es/N0
snr1=10.^(EsN0/10);                 %�����ת��Ϊ����ֵ
msg=randint(1,nsymbol,M);           %��Ϣ��������
msg1=graycode(msg+1);               %Grayӳ��
x1=qammod(msg1,M);                  %����4-QAM����
x1=rectpulse(x1,nsamp);
x2=fskmod(msg1,M,SymbolRate,nsamp,fs);  %4-FSK����
spow1=norm(x1).^2/nsymbol;              %��4-QAM�ź�ÿ�����ŵ�ƽ������
spow2=norm(x2).^2/nsymbol;              %��4-FSK�ź�ÿ�����ŵ�ƽ������
for indx=1:length(EsN0)
    sigma1=sqrt(spow1/(2*snr1(indx)));                %���ݷ��Ź�������������
    sigma2=sqrt(spow2/(2*snr1(indx))); 
    fadeSig1=filter(chan,x1);           %4-QAM�ź�ͨ��Rayleigh˥���ŵ�
    fadeSig2=filter(chan,x2);           %4-FSK�ź�ͨ��Rayleigh˥���ŵ�
    rx1=fadeSig1+sigma1*(randn(1,length(x1))+j*randn(1,length(x1)));    %�����˹������
    rx2=fadeSig2+sigma2*(randn(1,length(x2))+j*randn(1,length(x2)));
    y1=intdump(rx1,nsamp);              %���
    y1=qamdemod(y1,M);                  %4-QAM�źŽ��    
    decmsg1=graycode(y1+1);             %Gray��ӳ��
    [err,ber1(indx)]=biterr(msg,decmsg1,log2(M));       %4-QAM�ź��������
    [err,ser1(indx)]=symerr(msg,decmsg1);               %4-QAM�ź��������
    y2=fskdemod(rx2,M,SymbolRate,nsamp,fs);             %4-FSK�źŽ��     
    decmsg2=graycode(y2+1);                             %Gray��ӳ��
    [err,ber2(indx)]=biterr(msg,decmsg2,log2(M));       %4-FSK�ź��������
    [err,ser2(indx)]=symerr(msg,decmsg2);               %4-FSK�������
end
semilogy(EsN0,ser1,'-k*',EsN0,ber1,'-ko',EsN0,ser2,'-kv',EsN0,ber2,'-k.');
title('4-QAM��4-FSK�����ź���Rayleigh˥���ŵ��µ�����')
xlabel('Es/N0');ylabel('������ʺ��������')
legend('4-QAM�������','4-QAM�������','4-FSK�������','4-FSK�������')