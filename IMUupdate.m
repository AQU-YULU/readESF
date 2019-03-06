function [QRollPitchYaw] =IMUupdate(InDataIns)
gx=InDataIns(1);
gy=InDataIns(2);
gz=InDataIns(3);
ax=InDataIns(4);
ay=InDataIns(5);
az=InDataIns(6);
%g�������ǣ�a��Ӽ�

Kp=0.05;%.050;                        %// �����KpKi�����ڵ������ٶȼ����������ǵ��ٶ�
Ki=0.05;%.08;                        
halfT=0.05;             %// �������ڵ�һ�룬���������Ԫ��΢�ַ���ʱ���������
%// ��ʼ��̬��Ԫ��������ƪ�����ᵽ�ı任��Ԫ����ʽ����
q0 = 1;
q1 = 0;
q2 = 0;
q3 = 0;    
%  //��ǰ�ӼƲ�õ��������ٶ��������ϵķ���
exInt = 0;
eyInt = 0;
ezInt = 0;   
% ���õ�ǰ��̬��������������������ϵķ��������Ļ���

%   float q0temp,q1temp,q2temp,q3temp;//��Ԫ���ݴ���������΢�ַ���ʱҪ��
%   float norm; //ʸ����ģ����Ԫ���ķ���
%   float vx, vy, vz;//��ǰ��̬��������������������ϵķ���
%   float ex, ey, ez;//��ǰ�ӼƲ�õ��������ٶ��������ϵķ���
%               //���õ�ǰ��̬��������������������ϵķ��������
% 
%   // �Ȱ���Щ�õõ���ֵ���
q0q0 = q0*q0;
q0q1 = q0*q1;
q0q2 = q0*q2;
q1q1 = q1*q1;
q1q3 = q1*q3;
q2q2 = q2*q2;
q2q3 = q2*q3;
q3q3 = q3*q3;      
% //�Ӽƴ�����������״̬ʱ��������̬���㣬��Ϊ�������ĸ���������
  if(ax*ay*az==0)
        return;
  end
  norm = sqrt(ax*ax + ay*ay + az*az);%//��λ�����ٶȼƣ�
  ax = ax /norm;%// �������������Ҳ����Ҫ�޸�KP��������Ϊ�����һ����
  ay = ay / norm;
  az = az / norm;
%   //�õ�ǰ��̬������������������ϵķ�����
%   //�ο�����nϵת������������bϵ������Ԫ����ʾ�ķ������Ҿ�������м��ǣ�����һ�����ᵽ��
  vx = 2*(q1q3 - q0q2);        
  vy = 2*(q0q1 + q2q3);
  vz = q0q0 - q1q1 - q2q2 + q3q3 ;
%   //�����õ������������������������������Ա�ʾ��һ���
%   //ԭ�����������Ϊ���������ǵ�λ������sin0����0
%   //����Ҫ�Ǽн���180����~�����û���
  ex = (ay*vz - az*vy) ;                                                                  
  ey = (az*vx - ax*vz) ;
  ez = (ax*vy - ay*vx) ;

  exInt = exInt + ex * Ki;                                           %//�������л���
  eyInt = eyInt + ey * Ki;
  ezInt = ezInt + ez * Ki;
  %// adjusted gyroscope measurements
  gx = gx + Kp*ex + exInt;  %//�����PI�󲹳��������ǣ����������Ư��
  gy = gy + Kp*ey + eyInt;
  gz = gz + Kp*ez + ezInt;    %//�����gz����û�й۲��߽��н��������Ư�ƣ����ֳ����ľ��ǻ����������Լ�
  %���������̬�ĸ��£�Ҳ������Ԫ��΢�ַ��̵����
  q0temp=q0;%//�ݴ浱ǰֵ���ڼ���
  q1temp=q1;%//���ϴ�������㷨���û��ע��������⣬�ڴ˸���
  q2temp=q2;
  q3temp=q3;
  %//����һ�ױϿ��ⷨ�����֪ʶ�ɲμ���������������Ե���ϵͳ��P212
  q0 = q0temp + (-q1temp*gx - q2temp*gy -q3temp*gz)*halfT;
  q1 = q1temp + (q0temp*gx + q2temp*gz -q3temp*gy)*halfT;
  q2 = q2temp + (q0temp*gy - q1temp*gz +q3temp*gx)*halfT;
  q3 = q3temp + (q0temp*gz + q1temp*gy -q2temp*gx)*halfT;
  %//��λ����Ԫ���ڿռ���תʱ�������죬������ת�Ƕȣ����������Դ�����������任
  norm = sqrt(q0*q0 + q1*q1 + q2*q2 + q3*q3);
  q0 = q0 / norm;
  q1 = q1 / norm;
  q2 = q2 / norm;
  q3 = q3 / norm;
%   //��Ԫ����ŷ���ǵ�ת������ʽ�Ƶ�������һ
%   //����YAW��������ڼ��ٶȼƶ���û���������ã���˴˴�ֱ���������ǻ��ִ���
  Q_AngleZ = gz; %// yaw
  Q_AngleY = asin(-2 * q1 * q3 + 2 * q0* q2)*57.3;% // pitch
  Q_AngleX = atan2(2 * q2 * q3 + 2 * q0 * q1,-2 * q1 * q1 - 2 * q2* q2 + 1)* 57.3; %// roll
  QRollPitchYaw=[Q_AngleX,Q_AngleY,Q_AngleZ];
% --------------------- 
% ���ߣ�ѩ�ɽ� 
% ��Դ��CSDN 
% ԭ�ģ�https://blog.csdn.net/u010097644/article/details/70881395 
% ��Ȩ����������Ϊ����ԭ�����£�ת���븽�ϲ������ӣ�