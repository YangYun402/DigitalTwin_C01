function [lengeds]=sim_T2(tBG,tTarget)
C_=tBG.C_;
T_=tBG.Se2T;
nC=size(C_,1);
nT=size(T_,1);
simT=zeros(tTarget.length,nC);
T_t2=zeros(tTarget.length,nT);
T0=zeros(1,nC);
[~,T_t,~]=StepGet(tBG,tTarget,T0,1,100);
simT(1,:)=getX0(nC,T_t);
for i=1:nT
    T_t2(1,i)=T_t{i,2};
end
t=1;
while t<tTarget.length
    T0=simT(t,:);
    [RPM_t,T_t,tNext]=StepGet(tBG,tTarget,T0,t,100);
    [simT(t+1:tNext,:),is_OK]=solve_SS3(tBG,T_t,RPM_t,T0,tNext-t,1);
    for i=1:nT
        T_t2(t+1:tNext,i)=T_t{i,2};
    end
    if is_OK~=1
        break;
    end
    t=tNext;
end
[lengeds]=plotSim(tBG.OutS,C_,simT,tTarget);
%[lengeds]=Cmp_SimL_Mea(tBG.OutS,C_,simT,tTarget);
end