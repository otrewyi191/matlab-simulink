clear all
%%%%%%%%%%%%% �������ò��� %%%%%%%%%%%%%%%%%

Nsp=52;             %ϵͳ���ز�����������ֱ���ز���
Nfft=64;            % FFT ����
Ncp=16;             % ѭ��ǰ׺����
Ns=Nfft+Ncp;        % 1������OFDM���ų���
noc=53;             % ����ֱ���ز����ܵ����ز���
Nd=6;               % ÿ֡������OFDM������(������ѵ������)
M1=4;               % QPSK����
M2=16;              % 16-QAM����
sr=250000;          % OFDM��������
EbNo=0:2:30;      	% ��һ�������
Nfrm=10000;                         % ÿ��������µķ���֡��
ts=1/sr/Ns;                         % OFDM���ų���ʱ����
t=0:ts:(Ns*(Nd+1)*Nfrm-1)*ts;      % ����ʱ��
fd=100;                             % ��������Ƶ��
h=rayleigh(fd,t);                   % ���ɵ���Rayleigh˥���ŵ�
h1=sqrt(2/3)*h;
h2=sqrt(1/3)*rayleigh(fd,t);
h2=[zeros(1,4) h2(1:end-4)];



%ѵ������Ƶ������,����802.11a�еĳ�ѵ����������
Preamble=[1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 1 1 -1 -1 1 1 -1 1 -1 1 1 1 1 ...
    1 -1 -1 1 1 -1 1 -1 1 -1 -1 -1 -1 -1 1 1 -1 -1 1 -1 1 -1 1 1 1 1];
Preamble1=zeros(1,Nfft);
Preamble1(2:27)=Preamble(27:end);                   % ǰ�����ź������
Preamble1(39:end)=Preamble(1:26);
preamble1=ifft(Preamble1);                          % ѵ������ʱ������
preamble1=[preamble1(Nfft-Ncp+1:end) preamble1];    % ����ѭ��ǰ׺

%%%%%%%%%%%%%%%%%%%%% ����ѭ�� %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for ii=1:length(EbNo)
     %**************************��������� *****************************
    msg1=randsrc(Nsp,Nd*Nfrm,[0:M1-1]);         % QPSK��Ϣ����
    msg2=randsrc(Nsp,Nd*Nfrm,[0:M2-1]);         % 16-QAM��Ϣ����

    data1=pskmod(msg1,M1,pi/4);                 % QPSK����
    data2=qammod(msg2,M2)/sqrt(10);             % 16-QAM���Ʋ���һ��

    data3=zeros(Nfft,Nd*Nfrm);                  % ����FFTҪ�󣬶���������
    data4=zeros(Nfft,Nd*Nfrm);

    data3(2:27,:)=data1(27:end,:);
    data3(39:end,:)=data1(1:26,:);

    data4(2:27,:)=data2(27:end,:);
    data4(39:end,:)=data2(1:26,:);
        
    clear data1 data2;                           % �������Ҫ����ʱ����

    data3=ifft(data3);                          % IFFT�任
    data4=ifft(data4);

    data3=[data3(Nfft-Ncp+1:end,:);data3];      % ����ѭ��ǰ׺
    data4=[data4(Nfft-Ncp+1:end,:);data4];

    spow1=norm(data3,'fro').^2/(Nsp*Nd*Nfrm);   % �����������
    spow2=norm(data4,'fro').^2/(Nsp*Nd*Nfrm);
        
    data5=zeros(Ns,(Nd+1)*Nfrm);                % ����ѵ������
    data6=data5;
    for indx=1:Nfrm
        data5(:,(indx-1)*(Nd+1)+1)=preamble1.';
        data5(:,(indx-1)*(Nd+1)+2:indx*(Nd+1))=data3(:,(indx-1)*Nd+1:indx*Nd);
         
        data6(:,(indx-1)*(Nd+1)+1)=preamble1.';
        data6(:,(indx-1)*(Nd+1)+2:indx*(Nd+1))=data4(:,(indx-1)*Nd+1:indx*Nd);
    end
        
    clear data3 data4;                                  % �������Ҫ����ʱ����
        
    data5=reshape(data5,1,Ns*(Nd+1)*Nfrm);               % �����任    
    data6=reshape(data6,1,Ns*(Nd+1)*Nfrm);
        
    data51=zeros(1,length(data5));
    data61=zeros(1,length(data6));
    data51(5:end)=data5(1:end-4);
    data61(5:end)=data6(1:end-4);
       
    sigma1=sqrt(1/2*spow1/log2(M1)*10.^(-EbNo(ii)/10)); % ����EbNo����������׼��
    sigma2=sqrt(1/2*spow2/log2(M2)*10.^(-EbNo(ii)/10));

    for indx=1:Nfrm
        dd1=data5((indx-1)*Ns*(Nd+1)+1:indx*Ns*(Nd+1));
        dd2=data6((indx-1)*Ns*(Nd+1)+1:indx*Ns*(Nd+1));
        dd3=data51((indx-1)*Ns*(Nd+1)+1:indx*Ns*(Nd+1));
        dd4=data61((indx-1)*Ns*(Nd+1)+1:indx*Ns*(Nd+1));
            
        hh=h((indx-1)*Ns*(Nd+1)+1:indx*Ns*(Nd+1));      % ��ǰ֡�ĵ����ŵ�����
        hh1=h1((indx-1)*Ns*(Nd+1)+1:indx*Ns*(Nd+1));    % ��ǰ֡��2���ŵ�����
        hh2=h2((indx-1)*Ns*(Nd+1)+1:indx*Ns*(Nd+1));
            
        % �ź�ͨ������˥���ŵ����������˹������
        r1=hh.*dd1+sigma1*(randn(1,length(dd1))+j*randn(1,length(dd1)));   
        r2=hh.*dd2+sigma2*(randn(1,length(dd2))+j*randn(1,length(dd2)));
            
        % �ź�ͨ��2��˥���ŵ����������˹������
        r11=hh1.*dd1+hh2.*dd3+sigma1*(randn(1,length(dd1))+j*randn(1,length(dd1)));   
        r21=hh1.*dd2+hh2.*dd4+sigma2*(randn(1,length(dd2))+j*randn(1,length(dd2)));   

        r1=reshape(r1,Ns,Nd+1);                     % �����任
        r2=reshape(r2,Ns,Nd+1);

        r11=reshape(r11,Ns,Nd+1);
        r21=reshape(r21,Ns,Nd+1);

        r1=r1(Ncp+1:end,:);                         % �Ƴ�ѭ��ǰ׺
        r2=r2(Ncp+1:end,:);            

        r11=r11(Ncp+1:end,:);  
        r21=r21(Ncp+1:end,:);
            
        R1=fft(r1);                                 % fft����
        R2=fft(r2);

        R11=fft(r11);
        R21=fft(r21);

        R1=[R1(39:end,:);R1(2:27,:)];               % ��������
        R2=[R2(39:end,:);R2(2:27,:)];
        R11=[R11(39:end,:);R11(2:27,:)];
        R21=[R21(39:end,:);R21(2:27,:)];
          
        HH1=(Preamble.')./R1(:,1);                  % �ŵ�����
        HH2=(Preamble.')./R2(:,1);                   
        
        HH11=(Preamble.')./R11(:,1);            
        HH21=(Preamble.')./R21(:,1); 
            
        HH1=HH1*ones(1,Nd);
        HH2=HH2*ones(1,Nd);
        HH11=HH11*ones(1,Nd);
        HH21=HH21*ones(1,Nd);        
            
        x1=R1(:,2:end).*HH1;                        % �ŵ�����
        x2=R2(:,2:end).*HH2;
        x3=R11(:,2:end).*HH11;                      
        x4=R21(:,2:end).*HH21;
        
        x1=pskdemod(x1,M1,pi/4);                    % ���ݽ��
        x2=qamdemod(x2.*sqrt(10),M2);
            
        x3=pskdemod(x3,M1,pi/4);                  
        x4=qamdemod(x4.*sqrt(10),M2);        

        [neb1(indx),temp]=biterr(x1,msg1(:,(indx-1)*Nd+1:indx*Nd),log2(M1)); % ͳ��һ֡�еĴ��������
        [neb2(indx),temp]=biterr(x2,msg2(:,(indx-1)*Nd+1:indx*Nd),log2(M2));
        [neb3(indx),temp]=biterr(x3,msg1(:,(indx-1)*Nd+1:indx*Nd),log2(M1)); 
        [neb4(indx),temp]=biterr(x4,msg2(:,(indx-1)*Nd+1:indx*Nd),log2(M2));
    end
    ber1(ii)=sum(neb1)/(Nsp*log2(M1)*Nd*Nfrm);     % �����ŵ����Ƶ��������
    ber2(ii)=sum(neb2)/(Nsp*log2(M2)*Nd*Nfrm);

    ber3(ii)=sum(neb3)/(Nsp*log2(M1)*Nd*Nfrm);     % �������ŵ����Ƶ��������
    ber4(ii)=sum(neb4)/(Nsp*log2(M2)*Nd*Nfrm);
            
end

semilogy(EbNo,ber1,'-ro',EbNo,ber3,'-rv',EbNo,ber2,'-r*',EbNo,ber4,'-rx')
grid on
title('OFDMϵͳ�����������')
legend('QPSK �����ŵ�','QPSK 2���ŵ�','16-QAM �����ŵ�','16-QAM 2���ŵ�')
xlabel('�����(EbNo)')
ylabel('�������')

    
    
