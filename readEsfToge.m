%%%%%%%%%%%%%%%%%%%%%%    鍙橀噺璧嬪?    %%%%%%%%%%%%%%%%%%%%%%%
esfData=esf
lenESF=length(esfData)/6;
EsfxAng=zeros(floor(lenESF),2);
EsfyAng=zeros(floor(lenESF),2);
EsfzAng=zeros(floor(lenESF),2);
EsfxAcc=zeros(floor(lenESF),2);
EsfyAcc=zeros(floor(lenESF),2);
EsfzAcc=zeros(floor(lenESF),2);
CouxAng = 1;
CouyAng = 1;
CouzAng = 1;
CouxAcc = 1;
CouyAcc = 1;
CouzAcc = 1;

%鍙朑YRO\ACC鍊?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:lenESF
    if esfData(i,2) == 14
        EsfxAng(CouxAng,1)=esfData(i,1)/1000;
    	EsfxAng(CouxAng,2)=esfData(i,3);
        CouxAng=CouxAng+1;
    elseif esfData(i,2) == 13
    	EsfyAng(CouyAng,1)=esfData(i,1)/1000;
    	EsfyAng(CouyAng,2)=esfData(i,3);
        CouyAng=CouyAng+1;
    elseif esfData(i,2) == 5
    	EsfzAng(CouzAng,1)=esfData(i,1)/1000;
    	EsfzAng(CouzAng,2)=esfData(i,3);
        CouzAng=CouzAng+1;
    elseif esfData(i,2) == 16
        EsfxAcc(CouxAcc,1)=esfData(i,1)/1000;
    	EsfxAcc(CouxAcc,2)=esfData(i,3);
        CouxAcc=CouxAcc+1;
    elseif esfData(i,2) == 17
    	EsfyAcc(CouyAcc,1)=esfData(i,1)/1000;
    	EsfyAcc(CouyAcc,2)=esfData(i,3);
        CouyAcc=CouyAcc+1;
    elseif esfData(i,2) == 18
    	EsfzAcc(CouzAcc,1)=esfData(i,1)/1000;
    	EsfzAcc(CouzAcc,2)=esfData(i,3);
        CouzAcc=CouzAcc+1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
deltaT=0.1;
CouxAng=CouxAng-1;
CouyAng=CouyAng-1;
CouzAng=CouzAng-1;
CouxAcc=CouxAcc-1;
CouyAcc=CouyAcc-1;
CouzAcc=CouzAcc-1;
[TauxAng,allanxAng] = allan_var(EsfxAng(1:(CouxAng),2),deltaT,'Octave');
[TauyAng,allanyAng] = allan_var(EsfyAng(1:(CouyAng),2),deltaT,'Octave');
[TauzAng,allanzAng] = allan_var(EsfzAng(1:(CouzAng),2),deltaT,'Octave');

[TauxAcc,allanxAcc] = allan_var(EsfxAcc(1:(CouxAcc),2),deltaT,'Octave');
[TauyAcc,allanyAcc] = allan_var(EsfyAcc(1:(CouyAcc),2),deltaT,'Octave');
[TauzAcc,allanzAcc] = allan_var(EsfzAcc(1:(CouzAcc),2),deltaT,'Octave');

%%%%%%%%%%%%%%%%%%%%%     notation     %%%%%%%%%%%%%%%%%%%%%
% _________________________________________________________
%     mark 4 kinds of noise
%     slope = -1      T= 3^(1/2) quantization noise
%     slpee = -1/2    T = 1 random walk
%     slpoe = 1/2     T = 3 rate random walk
%     slpoe = 1       T = 2^(1/2) drift rate ramp
% _________________________________________________________    
%%%%%%%%%%%%%%%%%%%%%     notation     %%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%                                   %%%%%%%%%%%%%%
%%%%%%%%%%%                  plot             %%%%%%%%%%%%%%
%%%%%%%%%%%                                   %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%     angle rate     %%%%%%%%%%%%%
figure

loglog(TauxAng,allanxAng,'b');
title('x.y.z方向角速度阿伦方差');
xlabel('相关时间（s）','FontSize',20);                
ylabel('阿伦方差（deg/s)','FontSize',20);
grid on;                           
hold on;  
loglog(TauyAng,allanyAng,'r');
loglog(TauzAng,allanzAng,'c ');
% loglog(t1,l_01,'--','LineWidth',3);
%stem(a,'filled');
legend('X角速度','Y角速度','Z角速度','FontSize',20); 

%%%%%%%%%%%%%     angle rate     %%%%%%%%%%%%%


%%%%%%%%%%%%%      acc rate      %%%%%%%%%%%%%
figure
loglog(TauxAcc,allanxAcc,'b');

xlabel('相关时间（s）','FontSize',20);                
ylabel('阿伦方差:m/s/h','FontSize',20);              
title('x.y.z acc Allan Variance');
grid on;                           
hold on;  
loglog(TauyAcc,allanyAcc,'r');
loglog(TauzAcc,allanzAcc,'c');
legend('X acc','Y acc','Z acc','FontSize',20); 

%%%%%%%%%%%%%      acc rate      %%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%                                   %%%%%%%%%%%%%%
%%%%%%%%%%%    calculate quantization  noise  %%%%%%%%%%%%%%
%%%%%%%%%%%                                   %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

timeLine = 7
logAng    = [log10(allanxAng(1:timeLine));log10(allanyAng(1:timeLine));log10(allanzAng(1:timeLine))]';
logAngTau = [log10(TauxAng(1:timeLine)) ; log10(TauyAng(1:timeLine)) ; log10(TauzAng(1:timeLine))  ]';
bAve=[sum(logAng(:,1)+logAngTau(:,1)),sum(logAng(:,2)+logAngTau(:,2)),sum(logAng(:,3)+logAngTau(:,3))]/7;
QNAng=10.^(-log10(3600*sqrt(3))+bAve)*3600;
QNAngDev=QNAng*0.027;
logAcc    = [log10(allanxAcc(1:timeLine));log10(allanyAcc(1:timeLine));log10(allanzAcc(1:timeLine))]';
logAccTau = [log10(TauxAcc(1:timeLine)) ; log10(TauyAcc(1:timeLine)) ; log10(TauzAcc(1:timeLine))  ]';
bAveAcc=[sum(logAcc(:,1)+logAccTau(:,1)),sum(logAcc(:,2)+logAccTau(:,2)),sum(logAcc(:,3)+logAccTau(:,3))]/7;
QNAcc=10.^(-log10(3600*sqrt(3))+bAveAcc);
QNAccDev=QNAcc*0.3336;

% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%                                   %%%%%%%%%%%%%%
% %%%%%%%%%%%           calculate PSD           %%%%%%%%%%%%%%
% %%%%%%%%%%%                                   %%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
xt=EsfxAng((1:CouxAng),2);
yt=EsfxAng((1:CouyAng),2);
zt=EsfxAng((1:CouzAng),2);

xtc=EsfxAng((1:CouxAcc),2);
ytc=EsfxAng((1:CouyAcc),2);
ztc=EsfxAng((1:CouzAcc),2);
% %下面采用psd函数和pwelch函数进行功率谱估计，对信号序列采用512点FFT，采样率为5000，
% %使用汉宁窗256点，分段混叠点数为128点的WELCH 平均修正周期图估计频谱
% % [Px_psd,f_psd]=psd(xt,512,5000,hanning(256),128);%利用psd进行频谱估计
% [Px_pwelch,fx_pwelch]=pwelch(xt,hanning(1024),216,1024,262500*2);%利用pwelch进行频谱估计
% [Py_pwelch,fy_pwelch]=pwelch(yt,hanning(1024),216,1024,262500*2);%利用pwelch进行频谱估计
% [Pz_pwelch,fz_pwelch]=pwelch(zt,hanning(1024),216,1024,262500*2);%利用pwelch进行频谱估计
% 
% [Pxc_pwelch,fxc_pwelch]=pwelch(xtc,hanning(1024),216,1024,262500*2);%利用pwelch进行频谱估计
% [Pyc_pwelch,fyc_pwelch]=pwelch(ytc,hanning(1024),216,1024,262500*2);%利用pwelch进行频谱估计
% [Pzc_pwelch,fzc_pwelch]=pwelch(ztc,hanning(1024),216,1024,262500*2);%利用pwelch进行频谱估计


% 
% figure;
% % subplot(211)
% % plot(f_psd,10*log10(Px_psd/(512/2)));
% % % plot(f_psd,(Px_psd/(512/2)));
% % xlabel('频率（Hz)');
% % ylabel('功率谱（dB)');
% % title('采用psd得出的功率谱估计');
% % subplot(212)
% subplot(311)
% plot(fx_pwelch,10*log10(Px_pwelch/(512)));
% xlabel('频率（Hz)');
% ylabel('功率谱（dB)');
% title('采用pwelch得出的x角速度功率谱估计');
% set(gca, 'Fontname', '华文中宋','FontSize',12);
% subplot(312)
% plot(fy_pwelch,10*log10(Py_pwelch/(512)));
% xlabel('频率（Hz)');
% ylabel('功率谱（dB)');
% title('采用pwelch得出的y角速度功率谱估计');
% set(gca, 'Fontname', '华文中宋','FontSize',12);
% subplot(313)
% plot(fz_pwelch,10*log10(Pz_pwelch/(512)));
% legend('X角速度','Y角速度','Z角速度','FontSize',20); 
% xlabel('频率（Hz)');
% ylabel('功率谱（dB)');
% title('采用pwelch得出的z角速度功率谱估计');
% set(gca, 'Fontname', '华文中宋','FontSize',12);
% %通过功率谱计算信号功率
% %  Pav_psd=sum(Px_psd)/(512/2);%psd函数需要对FFT点数进行归一化处理，即除以点数的一半
%  Pav_pwelch=sum(Px_pwelch);%pwelch已经进行了归一化
%  
%  figure;
%  subplot(311)
% plot(fxc_pwelch,10*log10(Pxc_pwelch/(512)));
% xlabel('频率（Hz)');
% ylabel('功率谱（dB)');
% set(gca, 'Fontname', '华文中宋','FontSize',12);
% title('采用pwelch得出x加速度的功率谱估计');
% subplot(312)
% plot(fyc_pwelch,10*log10(Pyc_pwelch/(512)));
% xlabel('频率（Hz)');
% ylabel('功率谱（dB)');
% set(gca, 'Fontname', '华文中宋','FontSize',12);
% title('采用pwelch得出y加速度的功率谱估计');
% subplot(313)
% plot(fzc_pwelch,10*log10(Pzc_pwelch/(512)));
% legend('X加速度','Y加速度','Z加速度','FontSize',20); 
% xlabel('频率（Hz)');
% ylabel('功率谱（dB)');
% title('采用pwelch得出z加速度的功率谱估计');
% set(gca, 'Fontname', '华文中宋','FontSize',12);
%  
%  %fft plot
%   FFTinxAng=fft(EsfxAng((1:CouxAng),2),8196*32)/CouxAng*2;
%   FFTinyAng=fft(EsfyAng((1:CouyAng),2),8196*32)/CouyAng*2;
%   FFTinzAng=fft(EsfzAng((1:CouzAng),2),8196*32)/CouzAng*2;
%  figure; 
%  subplot(311)
%  plot(real(FFTinxAng));
%   xlabel('频率（Hz）');
%  ylabel('幅值(deg/s)');
%  title('x角速度FFT变换结果');
%   set(gca, 'Fontname', '华文中宋','FontSize',12);
%   subplot(312)
%  plot(real(FFTinyAng));
%   xlabel('频率（Hz）');
%  ylabel('幅值(deg/s)');
%  title('y角速度FFT变换结果');
%   set(gca, 'Fontname', '华文中宋','FontSize',12);
%   subplot(313)
%  plot(real(FFTinzAng));
%  xlabel('频率（Hz）');
%  ylabel('幅值(deg/s)');
%  title('z角速度FFT变换结果');
%  set(gca, 'Fontname', '华文中宋','FontSize',12);
%  
%   FFTinxAcc=fft(EsfxAcc((1:CouxAcc),2),8196*32)/CouxAcc*2;
%   FFTinyAcc=fft(EsfyAcc((1:CouyAcc),2),8196*32)/CouyAcc*2;
%   FFTinzAcc=fft(EsfzAcc((1:CouzAcc),2),8196*32)/CouzAcc*2;
%  figure; title('加速度FFT变换结果');
%  subplot(311)
%  plot(real(FFTinxAcc));
%   xlabel('频率（Hz）');
%  ylabel('幅值(deg/s)');
%  title('x加速度FFT变换结果');
%  set(gca, 'Fontname', '华文中宋','FontSize',12);
%   subplot(312)
%  plot(real(FFTinyAcc));
%  xlabel('频率（Hz）');
%  ylabel('幅值(deg/s)'); title('y加速度FFT变换结果');
%   set(gca, 'Fontname', '华文中宋','FontSize',12);
%   subplot(313)
%  plot(real(FFTinzAcc));
%  xlabel('频率（Hz）');
%  ylabel('幅值(deg/s)'); title('z加速度FFT变换结果');
%   set(gca, 'Fontname', '华文中宋','FontSize',12);

