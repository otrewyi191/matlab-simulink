%ex1-14
for indx=100:999
    a1=fix(indx/100);               %��indx�İ�λ����
    a2=rem(fix(indx/10),10);        %��indx��ʮλ����
    a3=rem(indx,10);                %��indx�ĸ�λ����
    if indx==a1.^3+a2.^3+a3.^3
         indx
    end
end
