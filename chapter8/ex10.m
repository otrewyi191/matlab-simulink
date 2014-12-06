clear all
EbNo=0:2:10;                      %SNR�ķ�Χ
N=100000;                      %��Ϣ���ظ���
M=2;                            %BPSK����
L=7;                            %Լ������
trel=poly2trellis(L,[171 133]); %��������ɶ���ʽ
tblen=6*L;                      %Viterbi������������ȡ�
msg=randint(1,N);               %��Ϣ��������
msg1=convenc(msg,trel);         %�������
x1=pskmod(msg1,M);              %BPSK����
for ii=1:length(EbNo)
    ii
    y=awgn(x1,EbNo(ii)-3);          %�����˹����������Ϊ����Ϊ1/2������ÿ�����ŵ�����Ҫ�ȱ���������3dB
    y1=pskdemod(y,M);               %Ӳ�о�
    y1=vitdec(y1,trel,tblen,'cont','hard');                     %Viterbi����
    [err,ber1(ii)]=biterr(y1(tblen+1:end),msg(1:end-tblen));    %�������
    
    y2=vitdec(real(y),trel,tblen,'cont','unquant');             %���о�
    [err,ber2(ii)]=biterr(y2(tblen+1:end),msg(1:end-tblen));    %�������
    
end
ber=berawgn(EbNo,'psk',2,'nodiff');                             %BPSK���������������
semilogy(EbNo,ber,'-ko',EbNo,ber1,'-k*',EbNo,ber2,'-k.');
legend('BPSK�����������','Ӳ�о��������','���о��������')
title('���������')
xlabel('Eb/No');ylabel('�������')
