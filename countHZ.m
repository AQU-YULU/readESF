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
title('x������ٶ�FFT�任���');
xlabel('Ƶ��/Hz');
ylabel('���');
figure;
% subplot(312);
plot(real(YyAng));grid on;hold on;
title('y������ٶ�FFT�任���');
xlabel('Ƶ��/Hz');
ylabel('���');
% subplot(313);
figure;
plot(real(YzAng));grid on;hold on;
title('z������ٶ�FFT�任���');
xlabel('Ƶ��/Hz');
ylabel('���');

figure
plot(EsfxAng(1:CouyAng,2));
grid on;
% % %ֱ�ӷ��ֳ�Ϊ����ͼ�������ǰ�x(n)��N��������Ϊ���������޵����У�ֱ�Ӽ���
% % %x(n)����ɢ����Ҷ�任����X��k)��Ȼ����ȡ���ֵ��ƽ������Ϊ�����׵Ĺ���
% % t=linspace(0,1,1000);
% % signal=4*sin(2*pi*50*t)+5*sin(2*pi*200*t);
% % noise=randn(size(t));
% % symbol=signal+noise;
% % Y=fft(symbol,128);
% % f=1000*(0:127)/128;
% % P1=Y.*conj(Y)/128; %ֱ�ӷ�
% % plot(f,10*log10(P1(1:128)));
% % xlabel('frequency')
% % ylabel('power')
% % title('ֱ�ӷ�')
% % %�������������
% % Fs=1000;% ����Ƶ��
% % n=0:1/Fs:1;
% % xn=cos(2*pi*40*n)+3*cos(2*pi*100*n)+randn(size(n));
% % window=boxcar(length(xn));%���δ�
% % nfft=1024;
% % [Pxx,f]=periodogram(xn,window,nfft,Fs);
% % plot(f,10*log10(Pxx));
% clear;
% fs=500;  %������
% df=0.1;    %Ƶ�ʷֱ���
% N=floor(fs/df)+1;%��������е���
% t=0:1/fs:(N-1)/fs;%��ȡ�źŵ�ʱ���
% f=0:df:fs;%�����׹��Ƶ�Ƶ�ʷֱ��ʺͷ�Χ
% % f=0:df:100;%�����׹��Ƶ�Ƶ�ʷֱ��ʺͷ�Χ
% xt=sin(2*pi*50*5)+2*sin(2*pi*130*t)+randn(1,length(t));
% %��ȡʱ����ϵ���ɢ�ź���������
% 
% %��������ͼ�����й����׹��ƣ�������ó��Ĺ����׺ܲ��⻬����Ӧ�Ĺ���Э����Ƚϴ�
% %���Ӳ�������Ҳ����ʹ����ͼ��ø���ƽ������������ͼ��ȱ�㣬�ں������Ľ���
% Px=abs(fft(xt)).^2/(N^2);%�����׹���
% Pav_tm=sum(xt.^2)/N;%��ʱ������źŹ���
% Pav_fn=sum(Px);%ͨ�������׼����źŹ���
% figure(1)
% subplot(221)   %�����������ܶ�ͼ
% % plot(f,10*log10(Px));
% plot(f,(Px));
% PSD1=sum(Px)
% % xlable('Freq(Hz)');
% % Ylable('PSD(dB)');
% title('����ͼ�ó��Ĺ����׹���');
% 
% %������ͼ���иĽ���˼���ǽ��źŶν��й��ƣ�Ȼ���ٽ���Щ���ƽ������ƽ����
% %�Ӷ���С���Ƶ�Э���ʹ���ƹ�����ͼ���ƽ����
% %�������ǽ�����501����źŷ�3�Σ��ֱ�������ͼ���ƣ�Ȼ��ƽ����
% Px=(abs(fft(xt(1:167))).^2+abs(fft(xt(168:334))).^2+abs(fft(xt(335:501))).^2)/3/((N/3)^2);%��Ϊ����
% Pav_tm=sum(xt.^2)/N;%��ʱ������źŹ���
% Pav_fn=sum(Px);%ͨ�������׼����źŹ���
% subplot(222)   %�����������ܶ�ͼ
% % plot(0:3:fs,10*log10(Px));
% plot(0:3:fs,(Px));
% % xlable('Ƶ�ʣ�Hz)');
% % Ylable('�����ף�dB)');
% title('�ֶι��Ƶó��Ĺ����׹���');
% 
% %���ӷֶ������Խ�һ�����͹��Ƶ�Э���Ȼ��ÿ���е����ݵ�̫�٣��ͻ�ʹ���Ƶ�
% %Ƶ�ʷֱ����½��ܶࡣ�������ź������ܵ���һ���������£����Բ���ʹ�ֶ��໥�ص�
% %�ķ��������ӷֶ������Ӷ�����ÿ�����źŵ������䣬�������ڱ�֤Ƶ�ʷֱ��ʵ�ǰ����
% %��һ�������˹��Ƶ�Э����������У��ӷֶγ��ȵ�һ�봦���зֶε��ӣ�������
% %501���źŷ�Ϊ5�Σ�ÿ��167�㣬�����ص�83��
% Px=(abs(fft(xt(1:167))).^2+abs(fft(xt(83:249))).^2+abs(fft(xt(168:334))).^2+abs(fft(xt(250:416))).^2+abs(fft(xt(335:501))).^2)/5/((N/3)^2);
% %���Ʒ�Ϊ5�Σ���ÿ�εĲ�����������N��1��3
% Pav_tm=sum(xt.^2)/N;%��ʱ������źŹ���
% Pav_fn=sum(Px);%ͨ�������׼����źŹ���
% subplot(223)   %�����������ܶ�ͼ
% % plot(0:3:fs,10*log10(Px));
% plot(0:3:fs,(Px));
% % xlable('Ƶ�ʣ�Hz)');
% % Ylable('�����ף�dB)');
% title('�ص��ֶι��Ƶó��Ĺ����׹���');
% 
% %���ô�������ʱ���źŽ���Ԥ����Ҳ���Խ��͹��Ƶ�Э�����Ҳ�Ǵ�������һ��Ӧ��
% %���档�ڼ�������ͼ��֮ǰ�������ݷֶβ��ӷǾ��δ����纣��������Ȼ�����÷ֶγ���
% %һ��Ļ���ʣ����ܴ�󽵵͹���Э������ַ�����ΪWEICHƽ����������ͼ��
% %���WELCH����������ú�����
% w=hanning(167)';
% w=w*sqrt(167/sum(w.*w));
% Px=(abs(fft(xt(1:167))).^2+abs(fft(xt(83:249))).^2+abs(fft(xt(168:334))).^2+abs(fft(xt(250:416))).^2+abs(fft(xt(335:501))).^2)/5/((N/3)^2);
% %���Ʒ�Ϊ5�Σ���ÿ�εĲ�����������N��1��3
% Pav_tm=sum(xt.^2)/N;%��ʱ������źŹ���
% Pav_fn=sum(Px);%ͨ�������׼����źŹ���
% subplot(224)   %�����������ܶ�ͼ
% % plot(0:3:fs,10*log10(Px));
% plot(0:3:fs,(Px));
% % xlable('Ƶ�ʣ�Hz)');
% % Ylable('�����ף�dB)');
% title('���ú�������WEICHƽ����������ͼ���ó��Ĺ����׹���');
% 
% 
% %�������psd������pwelch�������й����׹��ƣ����ź����в���512��FFT��������Ϊ500��
% %ʹ�ú�����256�㣬�ֶλ������Ϊ128���WELCH ƽ����������ͼ����Ƶ��
% [Px_psd,f_psd]=psd(xt,512,500,hanning(256),128);%����psd����Ƶ�׹���
% [Px_pwelch,f_pwelch]=pwelch(xt,hanning(256),128,512,500);%����pwelch����Ƶ�׹���
% figure(2);
% subplot(211)
% % plot(f_psd,10*log10(Px_psd/(512/2)));
% plot(f_psd,(Px_psd/(512/2)));
% % xlable('Ƶ�ʣ�Hz)');
% % Ylable('�����ף�dB)');
% title('����psd�ó��Ĺ����׹���');
% subplot(212)
% % plot(f_pwelch,10*log10(Px_pwelch/(512/2)));
% plot(f_pwelch,(Px_pwelch/(512/2)));
% % xlable('Ƶ�ʣ�Hz)');
% % Ylable('�����ף�dB)');
% title('����pwelch�ó��Ĺ����׹���');
% %ͨ�������׼����źŹ���
%  Pav_psd=sum(Px_psd)/(512/2);%psd������Ҫ��FFT�������й�һ�����������Ե�����һ��
%  Pav_pwelch=sum(Px_pwelch);%pwelch�Ѿ������˹�һ��