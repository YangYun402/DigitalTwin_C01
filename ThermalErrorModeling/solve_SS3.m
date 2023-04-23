function [Tout,is_OK]=solve_SS3(tBG,T_t,RPM_t,T0,t,dt)
    nC=size(tBG.C_,1);
    nT=size(T_t,1);
    C=diag([tBG.C_{:,2}]); 
    T=[T_t{:,2}]';
    H=zeros(nC,nC);
    Se=zeros(nC,nT);
    Sf=zeros(nC,1);
    for i=1:size(tBG.R_,1)
        x=FindIn(tBG.C_,tBG.R_{i,1});
        y=FindIn(tBG.C_,tBG.R_{i,2});
        R_t=tBG.R_{i,3};
        if tBG.R_{i,4}>1e-6
            if tBG.R_{i,5}==0
                R_t=R_t+1e6/tBG.R_{i,4}/RPM_t(6);
            else
                R_t=R_t+1e6/tBG.R_{i,4}/tBG.N(tBG.R_{i,5});
            end
        end
        H(x,y)=1/R_t;
        H(y,x)=1/R_t;
    end
    for i=1:size(tBG.Se_,1)
        y=FindIn(tBG.C_,tBG.Se_{i,2});
        x=FindIn(T_t,tBG.Se_{i,1});
        R_t=tBG.Se_{i,3};
        if tBG.Se_{i,4}>1e-6
            if tBG.Se_{i,5}==0
                R_t=R_t+1e6/tBG.Se_{i,4}/RPM_t(6);
            else
                R_t=R_t+1e6/tBG.Se_{i,4}/tBG.N(tBG.Se_{i,5});
            end
        end
        Se(y,x)=1/R_t;
    end
    for i=1:size(tBG.P2RPM,1)
        x=FindIn(tBG.C_,tBG.P2RPM{i,1});
        Sf(x)=RPM_t(tBG.P2RPM{i,2});
    end
    
    A=C\(-diag(sum(H,2)+sum(Se,2))+H);
    B=C\(Se*T+Sf);
    try
        sys=ss(A,B,[],[]);
        [~,~,X]=lsim(sys,ones(1,t/dt+1),0:dt:t,T0);
        Tout=X(1+1/dt:1/dt:t/dt+1,:);
        is_OK=1;
    catch
        Tout=zeros(t/dt,nC);
        is_OK=0;

    end 
end