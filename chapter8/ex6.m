clear all
m=4;                    %ÿ����Ϣ���Ű����ı�����
n=15;                   %���ֳ���
k=11;                   %�����е���Ϣ������
t=(n-k)/2;              %��ľ�������
N=1000;                 %��Ϣ���ŵ�����
msg=randint(N,k,2^m);   %��Ϣ����
msg1=gf(msg,m);         
msg1=rsenc(msg1,n,k).'; %(15,11)RS����
msg2=de2bi(double(msg1.x),'left-msb');  %ת��Ϊ������
y=bsc(msg2,0.01);                       %ͨ�������ƶԳ��ŵ�        
y=bi2de(y,'left-msb');                  %ת��Ϊ10����
y=reshape(y,n,N).';         
dec_x=rsdec(gf(y,4),n,k);               %RS����
[err,ber]=biterr(msg,double(dec_x.x),m) %�������������



