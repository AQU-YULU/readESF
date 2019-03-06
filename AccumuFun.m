function [SumAcc] = AccumuFun(InData,lenData)
SumAcc=zeros(1,lenData+1);
for i = 2:lenData
    SumAcc(i)=InData(i)+ SumAcc(i-1);
end