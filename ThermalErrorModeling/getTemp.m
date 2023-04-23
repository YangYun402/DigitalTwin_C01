function Temp=getTemp(in)
global dtBG;

%计算转速
t=in(1);
speed=in(2);
T0=in(6:30);
%计算环境温度
T_t=dtBG.Se2T;
nT=size(T_t,1);
for i=1:nT
    T_t{i,2}=in(dtBG.Se2T{i,2});
end
    
%计算测点温度
K_t=dtBG.K2T;
nK=size(K_t,1);
for i=1:nK
    K_t{i,2}=in(dtBG.K2T{i,2}+1);
end

%计算电机功率
nMotor=size(dtBG.K_motor,1);
P_motor=zeros(1,nMotor);
for i=1:nMotor
    P_motor(i)=polyval(dtBG.K_motor{i,2},speed);
end
    
%计算强制对流系数
h=polyval(dtBG.K_h,speed);

for tstep=1:1:t
    %计算轴承功率
    nBearing=size(dtBG.K_bearing,1);
    P_bearing=zeros(1,nBearing);
    for i=1:nBearing
        x=FindIn(dtBG.C_,dtBG.K_bearing{i,1});
        T=T0(x);
        P_bearing(i)=PowerBearing3(speed,T,dtBG.K_bearing{i,2});
    end

    RPM_t=abs([speed,P_bearing,P_motor,h]);

    %[simT,~]=solve_K(dtBG,T_t,K_t,RPM_t,T0,1);
    [simT,~]=solve_SS3(dtBG,T_t,RPM_t,T0,1,1);
    T0=simT(end,:);
end
Temp=T0;
plotTempField([Temp,[T_t{:,2}]],[dtBG.C_(:,1);dtBG.Se2T(:,1)]);
end