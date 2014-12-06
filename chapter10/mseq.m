
function [mout] = mseq(n, taps, inidata, num)

% ****************************************************************
% n         : m���еĽ���n
% taps      : �����Ĵ���������λ��
% inidata   : �Ĵ����ĳ�ʼֵ���� 
% num       : �����m���еĸ���
% mout      : �����m���У����num>1,��ÿһ��Ϊһ��m����
% ****************************************************************

if nargin < 4
    num = 1;
end

mout = zeros(num,2^n-1);
fpos = zeros(n,1);

fpos(taps) = 1;

for ii=1:2^n-1
    
    mout(1,ii) = inidata(n);                        % �Ĵ��������ֵ
    temp        = mod(inidata*fpos,2);              % ���㷴������ 
    
    inidata(2:n) = inidata(1:n-1);                  % �Ĵ�����λһ��
    inidata(1)     = temp;                          % ���µ�1���Ĵ�����ֵ 
    
end

if num > 1                                          %���Ҫ������m���У���������m����
    for ii=2:num
        mout(ii,:) = shift(mout(ii-1,:),1);
    end
end