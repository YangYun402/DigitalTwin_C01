function [Tout,is_OK]=solve_K(tBG,T_t,K_t,RPM_t,T0,tNext)
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
    
    nK=size(K_t,1);
    Cout=zeros(nK,nC);
    Ymea=zeros(nK,1);
    for i=1:nK
        Cout(i,FindIn(tBG.C_,K_t{i,1}))=1;
        Ymea(i)=K_t{i,2};
    end
    
    
    dt=0.001;
    A=C\(-diag(sum(H,2)+sum(Se,2))+H);
    A=eye(nC)+A*dt;
    B=C\(Se*T+Sf)*dt;   
    X=zeros(nC,tNext/dt+1);
    X(:,1)=T0;
    P = eye(nC);  
    Q = 0.9025*eye(nC);                % 过程噪声协方差，估计一个
    R = 0.15*eye(nK);                  % 测量噪声协方差，精度为多少取多少
 
    k = 1;                          % 采样点计数 
    for t = dt:dt:tNext   
        X(:,k+1) = A * X(:,k)+B;      % 卡尔曼公式1
        P = A* P * A' + Q;        % 卡尔曼公式2
        K = P*Cout' /(Cout*P*Cout' + R); % 卡尔曼公式3
        X(:,k+1) = X(:,k+1) + K * (Ymea-Cout*X(:,k+1));    % 卡尔曼公式4
        P = (eye(nC)-K*Cout) * P;                       % 卡尔曼公式5
        k=k+1;
    end
    Tout=X(:,(1:tNext)/dt)';
    is_OK=1;
end