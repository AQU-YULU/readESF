% [C,L]=wavedec(s,5,'sym8'); %���ź�s��С����sym8������5��ֽ�
% a5=appcoef(C,L,'sym8',5); % ȡ�ֽ��Ľ��Ʋ��֣�Ҳ���ǵ�5���Ƶϵ��
% d5=detcoef(C,L,5); % ȡ�ֽ���ϸ�ڲ��֣���5���Ƶϵ��
% d4=detcoef(C,L,4); % �����Ͼ�
% d3=detcoef(C,L,3);
% d2=detcoef(C,L,2);
% d1=detcoef(C,L,1);
% [thr,sorh,keepapp]=ddencmp('den','wv',s); % ȡС�������ȱʡֵ den��ʾ���� wv��ʾС�� s���ź�
% de_noise=wdencmp('gbl',C,L,'sym8',5,thr,sorh,keepapp);%ִ�н������ 
% ss=de_noise; 
% load('0903_18.mat');
InData=EsfxAng(1:CouxAng,2);
length=CouxAng;%size(esf090318);
[C,L]=wavedec(InData,5,'db5');
%���ź�����ȡС��ϵ����cD1Ϊ����С��ϵ��
cA3=appcoef(C,L,'db5',5);
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
%-----------------'heursure'------------------------
th1_heursur=thselect(cD1,'heursure');
th2_heursur=thselect(cD2,'heursure');
th3_heursur=thselect(cD3,'heursure');
th4_heursur=thselect(cD4,'heursure');
th5_heursur=thselect(cD5,'heursure');
TR_heursure=[th1_heursur,th2_heursur,th3_heursur,th4_heursur,th5_heursur];
%-----------------TPTR = 'sqtwolog', threshold is sqrt(2*log(length(X))).-
th1_sqtwolog=thselect(cD1,'sqtwolog');
th2_sqtwolog=thselect(cD2,'sqtwolog');
th3_sqtwolog=thselect(cD3,'sqtwolog');
th4_sqtwolog=thselect(cD4,'sqtwolog');
th5_sqtwolog=thselect(cD5,'sqtwolog');
TR_sqtwolog=[th1_sqtwolog,th2_sqtwolog,th3_sqtwolog,th4_sqtwolog,th5_sqtwolog];
%--------------'minimaxi', minimax thresholding.-------------------
th1_minimaxi=thselect(cD1,'minimaxi');
th2_minimaxi=thselect(cD2,'minimaxi');
th3_minimaxi=thselect(cD3,'minimaxi');
th4_minimaxi=thselect(cD4,'minimaxi');
th5_minimaxi=thselect(cD5,'minimaxi');
TR_minimax=[th1_minimaxi,th2_minimaxi,th3_minimaxi,th4_minimaxi,th5_minimaxi];
%-----------------------------------------------------------------------------
SORH='h';%����ֵ

%---------denoise----------

%XCΪȥ����ź�
%[CXC,LXC]ΪС���ķֽ�ṹ
%PERF0& PERF2�ǻָ���ѹ���ķ����ٷֱ� 
%��lvd'Ϊ�������õĸ�����ֵ
%'gbl'Ϊ�̶���ֵ
%3Ϊ��ֵ�ĳ���

[XC_rigrsure,CXC_rigrsure,LXC_rigrsure,PERF0_rigrsure,PERF2_rigrsure]=wdencmp('lvd',InData,'db5',5,TR_rigrsure,SORH);
[XC_heursure,CXC_heursure,LXC_heursure,PERF0_heursure,PERF2_heursure]=wdencmp('lvd',InData,'db5',5,TR_heursure,SORH);
[XC_sqtwolog,CXC_sqtwolog,LXC_sqtwolog,PERF0_sqtwolog,PERF2_sqtwolog]=wdencmp('lvd',InData,'db5',5,TR_sqtwolog,SORH);
[XC_minimax,CXC_minimax,LX_minimax,PERF0_minimax,PERF2_minimax]=wdencmp('lvd',InData,'db5',5,TR_minimax,SORH);
%-----------denoise measure  SNR bigger is better MSE smaller is better
N=CouxAng;%length();
input=InData;
de_in_rigrsure=XC_rigrsure;
de_in_heursure=XC_heursure;
de_in_sqtwolog=XC_sqtwolog;
de_in_minimax=XC_minimax;
F=0;
Q=0;
M=0;
% for i=1:N
%     m(i)=(input(i)-de_in_rigrsure(i))^2;
%     t(i)=input(i)^2;
%     F=F+t(i);
%     M=M+m(i);
%     Q=F/M;
% end
% SNR=20*log10(Q);
% MSE=M/N;

% -----------plot
figure;
subplot(3,2,1:2);plot(input);title('ԭʼ�ź�');
subplot(323);plot(de_in_rigrsure);title('��ƫ��Ȼ����(rigrsure)��ֵ����');

subplot(324);plot(de_in_heursure);title('����ʽ(heursure)��ֵ����');
subplot(325);plot(de_in_sqtwolog);title('ȫ�̶ֹ�(sqtwolog)��ֵ����');
subplot(326);plot(de_in_minimax);title('��С����(minimaxi)��ֵ����');
figure;
plot(input);hold on;
plot(de_in_rigrsure,'y');hold on;
xlabel('ʱ��(s)');
ylabel('x������ٶ�(deg/s');
% plot(de_in_heursure,'b');hold on;
% plot(de_in_sqtwolog,'g');hold on;
% plot(de_in_minimax','r');hold on;
legend('����','rigrsure');%,'heursure','sqtwolog','minimax');
WaveRul=fft(InData);
fftWaveRul=fft(de_in_sqtwolog);
figure;
subplot(121);plot(real(WaveRul)/CouxAng*2);title('ԭʼ����FFT�任���');xlabel('Ƶ�ʣ�Hz��');ylabel('��ֵ(deg/s)');
subplot(122);plot(real(fftWaveRul)/CouxAng*2);title('С���ع���FFT�任���');xlabel('Ƶ�ʣ�Hz��');ylabel('��ֵ(deg/s)');