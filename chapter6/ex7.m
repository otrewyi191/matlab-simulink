clear all
nsymbol=100000;                         %ÿ��������µķ��ͷ�����
nsamp=10;                               %ÿ�������źŵĳ�������

M=4;                                    %4-PAM
graycode=[0 1 3 2];                     %Gray�������                      
EsN0=0:15;                              %����ȣ�E/N0
msg=randint(1,nsymbol,4);               %��Ϣ����
msg1=graycode(msg+1);                   %Grayӳ��
msg2=pammod(msg1,M);                    %4-PAM����
s=rectpulse(msg2,nsamp);                %�����������
for indx=1:length(EsN0)
    decmsg=zeros(1,nsymbol);
    r=awgn(real(s),EsN0(indx)-7,'measured');    %ͨ��AWGN�ŵ�
    r1=intdump(r,nsamp);                        %��������
    msg_demod=pamdemod(r1,M);                   %�о�
    decmsg=graycode(msg_demod+1);               %Gray��ӳ��
    [err,ber(indx)]=biterr(msg,decmsg,log2(M)); %���������
    [err,ser(indx)]=symerr(msg,decmsg);
end
semilogy(EsN0,ber,'-ko',EsN0,ser,'-k*',EsN0,1.5*qfunc(sqrt(0.4*10.^(EsN0/10))));
title('4-PAM�ź���AWGN�ŵ��µ�����')
xlabel('Es/N0');ylabel('������ʺ��������')
legend('�������','�������','�����������')