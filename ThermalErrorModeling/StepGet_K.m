function [RPM_t,T_t,K_t,tNext]=StepGet_K(tBG,tTarget,T0,t,dRPM)
    %确定步长
    maxStep=1;
    tmp=tTarget.speed(t:end);
    i_u=find(tmp>tmp(1)+dRPM,1);
    if size(i_u,1)==0
        i_u=size(tmp,1);
    end
    i_d=find(tmp<tmp(1)-dRPM,1);
    if size(i_d,1)==0
        i_d=size(tmp,1);
    end
    tNext=min(min(i_u,i_d)-1,maxStep)+t;
    
    %计算转速
    speed=mean(tTarget.speed(t:(tNext-1)));
    
    %计算环境温度
    T_t=tBG.Se2T;
    nT=size(T_t,1);
    for i=1:nT
        T_t{i,2}=mean(tTarget.T(t:(tNext-1),tBG.Se2T{i,2}+1));
    end
    %T_t{2,2}=T_t{2,2}-5;
    
     %计算测点温度
    K_t=tBG.K2T;
    nK=size(K_t,1);
    for i=1:nK
        K_t{i,2}=mean(tTarget.T(t:(tNext-1),tBG.K2T{i,2}+1));
    end
    
    %计算轴承功率
    nBearing=size(tBG.K_bearing,1);
    P_bearing=zeros(1,nBearing);
    for i=1:nBearing
        x=FindIn(tBG.C_,tBG.K_bearing{i,1});
        T=T0(x);
        P_bearing(i)=PowerBearing3(speed,T,tBG.K_bearing{i,2});
    end

    %计算电机功率
    nMotor=size(tBG.K_motor,1);
    P_motor=zeros(1,nMotor);
    for i=1:nMotor
        P_motor(i)=polyval(tBG.K_motor{i,2},speed);
    end
    
    %计算强制对流系数
    h=polyval(tBG.K_h,speed);
    %h=sqrt(speed);
    RPM_t=abs([speed,P_bearing,P_motor,h]);
end