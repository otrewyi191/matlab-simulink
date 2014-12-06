clear all
N=100000;               %��Ϣ��������
M=4;                    %QPSK����
n=7;                    %Hamming�������鳤��
m=3;                    %Hamming��ලλ����
graycode=[0 1 3 2];

msg=randint(N,n-m);     %��Ϣ����
msg1=reshape(msg.',log2(M),N*(n-m)/log2(M)).';
msg1_de=bi2de(msg1,'left-msb');     %��Ϣ����ת��Ϊ10������ʽ
msg1=graycode(msg1_de+1);           %Gray����
msg1=pskmod(msg1,M);                %QPSK����
Eb1=norm(msg1).^2/(N*(n-m));        %�����������
msg2=encode(msg,n,n-m);             %Hamming����
msg2=reshape(msg2.',log2(M),N*n/log2(M)).';
msg2=bi2de(msg2,'left-msb');
msg2=graycode(msg2+1);              %Hamming�����ı�������ת��Ϊ10������ʽ
msg2=pskmod(msg2,M);                %Hamming�������ݽ���QPSK����
Eb2=norm(msg2).^2/(N*(n-m));        %�����������
EbNo=0:2:10;                          %�����
EbNo_lin=10.^(EbNo/10);             %����ȵ�����ֵ
for indx=1:length(EbNo_lin)
    indx
    sigma1=sqrt(Eb1/(2*EbNo_lin(indx)));    %δ�����������׼��
    rx1=msg1+sigma1*(randn(1,length(msg1))+j*randn(1,length(msg1)));    %�����˹������
    y1=pskdemod(rx1,M);                     %δ����QPSK���
    y1_de=graycode(y1+1);                   %δ�����Gray��ӳ��
    [err ber1(indx)]=biterr(msg1_de.',y1_de,log2(M));   %δ������������
    
    sigma2=sqrt(Eb2/(2*EbNo_lin(indx)));    %�����������׼��
    rx2=msg2+sigma2*(randn(1,length(msg2))+j*randn(1,length(msg2)));    %�����˹������   
    y2=pskdemod(rx2,M);                     %����QPSK���
    y2=graycode(y2+1);                      %����Gray��ӳ��
    y2=de2bi(y2,'left-msb');                %ת��Ϊ��������ʽ
    y2=reshape(y2.',n,N).';
    y2=decode(y2,n,n-m);                    %����
    [err ber2(indx)]=biterr(msg,y2);        %������������

end
semilogy(EbNo,ber1,'-ko',EbNo,ber2,'-k*');
legend('δ����','Hamming(7,4)����')
title('δ�����Hamming(7,4)�����QPSK��AWGN�µ�����')
xlabel('Eb/No');ylabel('�������')