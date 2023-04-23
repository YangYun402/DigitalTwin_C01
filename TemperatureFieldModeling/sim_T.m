function [Err,is_OK,legends]=sim_T(tBG,tTarget,isPlot)
C_=tBG.C_;
nC=size(C_,1);
dt=1;
simT=zeros(tTarget.length,nC);
T0=zeros(1,nC);
[~,T_t,~]=StepGet(tBG,tTarget,T0,1,100);
simT(1,:)=getX0(nC,T_t);
t=1;
while t<tTarget.length
    T0=simT(t,:);
    [RPM_t,T_t,tNext]=StepGet(tBG,tTarget,T0,t,100);
    [simT(t+1:tNext,:),is_OK]=solve_SS3(tBG,T_t,RPM_t,T0,tNext-t,dt);
    if is_OK~=1
        break;
    end
    t=tNext;
end
if is_OK~=1
    Err=1e6;
    legends={};
elseif isPlot==2
    [Err,legends]=showS(tBG.OutS,C_,simT,tTarget.ts,tTarget.Ts,isPlot);
    
elseif isPlot==1
    [Err,legends]=Cmp_Sim_Mea(tBG.Out2T,C_,simT,tTarget.T,isPlot);
elseif isPlot==0
    legends={};
    
    [Err,~]=Cmp_Sim_Mea(tBG.Out2T,C_,simT,tTarget.T,0);
    
end
end