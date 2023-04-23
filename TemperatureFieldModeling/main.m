index=32+11+14+16*2+4*3+3;
UB=[ones(1,32+11+14)*0.3,ones(1,16*2+4*3)*1,ones(1,3)*0.3];
%UB=ones(1,index)*2;
LB=-UB;

X0=zeros(1,index);
%options = optimoptions(@simulannealbnd,'MaxIterations',150);
options = optimoptions('ga','PlotFcn', @gaplotbestf1,'UseParallel', true,'PopulationSize', 200);
tic
%[X,fval] = simulannealbnd(@sim_All,X0,LB,UB,options);
[X,fval] = ga(@sim_All,index,[],[],[],[],LB,UB,[], options);
toc
% Err=sim_All(X,1);
%close all
Err=sim_All(X,2);
toc
%main2
%sim_All(X,1); 
