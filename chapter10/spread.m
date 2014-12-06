%��Ƶ����
function [out] = spread(data, code)

% ****************************************************************
%   data   : ������������
%   code   : ��Ƶ������
%   out    : ��Ƶ��������������
% ****************************************************************

switch nargin
case { 0 , 1 }                                  %�����������������ԣ���ʾ����
    error('ȱ���������');
end

[hn,vn] = size(data);
[hc,vc] = size(code);

if hn > hc                                      %�����Ƶ����С������Ĵ���Ƶ���������У���ʾ����
    error('ȱ����Ƶ������');
end

out = zeros(hn,vn*vc);

for ii=1:hn
    out(ii,:) = reshape(code(ii,:).'*data(ii,:),1,vn*vc);
end

%******************************** end of file ********************************