function [StdRel,MeanRel,de_in_rigrsure] = CalculateSM(InData,WaveName)
% InData=EsfxAng(1:LenData,2);
% length=CouxAng;%size(esf090318);
[C,L]=wavedec(InData,5,WaveName);
%���ź�����ȡС��ϵ����cD1Ϊ����С��ϵ��
cA3=appcoef(C,L,WaveName,5);
cD1=detcoef(C,L,1);
cD2=detcoef(C,L,2);
cD3=detcoef(C,L,3);
cD4=detcoef(C,L,4);
cD5=detcoef(C,L,5);
%ʹ��stein����ƫ��Ȼ����ԭ����и�����ֵѡ��
%-----------------��rigrsure'----------------------Ϊ��ƫ��Ȼ������ֵ���ͣ�SORHΪѡ����ֵ����
th1_rigrsure=thselect(cD1,'rigrsure');
th2_rigrsure=thselect(cD2,'rigrsure');
th3_rigrsure=thselect(cD3,'rigrsure');
th4_rigrsure=thselect(cD4,'rigrsure');
th5_rigrsure=thselect(cD5,'rigrsure');
TR_rigrsure=[th1_rigrsure,th2_rigrsure,th3_rigrsure,th4_rigrsure,th5_rigrsure];
%
%-----------------------------------------------------------------------------
SORH='h';%����ֵ

%---------denoise----------

%XCΪȥ����ź�
%[CXC,LXC]ΪС���ķֽ�ṹ
%PERF0& PERF2�ǻָ���ѹ���ķ����ٷֱ� 
%��lvd'Ϊ�������õĸ�����ֵ
%'gbl'Ϊ�̶���ֵ
%3Ϊ��ֵ�ĳ���

[XC_rigrsure,CXC_rigrsure,LXC_rigrsure,PERF0_rigrsure,PERF2_rigrsure]=wdencmp('lvd',InData,WaveName,5,TR_rigrsure,SORH);
%-----------denoise measure  SNR bigger is better MSE smaller is better
% N=CouxAng;%length();
de_in_rigrsure=XC_rigrsure;
StdRel=var(de_in_rigrsure);
MeanRel=mean(de_in_rigrsure);