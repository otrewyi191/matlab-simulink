%ex3.m
%�ֱ�Դ��ڲ���ЧӦ�Ͳ����ڲ���ЧӦʱ��np-CSMAЭ�����ܽ��з��档
clear all
[Traffic1,S1,Delay1] = npcsma(0);        % �޲���ЧӦ������
[Traffic2,S2,Delay2] = npcsma(1);        % �в���ЧӦ������
S = Traffic1 .* exp(-0.1*Traffic1) ./ (Traffic1*(1+2*0.1)+exp(-0.1*Traffic1));       % ����������
 
semilogx(Traffic1,S1,'-ko',Traffic1,S,'-kv',Traffic2,S2,'-k*')
title('np-CSMAЭ���ŵ���������ҵ������ϵ')
xlabel('ҵ����')
ylabel('������')
legend('�޲���ЧӦ������','�޲���ЧӦ����ֵ','�в���ЧӦ������')

figure
semilogx(Traffic1,Delay1,'-ko',Traffic2,Delay2,'-k*')
title('np-CSMAЭ���ӳ���ҵ������ϵ')
xlabel('ҵ����')
ylabel('�ӳ�(���ݰ�����)')
legend('�޲���ЧӦ������','�в���ЧӦ������')