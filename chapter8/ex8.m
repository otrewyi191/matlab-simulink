clear all
N=10000;                   %���͵�֡��
L=16;                       %һ֡�е���Ϣ���ظ���
poly=[1 1 1 0 1 0 1 0 1];   %CRC���ɶ���ʽ      
N1=length(poly)-1;          %CRC��ĳ���
EbNo=0:2:10;                  %SNR��Χ
ber=berawgn(EbNo,'qam',16); %16-QAM�����������
for indx=1:length(ber)
    indx
    pe=ber(indx);                   %BSC�ŵ��������
    err=zeros(1,N);                 %�����֡�Ƿ��������    
    err1=zeros(1,N);                %ͨ��CRC��⴫���֡�Ƿ��������
    for iter=1:N
        msg=randint(1,L);           %��Ϣ����
        msg1=[msg zeros(1,N1)];     %��Ϣ��������
        [q,r]=deconv(msg1,poly);    %�ö���ʽ������CRCУ����,qΪ�̣�rΪ����
        r=mod(abs(r),2);            %����ģ2����
        crc=r(L+1:end);             %CRCУ����
        frame=[msg crc];            %����֡
        x=bsc(frame,pe);            %ͨ�������ƶԳ��ŵ�
        [q1,r1]=deconv(x,poly);     %�������г��Զ���ʽ
        r1=mod(abs(r1),2);          %ģ2����
        err(iter)=biterr(frame,x);  %ͳ�Ʊ�֡�Ƿ��������
        err1(iter)=sum(r1);         %ͨ��CRCͳ�Ʊ�֡�Ƿ��������
    end
    fer1(indx)=sum(err~=0);         %��֡��
    fer2(indx)=sum(err1~=0);        %ͨ��CRC������֡��
end
pmissed=(fer1-fer2)/N;              %CRC©��ĸ���
semilogy(EbNo,pmissed)
title('CRC-8�������')
xlabel('Eb/No');ylabel('©�����')

    