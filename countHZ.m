cou=0;
% RAWDATA=Raw1108;
% for i=1:length(RAWDATA)
%     if (RAWDATA(i,1)>=104469700 && RAWDATA(i,1)<104469800 && RAWDATA(i,2)==5)
%         cou=cou+1;
%     end
% end

YxAng=fft(EsfxAng(1:CouxAng,2),2048*32);
YyAng=fft(EsfyAng(1:CouyAng,2),2048*32);
YzAng=fft(EsfzAng(1:CouzAng,2),2048*32);
figure;
% subplot(311);
plot(real(YxAng));grid on;hold on;
title('x方向角速度FFT变换结果');
xlabel('频率/Hz');
ylabel('振幅');
figure;
% subplot(312);
plot(real(YyAng));grid on;hold on;
title('y方向角速度FFT变换结果');
xlabel('频率/Hz');
ylabel('振幅');
% subplot(313);
figure;
plot(real(YzAng));grid on;hold on;
title('z方向角速度FFT变换结果');
xlabel('频率/Hz');
ylabel('振幅');

figure
plot(EsfxAng(1:CouyAng,2));
grid on;
% % %直接法又称为周期图法，就是把x(n)的N个数据视为已能量有限的序列，直接计算
% % %x(n)的离散傅里叶变换，得X（k)，然后再取其幅值的平方，作为功率谱的估计
% % t=linspace(0,1,1000);
% % signal=4*sin(2*pi*50*t)+5*sin(2*pi*200*t);
% % noise=randn(size(t));
% % symbol=signal+noise;
% % Y=fft(symbol,128);
% % f=1000*(0:127)/128;
% % P1=Y.*conj(Y)/128; %直接法
% % plot(f,10*log10(P1(1:128)));
% % xlabel('frequency')
% % ylabel('power')
% % title('直接法')
% % %或者用下面代码
% % Fs=1000;% 采样频率
% % n=0:1/Fs:1;
% % xn=cos(2*pi*40*n)+3*cos(2*pi*100*n)+randn(size(n));
% % window=boxcar(length(xn));%矩形窗
% % nfft=1024;
% % [Pxx,f]=periodogram(xn,window,nfft,Fs);
% % plot(f,10*log10(Pxx));
% clear;
% fs=500;  %采样率
% df=0.1;    %频率分辨率
% N=floor(fs/df)+1;%计算的序列点数
% t=0:1/fs:(N-1)/fs;%截取信号的时间段
% f=0:df:fs;%功率谱估计的频率分辨率和范围
% % f=0:df:100;%功率谱估计的频率分辨率和范围
% xt=sin(2*pi*50*5)+2*sin(2*pi*130*t)+randn(1,length(t));
% %截取时间段上的离散信号样本序列
% 
% %利用周期图法进行功率谱估计，但是其得出的功率谱很不光滑，相应的估计协方差比较大
% %增加采样点数也不能使周期图变得更加平滑，这是周期图的缺点，在后面对其改进。
% Px=abs(fft(xt)).^2/(N^2);%功率谱估计
% Pav_tm=sum(xt.^2)/N;%在时域计算信号功率
% Pav_fn=sum(Px);%通过功率谱计算信号功率
% figure(1)
% subplot(221)   %作出功率谱密度图
% % plot(f,10*log10(Px));
% plot(f,(Px));
% PSD1=sum(Px)
% % xlable('Freq(Hz)');
% % Ylable('PSD(dB)');
% title('周期图得出的功率谱估计');
% 
% %对周期图进行改进的思想是将信号段进行估计，然后再将这些估计结果进行平均，
% %从而减小估计的协方差，使估计功率谱图变得平滑。
% %本程序是将以上501点的信号分3段，分别作周期图估计，然后平均。
% Px=(abs(fft(xt(1:167))).^2+abs(fft(xt(168:334))).^2+abs(fft(xt(335:501))).^2)/3/((N/3)^2);%分为三段
% Pav_tm=sum(xt.^2)/N;%在时域计算信号功率
% Pav_fn=sum(Px);%通过功率谱计算信号功率
% subplot(222)   %作出功率谱密度图
% % plot(0:3:fs,10*log10(Px));
% plot(0:3:fs,(Px));
% % xlable('频率（Hz)');
% % Ylable('功率谱（dB)');
% title('分段估计得出的功率谱估计');
% 
% %增加分段数可以进一步降低估计的协方差，然而每段中的数据点太少，就会使估计的
% %频率分辨率下降很多。在样本信号序列总点数一定的条件下，可以采用使分段相互重叠
% %的方法来增加分段数，从而保持每段中信号点数不变，这样就在保证频率分辨率的前提下
% %进一步降低了估计的协方差。本程序中，从分段长度的一半处进行分段叠加，这样将
% %501点信号分为5段，每段167点，相邻重叠83点
% Px=(abs(fft(xt(1:167))).^2+abs(fft(xt(83:249))).^2+abs(fft(xt(168:334))).^2+abs(fft(xt(250:416))).^2+abs(fft(xt(335:501))).^2)/5/((N/3)^2);
% %看似分为5段，但每段的采样点数都是N的1、3
% Pav_tm=sum(xt.^2)/N;%在时域计算信号功率
% Pav_fn=sum(Px);%通过功率谱计算信号功率
% subplot(223)   %作出功率谱密度图
% % plot(0:3:fs,10*log10(Px));
% plot(0:3:fs,(Px));
% % xlable('频率（Hz)');
% % Ylable('功率谱（dB)');
% title('重叠分段估计得出的功率谱估计');
% 
% %采用窗函数对时域信号进行预处理也可以降低估计的协方差，这也是窗函数的一个应用
% %方面。在计算周期图法之前，对数据分段并加非矩形窗（如海明窗），然后再用分段长度
% %一半的混叠率，就能大大降低估计协方差。这种方法称为WEICH平均修正周期图法
% %简称WELCH法，程序采用汉宁窗
% w=hanning(167)';
% w=w*sqrt(167/sum(w.*w));
% Px=(abs(fft(xt(1:167))).^2+abs(fft(xt(83:249))).^2+abs(fft(xt(168:334))).^2+abs(fft(xt(250:416))).^2+abs(fft(xt(335:501))).^2)/5/((N/3)^2);
% %看似分为5段，但每段的采样点数都是N的1、3
% Pav_tm=sum(xt.^2)/N;%在时域计算信号功率
% Pav_fn=sum(Px);%通过功率谱计算信号功率
% subplot(224)   %作出功率谱密度图
% % plot(0:3:fs,10*log10(Px));
% plot(0:3:fs,(Px));
% % xlable('频率（Hz)');
% % Ylable('功率谱（dB)');
% title('采用汉宁窗的WEICH平均修正周期图法得出的功率谱估计');
% 
% 
% %下面采用psd函数和pwelch函数进行功率谱估计，对信号序列采用512点FFT，采样率为500，
% %使用汉宁窗256点，分段混叠点数为128点的WELCH 平均修正周期图估计频谱
% [Px_psd,f_psd]=psd(xt,512,500,hanning(256),128);%利用psd进行频谱估计
% [Px_pwelch,f_pwelch]=pwelch(xt,hanning(256),128,512,500);%利用pwelch进行频谱估计
% figure(2);
% subplot(211)
% % plot(f_psd,10*log10(Px_psd/(512/2)));
% plot(f_psd,(Px_psd/(512/2)));
% % xlable('频率（Hz)');
% % Ylable('功率谱（dB)');
% title('采用psd得出的功率谱估计');
% subplot(212)
% % plot(f_pwelch,10*log10(Px_pwelch/(512/2)));
% plot(f_pwelch,(Px_pwelch/(512/2)));
% % xlable('频率（Hz)');
% % Ylable('功率谱（dB)');
% title('采用pwelch得出的功率谱估计');
% %通过功率谱计算信号功率
%  Pav_psd=sum(Px_psd)/(512/2);%psd函数需要对FFT点数进行归一化处理，即除以点数的一半
%  Pav_pwelch=sum(Px_pwelch);%pwelch已经进行了归一化