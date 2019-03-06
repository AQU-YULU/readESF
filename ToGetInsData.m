esfData=Esf0109;
lenESF=floor(length(esfData)/6);
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
deltaT=0.1/90;
CouxAng=CouxAng-1;
CouyAng=CouyAng-1;
CouzAng=CouzAng-1;
CouxAcc=CouxAcc-1;
CouyAcc=CouyAcc-1;
CouzAcc=CouzAcc-1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%                 db5


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SORH='h';%软阈值

INSdata=[EsfxAng(1:(CouxAcc),2),EsfyAng(1:(CouyAcc),2),EsfzAng(1:(CouzAcc),2),EsfxAcc(1:(CouxAcc),2),EsfyAcc(1:(CouyAcc),2),EsfzAcc(1:(CouzAcc),2)];
lenINSdata=floor(length(INSdata));
XC_rigrsure=zeros(lenINSdata,6);
CXC_rigrsure=zeros(lenINSdata,6);
LXC_rigrsure=zeros(lenINSdata,6);
PERF0_rigrsure=zeros(lenINSdata,6);
PERF2_rigrsure=zeros(lenINSdata,6);
for i=1:6;
    InData=INSdata(1:CouxAcc,i);
    length=CouxAcc;%size(esf090318);
    [C,L]=wavedec(InData,5,'db5');
    %从信号中提取小波系数，cD1为各层小波系数
    cA3=appcoef(C,L,'db5',5);
    cD1=detcoef(C,L,1);
    cD2=detcoef(C,L,2);
    cD3=detcoef(C,L,3);
    cD4=detcoef(C,L,4);
    cD5=detcoef(C,L,5);
    th1_rigrsure=thselect(cD1,'rigrsure');
    th2_rigrsure=thselect(cD2,'rigrsure');
    th3_rigrsure=thselect(cD3,'rigrsure');
    th4_rigrsure=thselect(cD4,'rigrsure');
    th5_rigrsure=thselect(cD5,'rigrsure');
	TR_rigrsure=[th1_rigrsure,th2_rigrsure,th3_rigrsure,th4_rigrsure,th5_rigrsure];
%     [XC_rigrsure(:,i),CXC_rigrsure(:,i),LXC_rigrsure(:,i),PERF0_rigrsure(:,i),PERF2_rigrsure(:,i)]=wdencmp('lvd',InData,'db5',5,TR_rigrsure,SORH);
%     [XC_rigrsure,CXC_rigrsure,LXC_rigrsure,PERF0_rigrsure,PERF2_rigrsure]=wdencmp('lvd',InData,'db5',5,TR_rigrsure,SORH);
    XC_rigrsure(:,i)=wdencmp('lvd',InData,'db5',5,TR_rigrsure,SORH);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%                 姿态角程序


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

QRollPitchYaw=zeros(584,3);
for i=1:584
	QRollPitchYaw(i,:)=IMUupdate(XC_rigrsure(i,:));
end

figure();
title('Roll-Pitch-Yaw');
plot(QRollPitchYaw(1,:));
hold on;grid on;
plot(QRollPitchYaw(2,:));
plot(QRollPitchYaw(3,:));