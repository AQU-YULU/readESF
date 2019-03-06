function [StdRel,MeanRel,de_in_rigrsure] = CalculateSM(InData,WaveName)
% InData=EsfxAng(1:LenData,2);
% length=CouxAng;%size(esf090318);
[C,L]=wavedec(InData,5,WaveName);
%从信号中提取小波系数，cD1为各层小波系数
cA3=appcoef(C,L,WaveName,5);
cD1=detcoef(C,L,1);
cD2=detcoef(C,L,2);
cD3=detcoef(C,L,3);
cD4=detcoef(C,L,4);
cD5=detcoef(C,L,5);
%使用stein的五偏似然估计原理进行各层阈值选择
%-----------------‘rigrsure'----------------------为无偏似然估计阈值类型，SORH为选择阈值类型
th1_rigrsure=thselect(cD1,'rigrsure');
th2_rigrsure=thselect(cD2,'rigrsure');
th3_rigrsure=thselect(cD3,'rigrsure');
th4_rigrsure=thselect(cD4,'rigrsure');
th5_rigrsure=thselect(cD5,'rigrsure');
TR_rigrsure=[th1_rigrsure,th2_rigrsure,th3_rigrsure,th4_rigrsure,th5_rigrsure];
%
%-----------------------------------------------------------------------------
SORH='h';%软阈值

%---------denoise----------

%XC为去噪后信号
%[CXC,LXC]为小波的分解结构
%PERF0& PERF2是恢复和压缩的范数百分比 
%’lvd'为允许设置的各层阈值
%'gbl'为固定阈值
%3为阈值的长度

[XC_rigrsure,CXC_rigrsure,LXC_rigrsure,PERF0_rigrsure,PERF2_rigrsure]=wdencmp('lvd',InData,WaveName,5,TR_rigrsure,SORH);
%-----------denoise measure  SNR bigger is better MSE smaller is better
% N=CouxAng;%length();
de_in_rigrsure=XC_rigrsure;
StdRel=var(de_in_rigrsure);
MeanRel=mean(de_in_rigrsure);