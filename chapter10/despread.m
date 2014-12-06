%�źŽ���

function out = despread(data, code)

% ****************************************************************
%   data    : ������������
%   code    : ����ʹ�õ���Ƶ������
%   out     : ������������������
% ****************************************************************

switch nargin                           %�����������������ԣ���ʾ����
case { 0 , 1 }
    error('ȱ���������');
end

[hn,vn] = size(data);
[hc,vc] = size(code);                  

out    = zeros(hc,vn/vc);                  

for ii=1:hc
    xx=reshape(data(ii,:),vc,vn/vc);
    out(ii,:)= code(ii,:)*xx/vc;
end

%******************************** end of file ********************************
