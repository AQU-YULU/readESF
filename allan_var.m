function [Tau,allan] = allan_var(data,deltaT,mode)
%���ñ�׼Allan��������ȶ���
%dataΪ�Ӳ����ݣ�deltaTΪ�������  
num = length(data);
if mode=='Octave'
    N=0;
    while 1
        if floor(num/(2^N))<8     %�����ȶ��ȵĸ�������ȡ������С��8ʱ�Ͳ��ټ���
            break;
        end
        N=N+1;
    end
    Tau=zeros(1,N);allan=zeros(1,N);sam=zeros(1,N);
    for i=1:N
        n=2^(i-1);
        sam(i)=floor(num/n);
        sum=0;
        Tau(i)=deltaT*n;
        for k=1:sam(i)-2
            item=(data(n*(k+1)+1)-2*data(n*k+1)+data(n*(k-1)+1))^2;
            sum=sum+item;
        end
        allan(i)=sqrt(sum/(2*(sam(i)-2)*(Tau(i)^2)));
    end        
end

if  mode=='Decade'
%     T = [1 2 4 10 20  40 100 200 400  1000 2000 4000 10000 20000 40000 100000 ];
    T = [1 2 4 10 24 40 100 200 400 24*30 1000];
    N=1;
    while 1
        if num/T(N)<3
            break;
        end
        N=N+1;
    end
    Tau=zeros(1,N-1);allan=zeros(1,N-1);sam=zeros(1,N-1);
    for i=1:N-1
        n=T(i);
        sam(i)=floor(num/n);
        sum=0;
        Tau(i)=deltaT*n;
        for k=1:sam(i)-2
            item=(data(n*(k+1)+1)-2*data(n*k+1)+data(n*(k-1)+1))^2;
            sum=sum+item;
        end
        allan(i)=sqrt(sum/(2*(sam(i)-2)*(Tau(i)^2)));
    end        
end
