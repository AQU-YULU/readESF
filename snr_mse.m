%load('de18_bior3.5_8.mat');
length=size(esf090316);
N=length(2);
de_in=de16_sym7_8;
input=esf090316;
F=0;
Q=0;
M=0;
for i=1:N
    m(i)=(input(i)-de_in(i))^2;
    t(i)=de_in(i)^2;
    F=F+t(i);
    M=M+m(i);
    Q=F/M;
end
SNR=10*log10(Q);
MSE=M/N;