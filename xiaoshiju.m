% %%%%%%%%%%%%%%%消失矩%%%%%%%%%%%%%%%%%%
% clc;
% clear;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% f=100;     %%频率
% t=0.002; %%抽样间隔
% n=1:100;
% signal=sin(f.*t.*n);   %%采取信号
% figure(1)
% plot(signal);
% grid on;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%下面我将采用三种消失矩来分解signal%%%%
% N1=2;
% N2=5;
% N3=10;
% %%%%%%%%%%%采用dwt函数%%%%%%%%%%%%%%%%%%
% [L1,H1]=dwt(signal,'db2');
% figure(2)
% subplot(321)
% plot(L1);
% title('消失矩2的低频分量');
% grid on;
%  
% subplot(322);
% plot(H1);
% title('消失矩2的高频分量');
% grid on;
%  
% [L2,H2]=dwt(signal,'db5');
% subplot(323)
% plot(L2)
% title('消失矩5的低频分量');
% grid on;
%  
% subplot(324);
% plot(H2);
% title('消失矩5的高频分量');
% grid on;
%  
% [L3,H3]=dwt(signal,'db10');
% subplot(325)
% plot(L3)
% title('消失矩10的低频分量');
% grid on;
%  
% subplot(326);
% plot(H3);
% title('消失矩10的高频分量');
%  
% grid on;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                     小波时域频域图形
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[phi,g1,xval] = wavefun( 'db5' ,10); 
figure;
subplot(1,2,1); 
plot(xval,g1, 'LineWidth' ,2); 
xlabel( 't' ) ;
title( 'db5  时域 ' ); 
g2=fft(g1); 
g3=abs(g2); 
subplot(1,2,2);
plot(g3, 'LineWidth' ,2); 
xlabel( 'f' ) ;
title( 'db5  频域 ' ) ;

figure;
%尺度函数
subplot(121),plot(xval,phi)
title('db5小波尺度函数');
%小波函数
subplot(122),plot(xval,g1)
title('db5小波函数');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                  计算该小波的 4 个滤波器
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters( 'db5' ); 
figure;
subplot(2,2,1); 
stem(Lo_D, 'LineWidth' ,2); 
title( '分解低通滤波器 ');
subplot(2,2,2); 
stem(Hi_D, 'LineWidth' ,2); 
title( '分解高通滤波器 '); 
subplot(2,2,3); 
stem(Lo_R, 'LineWidth' ,2); 
title( '重构低通滤波器 '); 
subplot(2,2,4); 
stem(Hi_R, 'LineWidth' ,2); 
title( '重构高通滤波器 '); 

