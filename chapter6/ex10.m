clear all
nsymbol=100000;                         %ÿ��������µķ��ͷ�����

Fd=1;               %���Ų���Ƶ��
Fs=10;              %�˲�������Ƶ��
rolloff=0.25;       %�˲�������ϵ��
delay=5;            %�˲���ʱ��
M=4;                                    %4-PAM
graycode=[0 1 3 2];                     %Gray�������                      
EsN0=0:15;                              %����ȣ�E/N0
msg=randint(1,nsymbol,4);               %��Ϣ����
msg1=graycode(msg+1);                   %Grayӳ��
msgmod=pammod(msg1,M);                  %4-PAM����
rrcfilter = rcosine(Fd,Fs,'fir/sqrt',rolloff,delay);   %��Ƹ��������˲���
s=rcosflt(msgmod,Fd,Fs,'filter',rrcfilter);
for indx=1:length(EsN0)
    decmsg=zeros(1,nsymbol);
    r=awgn(real(s),EsN0(indx)-7,'measured');
    rx=rcosflt(r,Fd,Fs,'Fs/filter',rrcfilter);
    rx1=downsample(rx,Fs);
    rx2=rx1(2*delay+1:end-2*delay);
    msg_demod=pamdemod(rx2,M);            %%�о�
    decmsg=graycode(msg_demod+1);       %Gray��ӳ��
    [err,ber(indx)]=biterr(msg,decmsg,log2(M));    %���������
    [err,ser(indx)]=symerr(msg,decmsg);
end
semilogy(EsN0,ber,'-ko',EsN0,ser,'-k*',EsN0,1.5*qfunc(sqrt(0.4*10.^(EsN0/10))));
title('4-PAM�ź���AWGN��������ŵ��µ�����')
xlabel('Es/N0');ylabel('������ʺ��������')
legend('�������','�������','�����������')