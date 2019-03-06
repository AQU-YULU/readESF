%软硬阈值函数绘制
% x=-200:1:200;
% lamuda=50;
% Yh=zeros(401,1);
% Ys=zeros(401,1);
% for i=1:401
%     if abs(x(i))>lamuda
%         Yh(i)=-x(i);
%         Ys(i)=-x(i)+lamuda*sign(x(i));
%     else
%         Yh(i)=0;
%         Ys(i)=0;
%     end
% end
% figure;
% subplot(121);plot(x,Yh);
% subplot(122);plot(x,Ys);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% %
% %      original data 方差计算 均值计算
% %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
StdxAng=var(EsfxAng((1:CouxAng),2));
StdyAng=var(EsfyAng((1:CouyAng),2));
StdzAng=var(EsfzAng((1:CouzAng),2));

StdxAcc=var(EsfxAcc((1:CouxAcc),2));
StdyAcc=var(EsfyAcc((1:CouyAcc),2));
StdzAcc=var(EsfzAcc((1:CouzAcc),2));

%均值计算
MeanxAng=mean(EsfxAng((1:CouxAng),2));
MeanyAng=mean(EsfyAng((1:CouyAng),2));
MeanzAng=mean(EsfzAng((1:CouzAng),2));

MeanxAcc=mean(EsfxAcc((1:CouxAcc),2));
MeanyAcc=mean(EsfyAcc((1:CouyAcc),2));
MeanzAcc=mean(EsfzAcc((1:CouzAcc),2));

All=[StdxAng,MeanxAng,StdyAng,MeanyAng,StdzAng,MeanzAng,StdxAcc,MeanxAcc,StdyAcc,MeanyAcc,StdzAcc,MeanzAcc];

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% %
% %      小波去噪后 data 方差计算 均值计算
% %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
wavename='db5';
[WaveSTDxAng,WaveMEANxAng,WavexAngRel]=CalculateSM(EsfxAng((1:CouxAng),2),wavename);
[WaveSTDyAng,WaveMEANyAng,WaveyAngRel]=CalculateSM(EsfyAng((1:CouyAng),2),wavename);
[WaveSTDzAng,WaveMEANzAng,WavezAngRel]=CalculateSM(EsfzAng((1:CouzAng),2),wavename);

[WaveSTDxAcc,WaveMEANxAcc,WavexAccRel]=CalculateSM(EsfxAcc((1:CouxAcc),2),wavename);
[WaveSTDyAcc,WaveMEANyAcc,WaveyAccRel]=CalculateSM(EsfyAcc((1:CouyAcc),2),wavename);
[WaveSTDzAcc,WaveMEANzAcc,WavezAccRel]=CalculateSM(EsfzAcc((1:CouzAcc),2),wavename);
% AllWave=[WaveSTDxAng,WaveMEANxAng,WaveSTDyAng,WaveMEANyAng,WaveSTDzAng,WaveMEANzAng,WaveSTDxAcc,WaveMEANxAcc,WaveSTDyAcc,WaveMEANyAcc,WaveSTDzAcc,WaveMEANzAcc];

% xyz累加结果
SxAcc=zeros(1,CouxAcc);
SyAcc=zeros(1,CouyAcc);
SzAcc=zeros(1,CouzAcc);
for i = 2:CouxAcc+1
    SxAcc(i)=(EsfxAcc(i,2)/8100)^2+SxAcc(i-1);
end
for i = 2:CouyAcc+1
    SyAcc(i)=(EsfyAcc(i,2)/8100)^2+SyAcc(i-1);
end
for i = 2:CouzAcc+1
    SzAcc(i)=(EsfzAcc(i,2)/8100)^2+SzAcc(i-1);
end

SxAng=zeros(1,CouxAng);
SyAng=zeros(1,CouyAng);
SzAng=zeros(1,CouzAng);
for i = 2:CouxAng+1
    SxAng(i)=EsfxAng(i,2)/8100+SxAng(i-1);
end
for i = 2:CouyAcc+1
    SyAng(i)=EsfyAng(i,2)/8100+SyAng(i-1);
end
for i = 2:CouzAcc+1
    SzAng(i)=EsfzAng(i,2)/8100+SzAng(i-1);
end

figure;
subplot(311);plot(SxAcc);
title('x方向加速度累加');
subplot(312);plot(SyAcc);
title('y方向加速度累加');
grid on;
subplot(313);plot(SzAcc);
title('z方向加速度累加');
grid on;

figure;
subplot(311);plot(SxAng);grid on;
title('x方向角速度累加');
subplot(312);plot(SyAng);
title('y方向角速度累加');grid on;
subplot(313);plot(SzAng);
title('z方向角速度累加');grid on;

WavexAng=AccumuFun((WavexAngRel-mean(WavexAngRel))/8100,length(WavexAngRel'));
WaveyAng=AccumuFun((WaveyAngRel-mean(WaveyAngRel))/8100,length(WaveyAngRel'));
WavezAng=AccumuFun((WavezAngRel-mean(WavezAngRel))/8100,length(WavezAngRel'));

WavexAcc=AccumuFun(((WavexAccRel-mean(WavexAccRel))/8100).^2,length(WavexAccRel'));
WaveyAcc=AccumuFun(((WaveyAccRel-mean(WaveyAccRel))/8100).^2,length(WaveyAccRel'));
WavezAcc=AccumuFun(((WavezAccRel-mean(WavezAccRel))/8100).^2,length(WavezAccRel'));

figure;
subplot(311)
plot(WavexAng);
title('去噪后x方向角速度累加');
subplot(312)
plot(WaveyAng);
title('去噪后y方向角速度累加');
grid on;
subplot(313)
plot(WavezAng);
title('去噪后z方向角速度累加');
grid on;


figure;
subplot(311);plot(WavexAcc);grid on;
title('去噪后x方向加速度累加');
subplot(312);plot(WaveyAcc);grid on;
title('去噪后y方向加速度累加');
subplot(313);plot(WavezAcc);
title('去噪后z方向加速度累加');grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                                对比图
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;

subplot(311);
plot(SxAng);grid on;hold on;
plot(WavexAng);
title('x方向角速度累加误差比对');
legend('原始数据','去噪后数据'); 

subplot(312);
plot(SyAng);grid on;hold on;
plot(WaveyAng);grid on;
title('y方向角速度累加误差比对');
legend('原始数据','去噪后数据'); 

subplot(313);
plot(SzAng);grid on;hold on;
plot(WavezAng);grid on;
title('z方向角速度累加误差比对');
legend('原始数据','去噪后数据'); 
