%ex1.m
%�ֱ�Դ��ڲ���ЧӦ�Ͳ����ڲ���ЧӦʱ��ALOHAЭ�����ܽ��з��档
clear all
[Traffic1,S1,Delay1] = aloha(0);        % �޲���ЧӦ������
[Traffic2,S2,Delay2] = aloha(1);        % �в���ЧӦ������
S = Traffic1 .* exp(-2*Traffic1);       % ����������

plot(Traffic1,S1,'-ko',Traffic1,S,'-kv',Traffic2,S2,'-k*')
title('ALOHAЭ���ŵ���������ҵ������ϵ')
xlabel('ҵ����')
ylabel('������')
legend('�޲���ЧӦ������','�޲���ЧӦ����ֵ','�в���ЧӦ������')

figure
plot(Traffic1,Delay1,'-ko',Traffic2,Delay2,'-k*')
title('ALOHAЭ���ӳ���ҵ������ϵ')
xlabel('ҵ����')
ylabel('�ӳ�(���ݰ�����)')
legend('�޲���ЧӦ������','�в���ЧӦ������')