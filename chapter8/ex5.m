m = 4; n = 2^m-1;       %���ֳ���
k = 5;                  %��Ϣ���� 
N= 100;                  %��Ϣ���� 
msg = randint(N,k);     %��Ϣ����
[genpoly,t] = bchgenpoly(n,k);  %��15��5��BCH��ľ�������

code = bchenc(gf(msg),n,k);                 %BCH����
noisycode = code + randerr(N,n,1:t);       %ÿ�����ּ��벻������������������
[newmsg,err,ccode] = bchdec(noisycode,n,k); %BCH����
if ccode==code
   disp('���д�����ض���������')
end
if newmsg==msg
   disp('������Ϣ��ԭ��Ϣ��ͬ��')
end