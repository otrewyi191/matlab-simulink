%ʱ϶ALOHAЭ�����
function [Traffic,S,Delay]=saloha(capture)

%***********  �������  *******************
% capture:          �Ƿ��ǲ���ЧӦ 0:������  1:����

%************* ������� ******************
% Traffic:          ʵ�ʲ�����ҵ����
% S��               ������
% Delay��           ƽ���ӳ� 


%**********************�����ն�״̬�����Լ������������ ********************** 

STANDBY    = 0;         %�ȴ�                                
TRANSMIT   = 1;         %����
COLLISION  = 2;         %��ײ
TOTAL=20000;                                    % �ɹ�����������ݰ���������
%**********************�����ŵ�����  **********************

brate = 6e6;                                  % ��������
Srate = 0.25e6;                                  % ��������
Plen  = 500;                                    % ��������������
Ttime = Plen / Srate;                           % ÿ�����ݰ��Ĵ���ʱ��
Dtime = 0.01;                                   % ��һ�������ӳ�
alfa  = 3;                                      % ·�����ָ��
sigma = 6;                                      % ��Ӱ˥���׼�� [dB]

%**********************����������Ϣ **********************

r   = 100;                                      % ��������뾶 [m]
bxy = [0, 0, 5];                                % �����λ������ (x,y,z)[m]
tcn = 10;                                       % ����������ȷ�źŽ������Ҫ������źŹ��� [dBm]

%**********************�����ն���Ϣ ********************** 

Mnum  = 100;                                    % �ն���Ŀ
mcn   = 30;                                     % �ն��ڷ��������Եʱ���������յ����źŹ��� [dBm]
mpow  = 10^(mcn/10) * sqrt(r^2+bxy(3)^2)^alfa;  % �ն˵ķ����źŹ���
h=0;                                            % �ն˸߶�
mxy = [randsrc(2,Mnum,[-r:r]); randsrc(1,Mnum,[0:h])];  % ��������ն�����
while 1
    d=sqrt(sum(mxy(1:2,:).^2));                         % �ж��ն��������ˮƽ�����Ƿ񳬹�r
    [tmp,indx]=find(d>r);
    if length(indx) == 0                                
        break
    end
    mxy(:,indx)=[randsrc(2,length(indx),[-r:r]);mxy(3,indx)];   %����r��������λ������
end
distance=sqrt(sum(((ones(Mnum,1)*bxy).'-mxy).^2));    %�ն˾�������ľ���
mrnd = randn(1,Mnum);                           % ÿ���ն˵���Ӱ˥��

G=[0.1:0.1:1,1.2:0.2:4];                        % ����ҵ����
for indx=1:length(G)

%**************** ��ʼ����ز��� ******************************    
    Tint  = -Ttime / log(1-G(indx)/Mnum);       % ���ݰ��������������ֵ
    Rint  = Tint;                               % ���ݰ��ش����������ֵ
    Spnum = 0;                                  % �ɹ�����İ�����     
    Splen = 0;                                  % �ɹ�����ķ��ŵĸ���
    Tplen = 0;                                  % ������ķ�����
    Wtime = 0;                                  % �����ӳ�ʱ��(s)
    
    slot          = Plen / Srate;                   % ʱ϶����
    mgtime        = -Tint * log(1-rand(1,Mnum));    % ��ʼ���ݰ�����ʱ��
    mtime         = (fix(mgtime/slot)+1) * slot;    % ���ݰ�����ʱ��
    Mstate        = zeros(1,Mnum);                  % �ն�״̬
    Mplen(1:Mnum) = Plen;                           % ÿ���ն˴�������ݰ����ȴ�С
    now_time     = min(mtime);   

%*********************** ����ѭ�� **************************************    
    while 1
        
        idx = find(mtime==now_time & Mstate==TRANSMIT);     % �ɹ��������ݰ����ն�ID
        
        if length(idx) > 0
            Spnum       = Spnum + 1;
            Splen       = Splen + Mplen(idx);
            Wtime       = Wtime + now_time - mgtime(idx);
            Mstate(idx) = STANDBY;
            mgtime(idx) = now_time - Tint * log(1-rand);    % ��һ�����ݰ�����ʱ��
            mtime(idx)  = (fix(mgtime(idx)/slot)+1) * slot; % ��һ�����ݰ�����ʱ��
        end
        
        idx = find(mtime==now_time & Mstate==COLLISION);    % ���ݰ�����ʧ�ܵ��ն�ID
        if length(idx) > 0
            Mstate(idx) = STANDBY;
            mtime(idx)  = now_time - Rint * log(1-rand(1,length(idx))); %�ش��ȴ�ʱ��     
            mtime(idx)  = (fix(mtime(idx)/slot)+1) * slot;  % ���·���ʱ��
        end
   
       idx = find(mtime==now_time);                         % ��ʼ�������ݰ����ն�ID
        if length(idx) > 0
            Mstate(idx) = TRANSMIT;
            mtime(idx)  = now_time + Mplen(idx) / Srate;    % ���ݰ��������ʱ��
            mtime(idx)  = round(mtime(idx)/slot) * slot;
            Tplen       = Tplen + sum(Mplen(idx));
        end
        
        if Spnum >= TOTAL                                   % ����ɹ���������ݰ��ﵽ�趨�������������
            break
        end
        
        idx = find(Mstate==TRANSMIT | Mstate==COLLISION);   % �����ݰ����������ײ���ն�ID
        if capture == 0                                     % �����ǲ���ЧӦ
            if length(idx) > 1
                Mstate(idx) = COLLISION;                    % ͬʱ�������ݰ����ն�������1,������ײ
            end
        else                                                % ���ǲ���ЧӦ
            if length(idx) > 1
                dxy  = distance(idx);                       % �ȽϷ�����ײ���ն˵ľ���
                pow  = mpow * dxy.^-alfa .* 10.^(sigma/10*mrnd(idx));   % ����������յ��ĸ����ն��źŹ��ʣ����п�������Ӱ˥���Ӱ��
                [maxp no] = max(pow);
                if Mstate(idx(no)) == TRANSMIT
                    if length(idx) == 1
                        cn = 10 * log10(maxp);
                    else
                        cn = 10 * log10(maxp/(sum(pow)-maxp+1));
                    end
                    Mstate(idx) = COLLISION;
                    if cn >= tcn                            % ���յ����źŹ��ʴ��ڲ�������
                        Mstate(idx(no)) = TRANSMIT;         % ����ɹ�
                    end
                else
                    Mstate(idx) = COLLISION;
                end
            end
        end
        now_time = min(mtime);                              % ����ʱ��
    end
    
    Traffic(indx) = Tplen / Srate / now_time;               % ����ʵ�ʲ�����ҵ���� 
    S(indx) = Splen/Srate/now_time;                         % ����������
    Delay(indx) = Wtime / TOTAL * Srate / Plen;             % ����ƽ���ӳ�

end


%%%%%%%%%%%%%%%%%%%%%% end of file %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
