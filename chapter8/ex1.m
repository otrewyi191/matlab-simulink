clear all
N=10;                       %��Ϣ���ص�����
n=7;                        %Hamming���鳤��n=2^m-1
m=3;                        %�ලλ����
[H,G]=hammgen(m);           %����(n,n-m)Hamming������ɾ����У�����
x=randint(N,n-m);           %������������
y=mod(x*G,2);               %Hamming����        
y1=mod(y+randerr(N,n),2);   %��ÿ����������������һ��������ش���
mat1=eye(n);                %����n*n�ĵ�λ��������ÿһ���е�1����������λ��
errvec=mat1*H.';            %У������Ӧ�����д�������
y2=mod(y1*H.',2);           %����
for indx=1:N
    for indx1=1:n
        if(y2(indx,:)==errvec(indx1,:))
            y1(indx,:)=mod(y1(indx,:)+mat1(indx1,:),2); %������������Ӧ�Ĵ��������ҳ�������ص�λ�ã�������
        end
    end
end
x_dec=y1(:,m+1:end);        %�ָ�ԭʼ��Ϣ����
s=find(x~=x_dec)            %��������Ϣ������ԭʼ��Ϣ���ضԱ�
