function [gam,sig2] = PSO_LSSVM(train_x,train_y)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
P_number=20;%粒子群个数
C1=2;%初始化学习因子
C2=2;
W_max=0.95;%初始权重
W_min=0.4;%终止权重
K=100;%迭代次数
gammax=300;%定义优化参数的取值范围
gammin=1;
sig2max=200;
sig2min=1;
V_max=25;%定义速度取值
V_min=-V_max; 
P_xy=zeros(P_number,3);%矩阵方式定义微粒的位置和速度
P_v=zeros(P_number,2);
Pbest=zeros(P_number,3);
gbest=zeros(1,3);
%矩阵方式定义每个微粒的最好位置以及每个最优适应度
for i=1:P_number
    Pbest(i,1)=(gammax-gammin)*rand+gammin;
    P_xy(i,1)=Pbest(i,1);%初始化微粒信息
    Pbest(i,2)=(sig2max-sig2min)*rand+sig2min;
    P_xy(i,2)=Pbest(i,2);
    Pbest(i,3)=adaptLSSVM(Pbest(i,1),Pbest(i,2),train_x,train_y);
    P_xy(i,3)=Pbest(i,3);
    P_v(i,1)=V_max*rands(1,1);%初始化微粒的随机速度信息
    P_v(i,2)=V_max*rands(1,1);
end
%矩阵方式定义所有微粒的最好位置以及全局最优适应度
gbest(1,1)=(gammax-gammin)*rand+gammin;
gbest(1,2)=(sig2max-sig2min)*rand+sig2min;
gbest(1,3)=adaptLSSVM(gbest(1,1),gbest(1,2),train_x,train_y);

for j=1:K
    for i=1:P_number
        i=1;
        gam=P_xy(i,1);
        sig2=P_xy(i,2);
        ad=adaptLSSVM(gam,sig2,train_x,train_y);%评价每个微粒的适应度
        P_xy(i,3)=ad;
        if ad<Pbest(i,3)%更新当前微粒的最好位置
            Pbest(i,1)=gam;
            Pbest(i,2)=sig2;
            Pbest(i,3)=ad;
        end
        if Pbest(i,3)<gbest(1,3)%更新全局的最好位置
            gbest(1,1)=Pbest(i,1);
            gbest(1,2)=Pbest(i,2);
            gbest(1,3)=Pbest(i,3);
        end
        %调整微粒速度与位置,同时限定着参数范围
        W=W_min+(W_max-W_min)*(1-j/K);
        P_v(i,1)=W*P_v(i,1)+C1*rand*(Pbest(i,1)-P_xy(i,1))+C2*rand*(gbest(1,1)-P_xy(i,1));
        if(P_v(i,1)>V_max)
            P_v(i,1)=V_max;
        end
        if(P_v(i,1)<V_min)
            P_v(i,1)=V_min;
        end
        P_v(i,2)=W*P_v(i,2)+C1*rand*(Pbest(i,2)-P_xy(i,2))+C2*rand*(gbest(1,2)-P_xy(i,2));
        if(P_v(i,2)>V_max)
            P_v(i,2)=V_max;
        end
        if(P_v(i,2)<V_min)
            P_v(i,2)=V_min;
        end
        P_xy(i,1)=P_xy(i,1)+P_v(i,1);
        if(P_xy(i,1)>gammax)
            P_xy(i,1)=gammax;
        end
        if(P_xy(i,1)<gammin)
            P_xy(i,1)=gammin;
        end
        P_xy(i,2)=P_xy(i,2)+P_v(i,2);
        if(P_xy(i,2)>sig2max)
            P_xy(i,2)=sig2max;
        end
        if(P_xy(i,2)<sig2min)
            P_xy(i,2)=sig2min;
        end
    end
end

end