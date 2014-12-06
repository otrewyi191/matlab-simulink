clear all
nsamp=10;                               %ÿ�������źŵĳ�������

s0=ones(1,nsamp);                       %���������ź�
s1=-s0;          

nsymbol=100000;                         %ÿ��������µķ��ͷ�����

EbN0=0:10;                               %����ȣ�E/N0
msg=randint(1,nsymbol);                 %��Ϣ����
s00=zeros(nsymbol,1);                   
s11=zeros(nsymbol,1);
indx=find(msg==0);                      %����0�ڷ�����Ϣ�е�λ��
s00(indx)=1;
s00=s00*s0;                             %����0Ӱ��Ϊ���Ͳ���s0
indx1=find(msg==1);                     %����1�ڷ�����Ϣ�е�λ��
s11(indx1)=1;                               
s11=s11*s1;                             %����1ӳ��Ϊ���Ͳ���s1
s=s00+s11;                              %�ܵķ��Ͳ���
s=s.';                                  %����ת�ã�������ն˴���

for indx=1:length(EbN0)
    decmsg=zeros(1,nsymbol);
    r=awgn(s,EbN0(indx)-7);              %ͨ��AWGN�ŵ�
    r00=s0*r;                            %��s0���
    indx1=find(r00<0);               
    decmsg(indx1)=1;                       %�о�
    [err,ber(indx)]=biterr(msg,decmsg);
end
semilogy(EbN0,ber,'-ko',EbN0,qfunc(sqrt(10.^(EbN0/10))),'-k*',EbN0,qfunc(sqrt(2*10.^(EbN0/10))));
title('˫�����ź���AWGN�ŵ��µ������������')
xlabel('Eb/N0');ylabel('�������Pe')
legend('˫�����źŷ�����','�����ź������������','˫�����ź��������������')
