% %%%%%%%%%%%%%%%��ʧ��%%%%%%%%%%%%%%%%%%
% clc;
% clear;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% f=100;     %%Ƶ��
% t=0.002; %%�������
% n=1:100;
% signal=sin(f.*t.*n);   %%��ȡ�ź�
% figure(1)
% plot(signal);
% grid on;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%�����ҽ�����������ʧ�����ֽ�signal%%%%
% N1=2;
% N2=5;
% N3=10;
% %%%%%%%%%%%����dwt����%%%%%%%%%%%%%%%%%%
% [L1,H1]=dwt(signal,'db2');
% figure(2)
% subplot(321)
% plot(L1);
% title('��ʧ��2�ĵ�Ƶ����');
% grid on;
%  
% subplot(322);
% plot(H1);
% title('��ʧ��2�ĸ�Ƶ����');
% grid on;
%  
% [L2,H2]=dwt(signal,'db5');
% subplot(323)
% plot(L2)
% title('��ʧ��5�ĵ�Ƶ����');
% grid on;
%  
% subplot(324);
% plot(H2);
% title('��ʧ��5�ĸ�Ƶ����');
% grid on;
%  
% [L3,H3]=dwt(signal,'db10');
% subplot(325)
% plot(L3)
% title('��ʧ��10�ĵ�Ƶ����');
% grid on;
%  
% subplot(326);
% plot(H3);
% title('��ʧ��10�ĸ�Ƶ����');
%  
% grid on;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                     С��ʱ��Ƶ��ͼ��
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[phi,g1,xval] = wavefun( 'db5' ,10); 
figure;
subplot(1,2,1); 
plot(xval,g1, 'LineWidth' ,2); 
xlabel( 't' ) ;
title( 'db5  ʱ�� ' ); 
g2=fft(g1); 
g3=abs(g2); 
subplot(1,2,2);
plot(g3, 'LineWidth' ,2); 
xlabel( 'f' ) ;
title( 'db5  Ƶ�� ' ) ;

figure;
%�߶Ⱥ���
subplot(121),plot(xval,phi)
title('db5С���߶Ⱥ���');
%С������
subplot(122),plot(xval,g1)
title('db5С������');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                  �����С���� 4 ���˲���
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters( 'db5' ); 
figure;
subplot(2,2,1); 
stem(Lo_D, 'LineWidth' ,2); 
title( '�ֽ��ͨ�˲��� ');
subplot(2,2,2); 
stem(Hi_D, 'LineWidth' ,2); 
title( '�ֽ��ͨ�˲��� '); 
subplot(2,2,3); 
stem(Lo_R, 'LineWidth' ,2); 
title( '�ع���ͨ�˲��� '); 
subplot(2,2,4); 
stem(Hi_R, 'LineWidth' ,2); 
title( '�ع���ͨ�˲��� '); 

