%ex4.m
%����V-BALST�ṹMMSE����㷨���ܣ����Ʒ�ʽΪQPSK
clear all
Nt=4;                           % ����������
Nr=4;                           % ����������
N=10;                           % ÿ֡�ĳ���
L=10000;                        % �������֡��
EbNo=0:2:20;                    % �����
M=4;                            % QPSK ���Ʒ�ʽ
x=randint(N*L,Nt,M);            % ��Դ����
s=pskmod(x,M,pi/4);             % QPSK����
                       
for indx=1:length(EbNo)
    x1=[];
    x2=[];
    x3=[];
    for indx1=1:L
        h=randn(Nt,Nr)+j*randn(Nt,Nr);          % Rayleigh˥���ŵ�
        h=h./sqrt(2);                           % �ŵ�ϵ����һ��

        sigma1=sqrt(1/(10.^(EbNo(indx)/10)));   % ÿ���������ߵĸ�˹��������׼��
        n=sigma1*(randn(N,Nr)+j*randn(N,Nr));   % ÿ���������ߵĸ�˹������
        w=h'*inv(h*h'+2*sigma1.^2*diag(ones(1,Nt)));    % w�����Ž�
        
        y=s((indx1-1)*N+1:indx1*N,:)*h+n;       % �ź�ͨ���ŵ�
        yy=y;
        y1=y*w;                                 % �޸�������ʱ��MMSE���
        temp1=pskdemod(y1,M,pi/4);              % �޸�������ʱ�Ľ��    
        x1=[x1;temp1];                          % �޸�������ʱ�Ľ�����
        
        temp2(:,Nt)=temp1(:,Nt);
        y=y-pskmod(temp2(:,Nt),4,pi/4)*h(Nt,:);     % �������������ʱ�������źž���ĸ���
        
        temp3(:,Nt)=temp1(:,Nt);
        yy=yy-s((indx1-1)*N+1:indx1*N,Nt)*h(Nt,:);  % �����������ʱ�������źž���ĸ���
        
        h=h(1:Nt-1,:);                              % �ŵ��������     
        
        for ii=Nt-1:-1:1
            w=h'*inv(h*h'++2*sigma1.^2*diag(ones(1,ii)));   % �ŵ�������º��w
            
            y1=y*w;                                         % ��������������ļ������     
            temp2(:,ii)=pskdemod(y1(:,ii),M,pi/4);      
            y=y-pskmod(temp2(:,ii),4,pi/4)*h(ii,:);
            
            yy1=yy*w;                                       % ������������ļ������
            temp3(:,ii)=pskdemod(yy1(:,ii),M,pi/4);
            yy=yy-s((indx1-1)*N+1:indx1*N,ii)*h(ii,:);
        
            h=h(1:ii-1,:);
        end

        x2=[x2;temp2];                      % ��������������Ľ�����
        x3=[x3;temp3];                      % ������������Ľ�����
    end
            
    [temp,ber1(indx)]=biterr(x,x1,log2(M));             % �޸�������ʱ��ϵͳ������
    [temp,ber2(indx)]=biterr(x,x2,log2(M));             % �������������ʱϵͳ�ܵ�������
    [temp,ber3(indx)]=biterr(x,x3,log2(M));             % �����������ʱϵͳ�ܵ�������
    
    [temp,ber24(indx)]=biterr(x(:,1),x2(:,1),log2(M));   % �������������ʱ��4���������
    [temp,ber23(indx)]=biterr(x(:,2),x2(:,2),log2(M));   % �������������ʱ��3���������
    [temp,ber22(indx)]=biterr(x(:,3),x2(:,3),log2(M));   % �������������ʱ��2���������
    [temp,ber21(indx)]=biterr(x(:,4),x2(:,4),log2(M));   % �������������ʱ��1���������
    
    [temp,ber34(indx)]=biterr(x(:,1),x3(:,1),log2(M));   % �����������ʱ��4���������
    [temp,ber33(indx)]=biterr(x(:,2),x3(:,2),log2(M));   % �����������ʱ��3���������
    [temp,ber32(indx)]=biterr(x(:,3),x3(:,3),log2(M));   % �����������ʱ��2���������
    [temp,ber31(indx)]=biterr(x(:,4),x3(:,4),log2(M));   % �����������ʱ��1���������


    
end
semilogy(EbNo,ber1,'-k*',EbNo,ber2,'-ko',EbNo,ber3,'-kd')
title('V-BLAST�ṹMMSE����㷨����')
legend('�޸�������','�������������','�����������')
xlabel('EbNo(dB)')
ylabel('BER')

figure
semilogy(EbNo,ber34,'-k*',EbNo,ber33,'-ko',EbNo,ber32,'-kd',EbNo,ber31,'-k^')
title('�����������ʱMMSE����㷨��������')
legend('��1��','��2��','��3��','��4��')
xlabel('EbNo(dB)')
ylabel('BER')

figure
semilogy(EbNo,ber24,'-k*',EbNo,ber23,'-ko',EbNo,ber22,'-kd',EbNo,ber21,'-k^')
title('�������������ʱMMSE����㷨��������')
legend('��1��','��2��','��3��','��4��')
xlabel('EbNo(dB)')
ylabel('BER')
