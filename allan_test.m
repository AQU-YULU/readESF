% To compute the Allan deviation for the data in the variable "lt":
% >> lt
% lt = 
%     freq: [1x86400 double]
%     rate: 0.10
% data.freq=de18_db5_8';
% data.rate=5;
% ad = allan(data,[1 10 100 ],'de18_db5_8 data');
deltaT=0.1;
[TauZ,allanZ] = allan_var(meanZAng,deltaT,'Octave');
[TauY,allanY] = allan_var(meanYAng,deltaT,'Octave');
[TauX,allanX] = allan_var(esf090314,deltaT,'Octave');

[TauX1,allanX1] = allan_var(esf090316,deltaT,'Octave');
[TauY1,allanY1] = allan_var(esf090317,deltaT,'Octave');
[TauZ1,allanZ1] = allan_var(meanZacc,deltaT,'Octave');

%%%%%%%%%%%%%%%%%%%%%     notation     %%%%%%%%%%%%%%%%%%%%%
% _________________________________________________________
%     mark 4 kinds of noise
%     slope = -1      T= 3^(1/2) quantization noise
%     slpee = -1/2    T = 1 random walk
%     slpoe = 1/2     T = 3 rate random walk
%     slpoe = 1       T = 2^(1/2) drift rate ramp
% _________________________________________________________    

l_01=[0.1,0.01,0.001,0.0001];%,0.00001];
l_01_2=[0.01,0.001,0.0001,0.00001];
t1=[1,10,100,1000];
l_005=[];
l_105=[];
l_1=[];
a=[1,2^(1/2),3^(1/2),3];


%%%%%%%%%%%%%%%%%%%%%     notation     %%%%%%%%%%%%%%%%%%%%%

%_________________________plot________________________________

%%%%%%%%%%%%%     angle rate     %%%%%%%%%%%%%
figure

loglog(TauZ,allanZ);
title('x.y.z ang Allan Variance');
xlabel('平均时间:sec');                
ylabel('Allan标准差:deg/h');              

grid on;                           
hold on;  
loglog(TauY,allanY);
loglog(TauX,allanX);
loglog(t1,l_01,'--','LineWidth',3);
stem(a,'filled');
legend('Z angle','Y angle','X angle','line a=1','T notitions'); 

%——————————————————————————————————————

figure

loglog(TauZ,sqrt(allanZ));
title('x.y.z sQrt ang Allan Variance');
xlabel('平均时间:sec');                
ylabel('Allan标准差根号值:deg/h');              

grid on;                           
hold on;  
loglog(TauY,allanY);
loglog(TauX,allanX);
loglog(t1,l_01,'--','LineWidth',3);
stem(a,'filled');
legend('Z angle','Y angle','X angle','line a=1','T notitions'); 


%%%%%%%%%%%%%     angle rate     %%%%%%%%%%%%%

%%%%%%%%%%%%%     acc rate     %%%%%%%%%%%%%
figure
loglog(TauX1,allanX1);

xlabel('meantime:sec');                
ylabel('Allan Variance:deg/h');              
title('x.y.z acc Allan Variance');
grid on;                           
hold on;  
loglog(TauY1,allanY1);
loglog(TauZ1,allanZ1);
loglog(t1,l_01_2,'--','LineWidth',3);
stem(a,'filled');
legend('X acc','Y acc','Z acc','line a=1','T notitions'); 


